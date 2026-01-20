import 'package:freezed_annotation/freezed_annotation.dart';

part 'game.freezed.dart';
part 'game.g.dart';

@freezed
abstract class Game with _$Game {
  const factory Game({
    required String id,
    required String name,
    required String coverUrl,
    required List<String> genres,
    String? steamAppId,
    @Default(0) int playtime,
    @Default(false) bool isManualEntry,
}) = _Game;

  factory Game.fromJson(Map<String, dynamic> json) => _$GameFromJson(json);
}