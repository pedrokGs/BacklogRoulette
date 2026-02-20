import 'dart:ui';

import 'package:backlog_roulette/core/l10n/app_localizations.dart';
import 'package:backlog_roulette/features/games/games_di.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

class GameDetailsScreen extends ConsumerWidget {
  final String gameId;
  const GameDetailsScreen({super.key, required this.gameId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final game = ref.watch(gameByIdProvider(gameId));
    if (game == null) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }

    return Scaffold(
      body: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: [
          SliverAppBar(
            expandedHeight: 450,
            pinned: true,
            stretch: true,
            backgroundColor: Theme.of(context).scaffoldBackgroundColor,
            flexibleSpace: FlexibleSpaceBar(
              stretchModes: const [
                StretchMode.zoomBackground,
                StretchMode.blurBackground,
              ],
              background: Stack(
                fit: StackFit.expand,
                children: [
                  Hero(
                    tag: 'game-cover-${game.id}',
                    child: CachedNetworkImage(
                      imageUrl: game.igdbCoverUrl.isNotEmpty
                          ? game.igdbCoverUrl
                          : game.coverUrl,
                      fit: BoxFit.cover,
                    ),
                  ),
                  const DecoratedBox(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [Colors.transparent, Colors.black87],
                        stops: [0.6, 1.0],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            leading: Padding(
              padding: const EdgeInsets.all(6.0),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(360),
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                  child: Container(
                    color: Colors.black.withValues(alpha: 0.3),
                    child: IconButton(
                      tooltip: AppLocalizations.of(
                        context,
                      )!.game_details_screen_back_button_tooltip,
                      icon: const Icon(
                        Icons.chevron_left,
                        color: Colors.white,
                        size: 28,
                      ),
                      onPressed: () => context.pop(),
                    ),
                  ),
                ),
              ),
            ),
          ),

          SliverToBoxAdapter(
            child: Transform.translate(
              offset: const Offset(0, -30),
              child: Container(
                decoration: BoxDecoration(
                  color: Theme.of(context).scaffoldBackgroundColor,
                  borderRadius: const BorderRadius.vertical(
                    top: Radius.circular(32),
                  ),
                ),
                padding: const EdgeInsets.symmetric(
                  horizontal: 24,
                  vertical: 32,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      game.name,
                      style: GoogleFonts.poppins(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        letterSpacing: -0.5,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Wrap(
                      spacing: 8,
                      children: game.genres
                          .map((genre) => _buildGenreChip(context, genre))
                          .toList(),
                    ),

                    const SizedBox(height: 32),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        _buildStatItem(
                          context,
                          Icons.timer_outlined,
                          "${(game.playtime / 60).toStringAsFixed(1)}h",
                          AppLocalizations.of(
                            context,
                          )!.game_details_screen_playtime_label,
                        ),
                        _buildStatItem(
                          context,
                          Icons.videogame_asset_outlined,
                          game.gameState.name.toUpperCase(),
                          AppLocalizations.of(
                            context,
                          )!.game_details_screen_game_state_label,
                        ),
                        _buildStatItem(
                          context,
                          Icons.calendar_today_outlined,
                          game.steamAppId != null ? "Steam" : "???",
                          AppLocalizations.of(
                            context,
                          )!.game_details_screen_source_label,
                        ),
                      ],
                    ),

                    const SizedBox(height: 40),

                    Text(
                      AppLocalizations.of(
                        context,
                      )!.game_details_screen_summary_label,
                      style: GoogleFonts.poppins(
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 12),
                    Text(
                      game.summary,
                      style: TextStyle(
                        fontSize: 15,
                        color: Colors.grey[400],
                        height: 1.6,
                      ),
                    ),

                    const SizedBox(height: 100),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {},
        tooltip: AppLocalizations.of(
          context,
        )!.game_details_screen_edit_status_button_tooltip,
        label: Text(
          AppLocalizations.of(
            context,
          )!.game_details_screen_edit_status_button_label,
        ),
        icon: const Icon(Icons.edit_outlined),
        backgroundColor: Theme.of(context).colorScheme.primary,
      ),
    );
  }

  Widget _buildGenreChip(BuildContext context, String label) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.primary.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: Theme.of(context).colorScheme.primary.withValues(alpha: 0.3),
        ),
      ),
      child: Text(
        label,
        style: TextStyle(
          color: Theme.of(context).colorScheme.primary,
          fontSize: 12,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget _buildStatItem(
    BuildContext context,
    IconData icon,
    String value,
    String label,
  ) {
    return Column(
      children: [
        Icon(icon, color: Colors.grey[500], size: 24),
        const SizedBox(height: 8),
        Text(
          value,
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
        ),
        Text(label, style: TextStyle(color: Colors.grey[600], fontSize: 12)),
      ],
    );
  }
}
