import 'package:backlog_roulette/features/games/games_di.dart';
import 'package:backlog_roulette/features/games/models/models/game/game.dart';
import 'package:backlog_roulette/features/games/viewmodels/library/library_state.dart';
import 'package:backlog_roulette/features/games/viewmodels/roulette/roulette_state.dart';
import 'package:backlog_roulette/features/games/views/widgets/game_checkbox.dart';
import 'package:backlog_roulette/features/games/views/widgets/roulette_wheel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class RouletteScreen extends ConsumerStatefulWidget {
  const RouletteScreen({super.key});

  @override
  ConsumerState createState() => _RouletteScreenState();
}
class _RouletteScreenState extends ConsumerState<RouletteScreen> {

  @override
  Widget build(BuildContext context) {
    final libraryState = ref.watch(libraryNotifier);

    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: Text("Sorteio"),
          bottom: TabBar(
            onTap: (index) {
              if (index == 1) {
                final List<Game> allGames = libraryState.maybeWhen(
                  loaded: (games) => games,
                  orElse: () => [],
                );
                ref.read(rouletteNotifier.notifier).prepareRoulette(allGames);
              }
            },
            tabs: [
              Tab(icon: Icon(Icons.list), text: "Selecionar"),
              Tab(icon: Icon(Icons.casino), text: "Roleta"),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            libraryState.when(
              initial: () => Center(child: Text("Carregue sua biblioteca primeiro")),
              loading: () => Center(child: CircularProgressIndicator()),
              error: (msg) => Center(child: Text(msg)),
              loaded: (games) => ListView.builder(
                itemCount: games.length,
                itemBuilder: (context, index) {
                  return GameCheckbox(game: games[index]);
                },
              ),
            ),

            Consumer(
              builder: (context, ref, child) {
                return ref.watch(rouletteNotifier).maybeWhen(
                  spinning: (selectedGames) => RouletteWheel(games: selectedGames),

                  error: (msg) => Center(child: Text(msg)),
                  orElse: () => Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.touch_app, size: 60, color: Colors.grey),
                        SizedBox(height: 10),
                        Text("Selecione jogos na aba anterior\ne volte aqui!", textAlign: TextAlign.center),
                      ],
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

