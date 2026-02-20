import 'package:backlog_roulette/core/l10n/app_localizations.dart';
import 'package:backlog_roulette/features/games/games_di.dart';
import 'package:backlog_roulette/features/games/models/models/game/game.dart';
import 'package:backlog_roulette/features/games/viewmodels/library/library_state.dart';
import 'package:backlog_roulette/features/games/viewmodels/roulette/roulette_state.dart';
import 'package:backlog_roulette/features/games/views/widgets/mood_selector_tab.dart';
import 'package:backlog_roulette/features/games/views/widgets/roulette_wheel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class RouletteScreen extends ConsumerStatefulWidget {
  const RouletteScreen({super.key});

  @override
  ConsumerState<RouletteScreen> createState() => _RouletteScreenState();
}

class _RouletteScreenState extends ConsumerState<RouletteScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    _tabController.addListener(() {
      if (_tabController.index == 1) {
        final libraryState = ref.read(libraryNotifier);
        final List<Game> allGames = libraryState.maybeWhen(
          loaded: (games) => games,
          orElse: () => [],
        );
        ref.read(rouletteNotifier.notifier).prepareRoulette(allGames);
      }
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final libraryState = ref.watch(libraryNotifier);

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(24, 24, 24, 16),
              child: Container(
                height: 54,
                decoration: BoxDecoration(
                  color: Theme.of(context).cardColor,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.05),
                      blurRadius: 15,
                      offset: const Offset(0, 5),
                    ),
                  ],
                ),
                child: TabBar(
                  controller: _tabController,
                  indicatorSize: TabBarIndicatorSize.tab,
                  dividerColor: Colors.transparent,
                  indicator: BoxDecoration(
                    color: Theme.of(context).colorScheme.primaryContainer,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  labelColor: Theme.of(context).colorScheme.onPrimaryContainer,
                  labelStyle: const TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: 15,
                  ),
                  unselectedLabelColor: Colors.grey[500],
                  unselectedLabelStyle: const TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 15,
                  ),
                  tabs: [
                    Tab(
                      text: AppLocalizations.of(
                        context,
                      )!.roulette_screen_mood_tab_title,
                    ),
                    Tab(
                      text: AppLocalizations.of(
                        context,
                      )!.roulette_screen_roulette_tab_title,
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              child: TabBarView(
                controller: _tabController,
                children: [
                  libraryState.when(
                    initial: () => _buildEmptyState(
                      AppLocalizations.of(
                        context,
                      )!.roulette_screen_initial_state_label,
                      Icons.videogame_asset_off_outlined,
                    ),
                    loading: () => _buildLoadingState(),
                    error: (msg) => _buildEmptyState(msg, Icons.error_outline),
                    loaded: (games) => const MoodSelectorTab(),
                  ),
                  Consumer(
                    builder: (context, ref, child) {
                      return ref
                          .watch(rouletteNotifier)
                          .maybeWhen(
                            spinning: (selectedGames, weights) => RouletteWheel(
                              games: selectedGames,
                              weights: weights,
                            ),
                            error: (msg) => _buildEmptyState(
                              AppLocalizations.of(
                                context,
                              )!.roulette_empty_library_text,
                              Icons.error_outline,
                            ),
                            orElse: () => _buildEmptyState(
                              AppLocalizations.of(
                                context,
                              )!.roulette_screen_no_mood_state_label,
                              Icons.touch_app_outlined,
                            ),
                          );
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLoadingState() {
    return Center(
      child: LoadingAnimationWidget.staggeredDotsWave(
        color: Theme.of(context).colorScheme.primary,
        size: 50,
      ),
    );
  }

  Widget _buildEmptyState(String message, IconData icon) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 64, color: Colors.grey.withValues(alpha: 0.5)),
            const SizedBox(height: 16),
            Text(
              message,
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.grey[600], fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
}
