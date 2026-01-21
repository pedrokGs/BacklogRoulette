import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:backlog_roulette/models/game/game.dart';
import 'package:backlog_roulette/common/widgets/roulette_card.dart';

class RouletteWheel extends StatefulWidget {
  final List<Game> games;

  const RouletteWheel({super.key, required this.games});

  @override
  State<RouletteWheel> createState() => _RouletteWheelState();
}

class _RouletteWheelState extends State<RouletteWheel> {
  late FixedExtentScrollController _controller;
  bool _isSpinning = false;

  // Design Colors
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

  void _spin() {
    if (_isSpinning || widget.games.isEmpty) return;

    setState(() => _isSpinning = true);

    // Lógica de vencedor
    final random = Random();
    final winnerIndex = random.nextInt(widget.games.length);

    final currentItem = _controller.selectedItem;
    final int currentModIndex = currentItem % widget.games.length;
    int distanceToWinner = winnerIndex - currentModIndex;

    if (distanceToWinner <= 0) {
      distanceToWinner += widget.games.length;
    }

    final int numberOfRounds = 5 + random.nextInt(5);
    final targetItem = currentItem + (widget.games.length * numberOfRounds) + distanceToWinner;

    _controller.animateToItem(
      targetItem,
      duration: const Duration(seconds: 4),
      curve: Curves.easeOutQuint,
    ).then((_) {
      setState(() => _isSpinning = false);
      HapticFeedback.heavyImpact();
      _showWinnerDialog(widget.games[winnerIndex]);
    });
  }

  void _showWinnerDialog(Game game) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) => AlertDialog(
        backgroundColor: const Color(0xFF1E222B),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
          side: BorderSide(color: _neonGold, width: 2), // Borda Dourada
        ),
        title: Text(
            "DESTINY CHOSEN",
            textAlign: TextAlign.center,
            style: TextStyle(fontFamily: 'Russo One', color: _neonGold)
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              decoration: BoxDecoration(
                  boxShadow: [BoxShadow(color: _neonGold.withValues(alpha: 0.4), blurRadius: 20)]
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image.network(game.coverUrl, height: 150, fit: BoxFit.cover),
              ),
            ),
            const SizedBox(height: 20),
            Text(
                game.name.toUpperCase(),
                textAlign: TextAlign.center,
                style: const TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)
            ),
            const SizedBox(height: 10),
            Text("Are you ready?", style: TextStyle(color: Colors.white.withValues(alpha: 0.6))),
          ],
        ),
        actions: [
          FilledButton(
            style: FilledButton.styleFrom(backgroundColor: _neonGold, foregroundColor: Colors.black),
            onPressed: () {
              Navigator.pop(context);
              // TODO: Navegar para detalhes ou marcar como "Playing"
            },
            child: const Text("I ACCEPT THIS QUEST", style: TextStyle(fontWeight: FontWeight.bold)),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("Coward's Respin", style: TextStyle(color: Colors.grey)),
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        SizedBox(
          height: 400,
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
                BoxShadow(color: _neonGold.withValues(alpha: 0.2), blurRadius: 10, spreadRadius: 1)
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
                onPressed: _spin,
                style: ElevatedButton.styleFrom(
                  backgroundColor: _neonGold,
                  foregroundColor: Colors.black,
                  elevation: 10,
                  shadowColor: _neonGold.withValues(alpha: 0.5),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                ),
                child: const Text(
                  "SEAL YOUR FATE",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, letterSpacing: 1.2),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}