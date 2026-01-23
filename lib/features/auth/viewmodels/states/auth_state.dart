import 'package:freezed_annotation/freezed_annotation.dart';

part 'auth_state.freezed.dart';

@freezed
class AuthState with _$AuthState{
  factory AuthState.unauthenticated() = _Unauthenticated;

  factory AuthState.loading() = _Loading;

  factory AuthState.error({required String message}) = _Error;

  factory AuthState.authenticated() = _Authenticated;
}