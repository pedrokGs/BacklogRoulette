// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'game.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$Game {

 String get id; String get name; String get coverUrl; String get igdbCoverUrl; List<String> get genres; GameState get gameState; String? get igdbId; String? get steamAppId; int get playtime; int get timeLastPlayed; bool get isManualEntry;
/// Create a copy of Game
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$GameCopyWith<Game> get copyWith => _$GameCopyWithImpl<Game>(this as Game, _$identity);

  /// Serializes this Game to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Game&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.coverUrl, coverUrl) || other.coverUrl == coverUrl)&&(identical(other.igdbCoverUrl, igdbCoverUrl) || other.igdbCoverUrl == igdbCoverUrl)&&const DeepCollectionEquality().equals(other.genres, genres)&&(identical(other.gameState, gameState) || other.gameState == gameState)&&(identical(other.igdbId, igdbId) || other.igdbId == igdbId)&&(identical(other.steamAppId, steamAppId) || other.steamAppId == steamAppId)&&(identical(other.playtime, playtime) || other.playtime == playtime)&&(identical(other.timeLastPlayed, timeLastPlayed) || other.timeLastPlayed == timeLastPlayed)&&(identical(other.isManualEntry, isManualEntry) || other.isManualEntry == isManualEntry));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,name,coverUrl,igdbCoverUrl,const DeepCollectionEquality().hash(genres),gameState,igdbId,steamAppId,playtime,timeLastPlayed,isManualEntry);

@override
String toString() {
  return 'Game(id: $id, name: $name, coverUrl: $coverUrl, igdbCoverUrl: $igdbCoverUrl, genres: $genres, gameState: $gameState, igdbId: $igdbId, steamAppId: $steamAppId, playtime: $playtime, timeLastPlayed: $timeLastPlayed, isManualEntry: $isManualEntry)';
}


}

/// @nodoc
abstract mixin class $GameCopyWith<$Res>  {
  factory $GameCopyWith(Game value, $Res Function(Game) _then) = _$GameCopyWithImpl;
@useResult
$Res call({
 String id, String name, String coverUrl, String igdbCoverUrl, List<String> genres, GameState gameState, String? igdbId, String? steamAppId, int playtime, int timeLastPlayed, bool isManualEntry
});




}
/// @nodoc
class _$GameCopyWithImpl<$Res>
    implements $GameCopyWith<$Res> {
  _$GameCopyWithImpl(this._self, this._then);

  final Game _self;
  final $Res Function(Game) _then;

/// Create a copy of Game
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? name = null,Object? coverUrl = null,Object? igdbCoverUrl = null,Object? genres = null,Object? gameState = null,Object? igdbId = freezed,Object? steamAppId = freezed,Object? playtime = null,Object? timeLastPlayed = null,Object? isManualEntry = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,coverUrl: null == coverUrl ? _self.coverUrl : coverUrl // ignore: cast_nullable_to_non_nullable
as String,igdbCoverUrl: null == igdbCoverUrl ? _self.igdbCoverUrl : igdbCoverUrl // ignore: cast_nullable_to_non_nullable
as String,genres: null == genres ? _self.genres : genres // ignore: cast_nullable_to_non_nullable
as List<String>,gameState: null == gameState ? _self.gameState : gameState // ignore: cast_nullable_to_non_nullable
as GameState,igdbId: freezed == igdbId ? _self.igdbId : igdbId // ignore: cast_nullable_to_non_nullable
as String?,steamAppId: freezed == steamAppId ? _self.steamAppId : steamAppId // ignore: cast_nullable_to_non_nullable
as String?,playtime: null == playtime ? _self.playtime : playtime // ignore: cast_nullable_to_non_nullable
as int,timeLastPlayed: null == timeLastPlayed ? _self.timeLastPlayed : timeLastPlayed // ignore: cast_nullable_to_non_nullable
as int,isManualEntry: null == isManualEntry ? _self.isManualEntry : isManualEntry // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [Game].
extension GamePatterns on Game {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _Game value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Game() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _Game value)  $default,){
final _that = this;
switch (_that) {
case _Game():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _Game value)?  $default,){
final _that = this;
switch (_that) {
case _Game() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String name,  String coverUrl,  String igdbCoverUrl,  List<String> genres,  GameState gameState,  String? igdbId,  String? steamAppId,  int playtime,  int timeLastPlayed,  bool isManualEntry)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Game() when $default != null:
return $default(_that.id,_that.name,_that.coverUrl,_that.igdbCoverUrl,_that.genres,_that.gameState,_that.igdbId,_that.steamAppId,_that.playtime,_that.timeLastPlayed,_that.isManualEntry);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String name,  String coverUrl,  String igdbCoverUrl,  List<String> genres,  GameState gameState,  String? igdbId,  String? steamAppId,  int playtime,  int timeLastPlayed,  bool isManualEntry)  $default,) {final _that = this;
switch (_that) {
case _Game():
return $default(_that.id,_that.name,_that.coverUrl,_that.igdbCoverUrl,_that.genres,_that.gameState,_that.igdbId,_that.steamAppId,_that.playtime,_that.timeLastPlayed,_that.isManualEntry);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String name,  String coverUrl,  String igdbCoverUrl,  List<String> genres,  GameState gameState,  String? igdbId,  String? steamAppId,  int playtime,  int timeLastPlayed,  bool isManualEntry)?  $default,) {final _that = this;
switch (_that) {
case _Game() when $default != null:
return $default(_that.id,_that.name,_that.coverUrl,_that.igdbCoverUrl,_that.genres,_that.gameState,_that.igdbId,_that.steamAppId,_that.playtime,_that.timeLastPlayed,_that.isManualEntry);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _Game implements Game {
  const _Game({required this.id, required this.name, required this.coverUrl, required this.igdbCoverUrl, required final  List<String> genres, required this.gameState, this.igdbId, this.steamAppId, this.playtime = 0, this.timeLastPlayed = 0, this.isManualEntry = false}): _genres = genres;
  factory _Game.fromJson(Map<String, dynamic> json) => _$GameFromJson(json);

@override final  String id;
@override final  String name;
@override final  String coverUrl;
@override final  String igdbCoverUrl;
 final  List<String> _genres;
@override List<String> get genres {
  if (_genres is EqualUnmodifiableListView) return _genres;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_genres);
}

@override final  GameState gameState;
@override final  String? igdbId;
@override final  String? steamAppId;
@override@JsonKey() final  int playtime;
@override@JsonKey() final  int timeLastPlayed;
@override@JsonKey() final  bool isManualEntry;

/// Create a copy of Game
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$GameCopyWith<_Game> get copyWith => __$GameCopyWithImpl<_Game>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$GameToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Game&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.coverUrl, coverUrl) || other.coverUrl == coverUrl)&&(identical(other.igdbCoverUrl, igdbCoverUrl) || other.igdbCoverUrl == igdbCoverUrl)&&const DeepCollectionEquality().equals(other._genres, _genres)&&(identical(other.gameState, gameState) || other.gameState == gameState)&&(identical(other.igdbId, igdbId) || other.igdbId == igdbId)&&(identical(other.steamAppId, steamAppId) || other.steamAppId == steamAppId)&&(identical(other.playtime, playtime) || other.playtime == playtime)&&(identical(other.timeLastPlayed, timeLastPlayed) || other.timeLastPlayed == timeLastPlayed)&&(identical(other.isManualEntry, isManualEntry) || other.isManualEntry == isManualEntry));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,name,coverUrl,igdbCoverUrl,const DeepCollectionEquality().hash(_genres),gameState,igdbId,steamAppId,playtime,timeLastPlayed,isManualEntry);

