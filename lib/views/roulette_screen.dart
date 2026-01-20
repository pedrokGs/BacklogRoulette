import 'package:backlog_roulette/common/widgets/game_checkbox.dart';
import 'package:backlog_roulette/common/widgets/roulette_card.dart';
import 'package:backlog_roulette/common/widgets/roulette_wheel.dart';
import 'package:backlog_roulette/di/notifiers.dart';
import 'package:backlog_roulette/models/game/game.dart';
import 'package:backlog_roulette/viewmodels/library/library_screen_state.dart';
import 'package:backlog_roulette/viewmodels/roulette/roulette_screen_state.dart';
import 'package:carousel_slider/carousel_slider.dart';
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
    // Escuta a biblioteca para popular a lista da Aba 1
    final libraryState = ref.watch(libraryStateNotifier);

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
                ref.read(rouletteStateNotifier.notifier).prepareRoulette(allGames);
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
            // --- ABA 1: SELEÇÃO ---
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
                return ref.watch(rouletteStateNotifier).maybeWhen(
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

