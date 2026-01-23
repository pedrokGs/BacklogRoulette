// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'game.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_Game _$GameFromJson(Map<String, dynamic> json) => _Game(
  id: json['id'] as String,
  name: json['name'] as String,
  coverUrl: json['coverUrl'] as String,
  igdbCoverUrl: json['igdbCoverUrl'] as String,
  genres: (json['genres'] as List<dynamic>).map((e) => e as String).toList(),
  gameState: $enumDecode(_$GameStateEnumMap, json['gameState']),
  igdbId: json['igdbId'] as String?,
  steamAppId: json['steamAppId'] as String?,
  playtime: (json['playtime'] as num?)?.toInt() ?? 0,
  timeLastPlayed: (json['timeLastPlayed'] as num?)?.toInt() ?? 0,
  isManualEntry: json['isManualEntry'] as bool? ?? false,
);

Map<String, dynamic> _$GameToJson(_Game instance) => <String, dynamic>{
  'id': instance.id,
  'name': instance.name,
  'coverUrl': instance.coverUrl,
  'igdbCoverUrl': instance.igdbCoverUrl,
  'genres': instance.genres,
  'gameState': _$GameStateEnumMap[instance.gameState]!,
  'igdbId': instance.igdbId,
  'steamAppId': instance.steamAppId,
  'playtime': instance.playtime,
  'timeLastPlayed': instance.timeLastPlayed,
  'isManualEntry': instance.isManualEntry,
};

const _$GameStateEnumMap = {
  GameState.notPlayed: 'notPlayed',
  GameState.playing: 'playing',
  GameState.finished: 'finished',
  GameState.dropped: 'dropped',
};
