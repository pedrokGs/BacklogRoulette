import 'package:freezed_annotation/freezed_annotation.dart';

part 'app_user.freezed.dart';

/// Classe de usuário do domínio, representa o usuário autenticado dentro da aplicação
@freezed
abstract class AppUser with _$AppUser {
  const factory AppUser({
    /// ID do firebase
    required String id,
    required String email,
    required String username,
  }) = _AppUser;
}
