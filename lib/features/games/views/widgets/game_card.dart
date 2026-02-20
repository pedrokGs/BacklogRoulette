import 'package:backlog_roulette/features/games/models/models/game/game.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class GameCard extends StatelessWidget {
  final Game game;
  final VoidCallback? onTap;
  const GameCard({super.key, required this.game, this.onTap});

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1.0,
      child: Card(
        margin: EdgeInsets.zero,
        clipBehavior: Clip.antiAlias,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        child: InkWell(
          onTap: onTap,
          child: Stack(
            children: [
              Hero(
                tag: 'game-cover-${game.id}',
                child: _buildImage(game.igdbCoverUrl, backupUrl: game.coverUrl),
              ),

              Positioned.fill(
                child: Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [Colors.transparent, Colors.black87],
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                    ),
                  ),
                ),
              ),

              Positioned(
                bottom: 8,
                left: 8,
                right: 8,
                child: Text(
                  game.name,
                  style: GoogleFonts.lato(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 12,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildImage(String url, {String? backupUrl, bool isBlur = false}) {
    return CachedNetworkImage(
      imageUrl: url,
      fit: BoxFit.cover,
      width: double.infinity,
      height: double.infinity,
      alignment: Alignment.center,
      color: isBlur ? Colors.black.withValues(alpha: 0.3) : null,
      colorBlendMode: isBlur ? BlendMode.darken : null,
      placeholder: (context, url) => Container(color: Colors.grey[900]),
      // Se a imagem principal falhar, tenta a reserva
      errorWidget: (context, url, error) {
        if (backupUrl != null && backupUrl.isNotEmpty) {
          return CachedNetworkImage(
            imageUrl: backupUrl,
            fit: BoxFit.cover,
            placeholder: (context, url) => Container(color: Colors.grey[900]),
            errorWidget: (context, url, error) =>
                const Icon(Icons.videogame_asset),
          );
        }
        return const Icon(Icons.videogame_asset);
      },
    );
  }
}
