import 'package:backlog_roulette/features/auth/auth_di.dart';
import 'package:backlog_roulette/features/auth/data/services/auth_service.dart';
import 'package:backlog_roulette/features/auth/domain/entities/app_user.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockAuthService extends Mock implements AuthService {}

class MockUser extends Mock implements AppUser {}

void main() {
  late MockAuthService mockAuthService;
  late ProviderContainer container;
  final mockUser = MockUser();

  const email = 'test@email.com';
  const password = 'password123';
  const username = 'testuser';

  setUp(() {
    mockAuthService = MockAuthService();

    when(
      () => mockAuthService.authStateChanges,
    ).thenAnswer((_) => Stream.value(null));

    container = ProviderContainer(
      overrides: [authServiceProvider.overrideWith((ref) => mockAuthService)],
    );

    container.listen(authNotifierProvider, (_, __) {});
  });

  tearDown(() => container.dispose());

  group('AuthNotifier - signInWithEmailAndPassword', () {
    test('updates state with user on success', () async {
      when(
        () => mockAuthService.signInWithEmailAndPassword(
          email: email,
          password: password,
        ),
      ).thenAnswer((_) async {});
      when(() => mockAuthService.currentUser).thenReturn(mockUser);

      await container
          .read(authNotifierProvider.notifier)
          .signInWithEmailAndPassword(email: email, password: password);

      expect(container.read(authNotifierProvider).value, equals(mockUser));
    });

    test('updates state to error on failure', () async {
      when(
        () => mockAuthService.signInWithEmailAndPassword(
          email: email,
          password: password,
        ),
      ).thenThrow(Exception('Error'));

      await container
          .read(authNotifierProvider.notifier)
          .signInWithEmailAndPassword(email: email, password: password);

      expect(container.read(authNotifierProvider).hasError, isTrue);
    });
  });

  group('AuthNotifier - signUpWithEmailAndPassword', () {
    test('updates state with user on success', () async {
      when(
        () => mockAuthService.signUpWithEmailAndPassword(
          email: email,
          password: password,
          username: username,
        ),
      ).thenAnswer((_) async {});
      when(() => mockAuthService.currentUser).thenReturn(mockUser);

      await container
          .read(authNotifierProvider.notifier)
          .signUpWithEmailAndPassword(
            email: email,
            password: password,
            username: username,
          );

      expect(container.read(authNotifierProvider).value, equals(mockUser));
    });

    test('updates state to error on failure', () async {
      when(
        () => mockAuthService.signUpWithEmailAndPassword(
          email: email,
          password: password,
          username: username,
        ),
      ).thenThrow(Exception('Error'));

      await container
          .read(authNotifierProvider.notifier)
          .signUpWithEmailAndPassword(
            email: email,
            password: password,
            username: username,
          );

      expect(container.read(authNotifierProvider).hasError, isTrue);
    });
  });

  group('AuthNotifier - signOut', () {
    test('calls the auth service', () async {
      when(() => mockAuthService.signOut()).thenAnswer((_) async {});

      await container.read(authNotifierProvider.notifier).signOut();

      verify(() => mockAuthService.signOut()).called(1);
    });
  });
}
