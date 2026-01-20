import 'dart:math';
import 'package:backlog_roulette/common/widgets/roulette_card.dart';
import 'package:backlog_roulette/models/game/game.dart';
import 'package:flutter/material.dart';

class RouletteWheel extends StatefulWidget {
  final List<Game> games;

  const RouletteWheel({super.key, required this.games});

  @override
  State<RouletteWheel> createState() => _RouletteWheelState();
}

class _RouletteWheelState extends State<RouletteWheel> {
  // O controlador que manda na roda
  late FixedExtentScrollController _controller;
  bool _isSpinning = false;
  String _statusText = "Toque para girar";

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

    setState(() {
      _isSpinning = true;
      _statusText = "Girando...";
    });

    final random = Random();
    final winnerIndex = random.nextInt(widget.games.length);

    final currentItem = _controller.selectedItem;
    final int numberOfRounds = 5 + random.nextInt(5);
    final targetItem = currentItem + (widget.games.length * numberOfRounds) + winnerIndex;

    // 3. Anima o controlador
    _controller.animateToItem(
      targetItem,
      duration: const Duration(seconds: 5), // Tempo de suspense
      curve: Curves.fastOutSlowIn,
    ).then((_) {
      // 4. Quando a animação termina
      setState(() {
        _isSpinning = false;
        _statusText = "Vencedor: ${widget.games[winnerIndex].name}";
      });

      _showWinnerDialog(widget.games[winnerIndex]);
    });
  }

  void _showWinnerDialog(Game game) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text("Temos um Vencedor! 🏆"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Image.network(game.coverUrl, height: 150),
            const SizedBox(height: 10),
            Text(game.name, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
          ],
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: const Text("OK"))
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          _statusText,
          style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 20),

        const Icon(Icons.arrow_drop_down, size: 50, color: Colors.redAccent),

        SizedBox(
          height: 300,
          child: ListWheelScrollView.useDelegate(
            controller: _controller,
            itemExtent: 200,
            perspective: 0.005,
            diameterRatio: 1.5,
            physics: const FixedExtentScrollPhysics(),

            // Loop Infinito visual
            childDelegate: ListWheelChildLoopingListDelegate(
              children: widget.games.map((g) {
                return RouletteCard(game: g);
              }).toList(),
            ),
          ),
        ),

        const Icon(Icons.arrow_drop_up, size: 50, color: Colors.redAccent),

        const SizedBox(height: 30),

        // BOTÃO DE GIRO
        ElevatedButton.icon(
          onPressed: _isSpinning ? null : _spin,
          style: ElevatedButton.styleFrom(
            padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
            backgroundColor: Colors.redAccent,
            foregroundColor: Colors.white,
          ),
          icon: const Icon(Icons.casino),
          label: const Text("GIRAR ROLETA", style: TextStyle(fontSize: 18)),
        ),
      ],
    );
  }
}