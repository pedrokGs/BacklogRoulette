import 'package:backlog_roulette/di/notifiers.dart';
import 'package:backlog_roulette/models/game/game.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class GameCheckbox extends ConsumerWidget {
  final Game game;
  const GameCheckbox({required this.game, super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isSelected = ref
        .watch(rouletteStateNotifier.notifier)
        .selectedIds
        .contains(game.steamAppId);

    return ListTile(
      onTap: () {

        ref
            .read(rouletteStateNotifier.notifier)
            .toggleSelection(game.steamAppId!);
      },
      contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      leading: ClipRRect(
        borderRadius: BorderRadius.circular(4),
        child: CachedNetworkImage(
          imageUrl: game.coverUrl,
          width: 50,
          height: 70,
          fit: BoxFit.cover,
          errorWidget: (context, url, error) => CachedNetworkImage(imageUrl: game.igdbCoverUrl, width: 50, height: 70, fit: BoxFit.cover,),
        ),
      ),
      title: Text(game.name, style: TextStyle(fontWeight: FontWeight.bold)),
      subtitle: Text("${(game.playtime / 60).toStringAsFixed(1)} horas"),
      trailing: Checkbox(
        value: isSelected,
        activeColor: Theme.of(context).colorScheme.primary,
        onChanged: (val) {
          ref
              .read(rouletteStateNotifier.notifier)
              .toggleSelection(game.steamAppId!);
        },
      ),
    );
  }
}
