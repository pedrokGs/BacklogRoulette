import 'package:backlog_roulette/features/games/models/enums/game_state_enum.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'game.freezed.dart';
part 'game.g.dart';

@freezed
abstract class Game with _$Game {
  const factory Game({
    required String id,
    required String name,
    required String coverUrl,
    required String igdbCoverUrl,
    required List<String> genres,
    required GameState gameState,
    String? steamAppId,
    @Default(0) int playtime,
    @Default(0) int timeLastPlayed,
    @Default(false) bool isManualEntry,
}) = _Game;

  factory Game.fromJson(Map<String, dynamic> json) => _$GameFromJson(json);

  factory Game.fromSteam(Map<String, dynamic> json) {
    final appId = json['appid'].toString() ?? '';
    final playtime = json['playtime_forever'] ?? 0;
    return Game(
      id: 'steam_$appId',
      name: json['name'] ?? '',
      coverUrl: 'https://cdn.akamai.steamstatic.com/steam/apps/$appId/header.jpg' ?? '',
      igdbCoverUrl: '',
      genres: [],
      gameState: playtime > 0 ? GameState.playing : GameState.notPlayed,
      steamAppId: appId ?? '',
      playtime: playtime,
      timeLastPlayed: json['rtime_last_played'] ?? 0,
      isManualEntry: false,
    );
  }
}