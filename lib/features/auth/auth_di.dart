import 'package:backlog_roulette/core/di/global_providers.dart';
import 'package:backlog_roulette/features/auth/models/services/auth_service.dart';
import 'package:backlog_roulette/features/auth/viewmodels/notifiers/auth_notifier.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
// Injeção de Dependência para autenticação.

// Providers
final authServiceProvider = Provider<AuthService>(
  (ref) => AuthService(firebaseAuth: ref.watch(firebaseAuthProvider)),
);

// Notifiers
final authNotifierProvider = StreamNotifierProvider(AuthNotifier.new);

// Selectors
// Retorna {true / false} dependendo do estado atual de autenticação
final isLoggedInProvider = Provider<bool>((ref) {
  return ref
      .read(authNotifierProvider)
      .maybeMap(data: (data) => true, orElse: () => false);
});
