// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'roulette_screen_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$RouletteScreenState {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is RouletteScreenState);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'RouletteScreenState()';
}


}

/// @nodoc
class $RouletteScreenStateCopyWith<$Res>  {
$RouletteScreenStateCopyWith(RouletteScreenState _, $Res Function(RouletteScreenState) __);
}


/// Adds pattern-matching-related methods to [RouletteScreenState].
extension RouletteScreenStatePatterns on RouletteScreenState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( _Idle value)?  idle,TResult Function( _Spinning value)?  spinning,TResult Function( _Error value)?  error,TResult Function( _Loading value)?  loading,required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Idle() when idle != null:
return idle(_that);case _Spinning() when spinning != null:
return spinning(_that);case _Error() when error != null:
return error(_that);case _Loading() when loading != null:
return loading(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( _Idle value)  idle,required TResult Function( _Spinning value)  spinning,required TResult Function( _Error value)  error,required TResult Function( _Loading value)  loading,}){
final _that = this;
switch (_that) {
case _Idle():
return idle(_that);case _Spinning():
return spinning(_that);case _Error():
return error(_that);case _Loading():
return loading(_that);case _:
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( _Idle value)?  idle,TResult? Function( _Spinning value)?  spinning,TResult? Function( _Error value)?  error,TResult? Function( _Loading value)?  loading,}){
final _that = this;
switch (_that) {
case _Idle() when idle != null:
return idle(_that);case _Spinning() when spinning != null:
return spinning(_that);case _Error() when error != null:
return error(_that);case _Loading() when loading != null:
return loading(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  idle,TResult Function( List<Game> selectedGames)?  spinning,TResult Function( String message)?  error,TResult Function()?  loading,required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Idle() when idle != null:
return idle();case _Spinning() when spinning != null:
return spinning(_that.selectedGames);case _Error() when error != null:
return error(_that.message);case _Loading() when loading != null:
return loading();case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  idle,required TResult Function( List<Game> selectedGames)  spinning,required TResult Function( String message)  error,required TResult Function()  loading,}) {final _that = this;
switch (_that) {
case _Idle():
return idle();case _Spinning():
return spinning(_that.selectedGames);case _Error():
return error(_that.message);case _Loading():
return loading();case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  idle,TResult? Function( List<Game> selectedGames)?  spinning,TResult? Function( String message)?  error,TResult? Function()?  loading,}) {final _that = this;
switch (_that) {
case _Idle() when idle != null:
return idle();case _Spinning() when spinning != null:
return spinning(_that.selectedGames);case _Error() when error != null:
return error(_that.message);case _Loading() when loading != null:
return loading();case _:
  return null;

}
}

}

/// @nodoc


class _Idle implements RouletteScreenState {
   _Idle();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Idle);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'RouletteScreenState.idle()';
}


}




/// @nodoc


class _Spinning implements RouletteScreenState {
   _Spinning({required final  List<Game> selectedGames}): _selectedGames = selectedGames;
  

 final  List<Game> _selectedGames;
 List<Game> get selectedGames {
  if (_selectedGames is EqualUnmodifiableListView) return _selectedGames;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_selectedGames);
}


/// Create a copy of RouletteScreenState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SpinningCopyWith<_Spinning> get copyWith => __$SpinningCopyWithImpl<_Spinning>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Spinning&&const DeepCollectionEquality().equals(other._selectedGames, _selectedGames));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_selectedGames));

@override
String toString() {
  return 'RouletteScreenState.spinning(selectedGames: $selectedGames)';
}


}

/// @nodoc
abstract mixin class _$SpinningCopyWith<$Res> implements $RouletteScreenStateCopyWith<$Res> {
  factory _$SpinningCopyWith(_Spinning value, $Res Function(_Spinning) _then) = __$SpinningCopyWithImpl;
@useResult
$Res call({
 List<Game> selectedGames
});




}
/// @nodoc
class __$SpinningCopyWithImpl<$Res>
    implements _$SpinningCopyWith<$Res> {
  __$SpinningCopyWithImpl(this._self, this._then);

  final _Spinning _self;
  final $Res Function(_Spinning) _then;

/// Create a copy of RouletteScreenState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? selectedGames = null,}) {
  return _then(_Spinning(
selectedGames: null == selectedGames ? _self._selectedGames : selectedGames // ignore: cast_nullable_to_non_nullable
as List<Game>,
  ));
}


}

/// @nodoc


class _Error implements RouletteScreenState {
   _Error({required this.message});
  

 final  String message;

/// Create a copy of RouletteScreenState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ErrorCopyWith<_Error> get copyWith => __$ErrorCopyWithImpl<_Error>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Error&&(identical(other.message, message) || other.message == message));
}


@override
int get hashCode => Object.hash(runtimeType,message);

@override
String toString() {
  return 'RouletteScreenState.error(message: $message)';
}


}

/// @nodoc
abstract mixin class _$ErrorCopyWith<$Res> implements $RouletteScreenStateCopyWith<$Res> {
  factory _$ErrorCopyWith(_Error value, $Res Function(_Error) _then) = __$ErrorCopyWithImpl;
@useResult
$Res call({
 String message
});




}
/// @nodoc
class __$ErrorCopyWithImpl<$Res>
    implements _$ErrorCopyWith<$Res> {
  __$ErrorCopyWithImpl(this._self, this._then);

  final _Error _self;
  final $Res Function(_Error) _then;

/// Create a copy of RouletteScreenState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? message = null,}) {
  return _then(_Error(
message: null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class _Loading implements RouletteScreenState {
   _Loading();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Loading);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'RouletteScreenState.loading()';
}


}




// dart format on
