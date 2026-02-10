import 'package:backlog_roulette/features/auth/auth_di.dart';
import 'package:backlog_roulette/features/auth/models/models/app_user.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AuthNotifier extends StreamNotifier<AppUser?> {
  @override
  Stream<AppUser?> build() {
    return ref.watch(authServiceProvider).authStateChanges;
  }

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

  Future<void> signOut() async {
    state = const AsyncValue.loading();
    await ref.read(authServiceProvider).signOut();
  }
}
