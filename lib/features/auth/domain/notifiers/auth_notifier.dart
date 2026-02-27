import 'package:backlog_roulette/features/auth/auth_di.dart';
import 'package:backlog_roulette/features/auth/data/services/auth_service.dart';
import 'package:backlog_roulette/features/auth/domain/entities/app_user.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Notifier/Controller para fluxo de autenticação
///
/// O estado representa uma [Stream<AppUser?>], escuta a stream [AuthService.authStateChanges]
/// contém métodos para sign_in, sign_up e sign_out, todos protegidos por AsyncGuard
class AuthNotifier extends StreamNotifier<AppUser?> {
  @override
  Stream<AppUser?> build() {
    return ref.watch(authServiceProvider).authStateChanges;
  }

  /// Tenta efetuar login com email e senha
  ///
  /// Em caso de sucesso emite um evento na stream, que permite o redirect automatico do router
  Future<void> signInWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      await ref
          .read(authServiceProvider)
          .signInWithEmailAndPassword(email: email, password: password);

      return ref.read(authServiceProvider).currentUser;
    });
  }

  /// Tenta efetuar cadastro com email e senha
  ///
  /// Em caso de sucesso emite um evento na stream, que permite o redirect automatico do router
  Future<void> signUpWithEmailAndPassword({
    required String email,
    required String password,
    required String username,
  }) async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      await ref
          .read(authServiceProvider)
          .signUpWithEmailAndPassword(
            email: email,
            password: password,
            username: username,
          );

      return ref.read(authServiceProvider).currentUser;
    });
  }

  /// Tenta deslogar do aplicativo
  Future<void> signOut() async {
    state = const AsyncValue.loading();
    await ref.read(authServiceProvider).signOut();
  }
}