@override
String toString() {
  return 'Game(id: $id, name: $name, coverUrl: $coverUrl, igdbCoverUrl: $igdbCoverUrl, genres: $genres, gameState: $gameState, igdbId: $igdbId, steamAppId: $steamAppId, playtime: $playtime, timeLastPlayed: $timeLastPlayed, isManualEntry: $isManualEntry)';
}


}

/// @nodoc
abstract mixin class _$GameCopyWith<$Res> implements $GameCopyWith<$Res> {
  factory _$GameCopyWith(_Game value, $Res Function(_Game) _then) = __$GameCopyWithImpl;
@override @useResult
$Res call({
 String id, String name, String coverUrl, String igdbCoverUrl, List<String> genres, GameState gameState, String? igdbId, String? steamAppId, int playtime, int timeLastPlayed, bool isManualEntry
});




}
/// @nodoc
class __$GameCopyWithImpl<$Res>
    implements _$GameCopyWith<$Res> {
  __$GameCopyWithImpl(this._self, this._then);

  final _Game _self;
  final $Res Function(_Game) _then;

/// Create a copy of Game
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? name = null,Object? coverUrl = null,Object? igdbCoverUrl = null,Object? genres = null,Object? gameState = null,Object? igdbId = freezed,Object? steamAppId = freezed,Object? playtime = null,Object? timeLastPlayed = null,Object? isManualEntry = null,}) {
  return _then(_Game(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,coverUrl: null == coverUrl ? _self.coverUrl : coverUrl // ignore: cast_nullable_to_non_nullable
as String,igdbCoverUrl: null == igdbCoverUrl ? _self.igdbCoverUrl : igdbCoverUrl // ignore: cast_nullable_to_non_nullable
as String,genres: null == genres ? _self._genres : genres // ignore: cast_nullable_to_non_nullable
as List<String>,gameState: null == gameState ? _self.gameState : gameState // ignore: cast_nullable_to_non_nullable
as GameState,igdbId: freezed == igdbId ? _self.igdbId : igdbId // ignore: cast_nullable_to_non_nullable
as String?,steamAppId: freezed == steamAppId ? _self.steamAppId : steamAppId // ignore: cast_nullable_to_non_nullable
as String?,playtime: null == playtime ? _self.playtime : playtime // ignore: cast_nullable_to_non_nullable
as int,timeLastPlayed: null == timeLastPlayed ? _self.timeLastPlayed : timeLastPlayed // ignore: cast_nullable_to_non_nullable
as int,isManualEntry: null == isManualEntry ? _self.isManualEntry : isManualEntry // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

// dart format on
