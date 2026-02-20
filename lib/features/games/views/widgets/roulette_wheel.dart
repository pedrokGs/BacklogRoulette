import 'dart:math';

import 'package:audioplayers/audioplayers.dart';
import 'package:backlog_roulette/core/l10n/app_localizations.dart';
import 'package:backlog_roulette/core/router/route_names.dart';
import 'package:backlog_roulette/features/games/models/models/game/game.dart';
import 'package:backlog_roulette/features/games/models/utils/roulette_calculator.dart';
import 'package:backlog_roulette/features/games/views/widgets/roulette_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

class RouletteWheel extends ConsumerStatefulWidget {
  final List<Game> games;
  final Map<Game, double> weights;

  const RouletteWheel({super.key, required this.games, required this.weights});

  @override
  ConsumerState<RouletteWheel> createState() => _RouletteWheelState();
}

class _RouletteWheelState extends ConsumerState<RouletteWheel> {
  late FixedExtentScrollController _controller;
  bool _isSpinning = false;

  final Color _neonGold = const Color(0xFFFFD700);
  final Color _voidBlack = const Color(0xFF0F1115);

  @override
  void initState() {
    super.initState();
    _controller = FixedExtentScrollController();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future<void> _startRoulette() async {
    final player = AudioPlayer();
    player.play(AssetSource('audio/roulette_spin.mp3'));
    _spin();
  }

  void _spin() {
    if (_isSpinning || widget.games.isEmpty) return;

    setState(() => _isSpinning = true);

    final random = Random();

    final winnerGame = RouletteCalculator<Game>(widget.weights).pickWinner();
    // print(
    //  "[DEBUG] : ${winnerGame.name} won with weight: ${widget.weights[winnerGame]}",
    // );
    final winnerIndex = widget.games.indexOf(winnerGame);

    final currentItem = _controller.selectedItem;
    final int currentModIndex = currentItem % widget.games.length;
    int distanceToWinner = winnerIndex - currentModIndex;

    if (distanceToWinner <= 0) {
      distanceToWinner += widget.games.length;
    }

    final int numberOfRounds = 5 + random.nextInt(5);
    final targetItem =
        currentItem + (widget.games.length * numberOfRounds) + distanceToWinner;

    _controller
        .animateToItem(
          targetItem,
          duration: const Duration(seconds: 4),
          curve: Curves.easeOutQuint,
        )
        .then((_) {
          setState(() => _isSpinning = false);
          HapticFeedback.heavyImpact();
          _showWinnerDialog(widget.games[winnerIndex]);
        });
  }

  void _showWinnerDialog(Game game) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        final theme = Theme.of(context);
        final colorScheme = theme.colorScheme;

        return AlertDialog(
          backgroundColor: theme.cardColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
            side: BorderSide(
              color: colorScheme.primary.withValues(alpha: 0.5),
              width: 2,
            ),
          ),
          title: Text(
            AppLocalizations.of(context)!.roulette_winner_card_title,
            textAlign: TextAlign.center,
            style: GoogleFonts.poppins(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: colorScheme.primary,
            ),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: colorScheme.primary.withValues(alpha: 0.3),
                      blurRadius: 20,
                      offset: const Offset(0, 8),
                    ),
                  ],
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(16),
                  child: Hero(
                    tag: 'game-cover-${game.id}',
                    child: Image.network(
                      game.igdbCoverUrl,
                      height: 180,
                      width: 130,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 24),
              Text(
                game.name,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: colorScheme.onSurface,
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                AppLocalizations.of(
                  context,
                )!.roulette_winner_card_ready_to_play_text,
                style: TextStyle(color: Colors.grey[600], fontSize: 14),
              ),
            ],
          ),
          actionsAlignment: MainAxisAlignment.center,
          actions: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                FilledButton(
                  style: FilledButton.styleFrom(
                    backgroundColor: colorScheme.primary,
                    foregroundColor: colorScheme.onPrimary,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                  onPressed: () {
                    context.pushNamed(
                      RouteNames.gameDetails,
                      pathParameters: {"gameId": game.id},
                    );
                  },
                  child: Text(
                    AppLocalizations.of(
                      context,
                    )!.roulette_winner_card_accept_challenge_button_label,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                      letterSpacing: 1.2,
                    ),
                  ),
                ),
                const SizedBox(height: 8),
                TextButton(
                  style: TextButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                  onPressed: () => Navigator.pop(context),
                  child: Text(
                    AppLocalizations.of(
                      context,
                    )!.roulette_winner_card_decline_challenge_button_label,
                    style: TextStyle(
                      color: Colors.grey[500],
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12.0),
      child: Stack(
        alignment: Alignment.center,
        children: [
          SizedBox(
            height: 450,
            child: ListWheelScrollView.useDelegate(
              controller: _controller,
              itemExtent: 180,
              perspective: 0.004,
              diameterRatio: 3,
              physics: _isSpinning
                  ? const NeverScrollableScrollPhysics()
                  : const FixedExtentScrollPhysics(),
              onSelectedItemChanged: (index) {
                HapticFeedback.selectionClick();
              },
              childDelegate: ListWheelChildLoopingListDelegate(
                children: widget.games.map((g) {
                  return Opacity(
                    opacity: _isSpinning ? 0.5 : 1.0,
                    child: RouletteCard(game: g),
                  );
                }).toList(),
              ),
            ),
          ),

          Positioned.fill(
            child: IgnorePointer(
              child: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      _voidBlack,
                      Colors.transparent,
                      Colors.transparent,
                      _voidBlack,
                    ],
                    stops: const [0.0, 0.2, 0.8, 1.0],
                  ),
                ),
              ),
            ),
          ),

          IgnorePointer(
            child: Container(
              height: 190,
              decoration: BoxDecoration(
                border: Border.symmetric(
                  horizontal: BorderSide(color: _neonGold, width: 2),
                ),
                boxShadow: [
                  BoxShadow(
                    color: _neonGold.withValues(alpha: 0.2),
                    blurRadius: 10,
                    spreadRadius: 1,
                  ),
                ],
              ),
            ),
          ),

          Positioned(
            right: 20,
            child: Icon(Icons.arrow_left, size: 60, color: _neonGold),
          ),

          Positioned(
            bottom: 20,
            child: AnimatedOpacity(
              duration: const Duration(milliseconds: 300),
              opacity: _isSpinning ? 0.0 : 1.0,
              child: SizedBox(
                width: 250,
                height: 60,
                child: ElevatedButton(
                  onPressed: () {
                    HapticFeedback.mediumImpact();
                    _startRoulette();
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: _neonGold,
                    foregroundColor: Colors.black,
                    elevation: 10,
                    shadowColor: _neonGold.withValues(alpha: 0.5),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: Text(
                    AppLocalizations.of(context)!.roulette_spin_button_label,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1.2,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
