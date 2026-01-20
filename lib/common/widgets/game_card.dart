import 'package:backlog_roulette/di/service_providers.dart';
import 'package:backlog_roulette/models/game/game.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';

class GameCard extends ConsumerWidget {
  final Game game;
  final VoidCallback? onTap;
  const GameCard({super.key, required this.game, this.onTap});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Tenta buscar a capa HD se tiver um steamAppId
    final igdbCover = game.steamAppId != null
        ? ref.watch(gameCoverProvider(game))
        : null;

    return AspectRatio(
      aspectRatio: 1.0,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: Card(
          margin: EdgeInsets.zero,
          child: Stack(
            children: [
              igdbCover?.when(
                data: (hdUrl) => _buildImage(hdUrl ?? game.coverUrl), // HD ou Steam
                loading: () => _buildImage(game.coverUrl, isBlur: true), // Steam enquanto carrega
                error: (_, __) => _buildImage(game.coverUrl), // Erro volta pra Steam
              ) ?? _buildImage(game.coverUrl), // Caso não seja Steam

              // Gradiente
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

              // Nome do Jogo
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

  // Helper para não repetir código de imagem
  Widget _buildImage(String url, {bool isBlur = false}) {
    return CachedNetworkImage(
      imageUrl: url,
      fit: BoxFit.cover, // Importante para preencher o card
      width: double.infinity,
      alignment: Alignment.center,
      height: double.infinity,
      color: isBlur ? Colors.black.withValues(alpha: 0.3) : null,
      colorBlendMode: isBlur ? BlendMode.darken : null,
      placeholder: (context, url) => Container(color: Colors.grey[900]),
      errorWidget: (context, url, error) => const Icon(Icons.videogame_asset),
    );
  }
}