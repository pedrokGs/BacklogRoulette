import 'package:backlog_roulette/core/l10n/app_localizations.dart';
import 'package:backlog_roulette/core/router/route_names.dart';
import 'package:backlog_roulette/features/games/games_di.dart';
import 'package:backlog_roulette/features/games/viewmodels/library/library_state.dart';
import 'package:backlog_roulette/features/games/views/widgets/game_card.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class LibraryScreen extends ConsumerStatefulWidget {
  const LibraryScreen({super.key});

  @override
  ConsumerState createState() => _LibraryScreenState();
}

class _LibraryScreenState extends ConsumerState<LibraryScreen> {
  // Controller para o ID da Steam (busca na API)
  final TextEditingController _steamIdController = TextEditingController(
    text: '76561199000388093',
  ); // Valor teste

  String _gameFilter = '';

  @override
  void dispose() {
    _steamIdController.dispose();
    super.dispose();
  }

  void _performSteamImport() {
    HapticFeedback.lightImpact();
    if (_steamIdController.text.isNotEmpty) {
      FocusScope.of(context).unfocus();
      setState(() {
        _gameFilter = '';
      });
      ref
          .read(libraryNotifier.notifier)
          .searchGamesForUserId(_steamIdController.text);
    }
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(libraryNotifier);

    ref.listen<LibraryState>(libraryNotifier, (previous, next) {
      next.maybeWhen(
        error: (message) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(message),
              backgroundColor: Colors.redAccent,
              behavior: SnackBarBehavior.floating,
            ),
          );
        },
        orElse: () {},
      );
    });

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: SafeArea(
          child: CustomScrollView(
            slivers: [
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 24.0,
                    vertical: 32.0,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        AppLocalizations.of(context)!.library_screen_title,
                        style: GoogleFonts.poppins(
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        AppLocalizations.of(context)!.library_screen_subtitle,
                        style: TextStyle(fontSize: 16, color: Colors.grey[600]),
                      ),
                    ],
                  ),
                ),
              ),

              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20.0,
                    vertical: 10,
                  ),
                  child: _buildSteamImportBar(),
                ),
              ),

              SliverToBoxAdapter(child: SizedBox(height: 24)),

              SliverFillRemaining(
                hasScrollBody: false,
                child: state.when(
                  initial: () => _buildEmptyState(
                    AppLocalizations.of(
                      context,
                    )!.library_screen_initial_state_label,
                  ),
                  loading: () => _buildLoadingState(),
                  error: (_) => _buildEmptyState(
                    AppLocalizations.of(
                      context,
                    )!.library_screen_error_state_label,
                  ),
                  loaded: (games) {
                    final filteredGames = games.where((game) {
                      return game.name.toLowerCase().contains(
                        _gameFilter.toLowerCase(),
                      );
                    }).toList();

                    return Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 24.0),
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  Icon(
                                    Icons.sports_esports,
                                    color: Theme.of(
                                      context,
                                    ).colorScheme.primary,
                                  ),
                                  const SizedBox(width: 8),
                                  Text(
                                    AppLocalizations.of(
                                      context,
                                    )!.library_screen_games_count_label(
                                      filteredGames.length,
                                    ),
                                    style: const TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 16),
                              _buildGameSearch(),
                            ],
                          ),
                        ),

                        const SizedBox(height: 20),

                        if (filteredGames.isEmpty)
                          Expanded(
                            child: _buildEmptyState(
                              AppLocalizations.of(
                                context,
                              )!.library_screen_no_games_found_label,
                            ),
                          )
                        else
                          CarouselSlider.builder(
                            itemCount: filteredGames.length,
                            itemBuilder: (context, index, realIndex) {
                              final game = filteredGames[index];

                              return AnimatedSwitcher(
                                duration: const Duration(milliseconds: 400),
                                transitionBuilder:
                                    (
                                      Widget child,
                                      Animation<double> animation,
                                    ) {
                                      return FadeTransition(
                                        opacity: animation,
                                        child: ScaleTransition(
                                          scale: animation,
                                          child: child,
                                        ),
                                      );
                                    },
                                child: Container(
                                  key: ValueKey(game.id),
                                  margin: const EdgeInsets.symmetric(
                                    horizontal: 5,
                                  ),
                                  decoration: BoxDecoration(
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.black.withValues(
                                          alpha: 0.2,
                                        ),
                                        blurRadius: 10,
                                        offset: const Offset(0, 5),
                                      ),
                                    ],
                                  ),
                                  child: GameCard(
                                    game: game,
                                    onTap: () => context.pushNamed(
                                      RouteNames.gameDetails,
                                      pathParameters: {"gameId": game.id},
                                    ),
                                  ),
                                ),
                              );
                            },
                            options: CarouselOptions(
                              height: 350,
                              viewportFraction: 0.65,
                              autoPlay: _gameFilter.isEmpty,
                              enlargeCenterPage: true,
                              enableInfiniteScroll: false,
                              enlargeFactor: 0.25,
                              scrollPhysics: const BouncingScrollPhysics(),
                            ),
                          ),
                      ],
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildGameSearch() {
    return Container(
      height: 50,
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor.withValues(alpha: 0.5),
        borderRadius: BorderRadius.circular(15),
        border: Border.all(
          color: Theme.of(context).dividerColor.withValues(alpha: 0.1),
        ),
      ),
      child: TextField(
        onChanged: (value) {
          setState(() {
            _gameFilter = value;
          });
        },
        style: TextStyle(fontSize: 14),
        decoration: InputDecoration(
          contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 14),
          hintText: AppLocalizations.of(
            context,
          )!.library_screen_search_hinttext,
          hintStyle: TextStyle(color: Colors.grey[500], fontSize: 14),
          prefixIcon: Icon(
            Icons.filter_list,
            size: 20,
            color: Colors.grey[400],
          ),
          suffixIcon: _gameFilter.isNotEmpty
              ? IconButton(
                  icon: Icon(Icons.close, size: 18),
                  onPressed: () => setState(() {
                    _gameFilter = '';
                  }),
                )
              : null,
          border: InputBorder.none,
        ),
      ),
    );
  }

  Widget _buildSteamImportBar() {
    final colorScheme = Theme.of(context).colorScheme;

    return Container(
      height: 60,
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.08),
            blurRadius: 20,
            offset: Offset(0, 5),
          ),
        ],
      ),
      padding: EdgeInsets.symmetric(horizontal: 8),
      child: Row(
        children: [
          const SizedBox(width: 12),
          Icon(Icons.cloud_download_outlined, color: Colors.grey[400]),
          const SizedBox(width: 12),
          Expanded(
            child: TextField(
              controller: _steamIdController,
              style: TextStyle(fontWeight: FontWeight.w500),
              decoration: InputDecoration(
                hintText: AppLocalizations.of(
                  context,
                )!.library_screen_steam_id_import_hinttext,
                labelText: "Steam ID",
                floatingLabelBehavior: FloatingLabelBehavior.always,
                hintStyle: TextStyle(color: Colors.grey[400]),
                border: InputBorder.none,
                isDense: true,
              ),
              onSubmitted: (_) => _performSteamImport(),
            ),
          ),
          const SizedBox(width: 6),
          Container(
            margin: EdgeInsets.symmetric(vertical: 8),
            decoration: BoxDecoration(
              color: colorScheme.primaryContainer,
              borderRadius: BorderRadius.circular(14),
            ),
            child: IconButton(
              icon: Icon(
                Icons.arrow_forward,
                color: colorScheme.onPrimaryContainer,
              ),
              onPressed: _performSteamImport,
              tooltip: AppLocalizations.of(
                context,
              )!.library_screen_steam_id_import_button_tooltip,
            ),
          ),
        ],
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

  Widget _buildEmptyState(String message) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.videogame_asset_off_outlined,
              size: 64,
              color: Colors.grey.withValues(alpha: 0.5),
            ),
            SizedBox(height: 16),
            Text(
              message,
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.grey[600]),
            ),
          ],
        ),
      ),
    );
  }
}
