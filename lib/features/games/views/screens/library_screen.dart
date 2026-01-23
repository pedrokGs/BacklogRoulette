import 'package:backlog_roulette/features/games/viewmodels/library/library_screen_state.dart';
import 'package:backlog_roulette/features/games/views/widgets/game_card.dart';
import 'package:backlog_roulette/di/notifiers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:go_router/go_router.dart';

class LibraryScreen extends ConsumerStatefulWidget {
  const LibraryScreen({super.key});

  @override
  ConsumerState createState() => _SearchGamesState();
}

class _SearchGamesState extends ConsumerState<LibraryScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(libraryStateNotifier);

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(2),
          child: Center(
            child: Column(
              children: [
                Text("Recentes", style: Theme.of(context).textTheme.titleLarge),
                Container(
                  width: MediaQuery.of(context).size.width * 1,
                  height: MediaQuery.of(context).size.height * 0.25,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16.0),
                    color: Theme.of(context).colorScheme.primaryContainer,
                  ),
                  child: state.when(
                    initial: () =>
                        Center(child: Text("Wow, está vazio por aqui!")),
                    error: (error) {
                      showDialog(
                        context: context,
                        builder: (context) => Dialog(
                          child: Column(
                            children: [
                              Text("Ocorreu um Erro!"),
                              Icon(Icons.warning),
                              Text(error),
                              Row(
                                children: [
                                  ElevatedButton(
                                    onPressed: () => context.pop(),
                                    child: Text("Ok"),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      );
                      return Center(child: Text("Wow, está vazio por aqui!"));
                    },
                    loading: () => Center(child: CircularProgressIndicator()),
                    loaded: (games) => Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: CarouselSlider(
                        items: games
                            .map(
                              (e) => Padding(
                                padding: EdgeInsets.all(2),
                                child: GameCard(game: e),
                              ),
                            )
                            .toList(),
                        options: CarouselOptions(
                          aspectRatio: 2,
                          viewportFraction: 0.6,
                          enableInfiniteScroll: false,

                          animateToClosest: true,
                        ),
                      ),
                    ),
                  ),
                ),
                ElevatedButton(
                  onPressed: () => ref
                      .read(libraryStateNotifier.notifier)
                      .searchGamesForUserId('76561199000388093'),
                  child: Text('Pesquisar'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
