import 'package:backlog_roulette/di/service_providers.dart';
import 'package:backlog_roulette/features/auth/viewmodels/states/auth_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AuthNotifier extends Notifier<AuthState> {
  @override
  AuthState build() {
    final user = ref.read(authServiceProvider).currentUser;

    if(user == null){
      return AuthState.unauthenticated();
    }

    return AuthState.authenticated();
  }

  Future<void> signInWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    state = AuthState.loading();
    try {
      await ref.read(authServiceProvider).signInWithEmailAndPassword(email: email, password: password);
      // Artificial delay
      Future.delayed(const Duration(milliseconds: 1500), () {
        state = AuthState.authenticated();
      },);
    } catch (e) {
      state = AuthState.error(message: e.toString());
    }
  }

  Future<void> signUpWithEmailAndPassword({
    required String email,
    required String password,
    required String username,
  }) async {
    state = AuthState.loading();
    try {
      // Artificial delay
      await ref.read(authServiceProvider).signUpWithEmailAndPassword(email: email, password: password, username: username);
      Future.delayed(const Duration(milliseconds: 1500), () {
        state = AuthState.authenticated();
      },);

    } catch (e) {
      state = AuthState.error(message: e.toString());
    }
  }

  Future<void> signOut() async{
    state = AuthState.loading();
    try{
      await ref.read(authServiceProvider).signOut();
      state = AuthState.authenticated();
    } catch(e){
      state = AuthState.error(message: e.toString());
    }
  }
}
