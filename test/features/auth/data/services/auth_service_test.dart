import 'package:backlog_roulette/features/auth/data/exceptions/auth_exceptions.dart';
import 'package:backlog_roulette/features/auth/data/services/auth_service.dart';
import 'package:backlog_roulette/features/auth/domain/entities/app_user.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockFirebaseAuth extends Mock implements FirebaseAuth {}

class MockUserCredential extends Mock implements UserCredential {}

class MockUser extends Mock implements User {}

void main() {
  late AuthService authService;
  late MockFirebaseAuth mockFirebaseAuth;
  late MockUser mockUser;
  late MockUserCredential mockUserCredential;

  setUp(() {
    mockFirebaseAuth = MockFirebaseAuth();
    mockUser = MockUser();
    mockUserCredential = MockUserCredential();
    authService = AuthService(firebaseAuth: mockFirebaseAuth);
  });

  group('AuthService - signInWithEmailAndPassword', () {
    const email = 'test@gmail.com';
    const password = 'password123';

    test('Should complete successfully when credentials are valid', () async {
      when(
        () => mockFirebaseAuth.signInWithEmailAndPassword(
          email: email,
          password: password,
        ),
      ).thenAnswer((_) async => mockUserCredential);

      expect(
        authService.signInWithEmailAndPassword(
          email: email,
          password: password,
        ),
        completes,
      );
      verify(
        () => mockFirebaseAuth.signInWithEmailAndPassword(
          email: email,
          password: password,
        ),
      ).called(1);
    });

    test(
      'Should throw UserNotFoundException when error is user-not-found',
      () async {
        when(
          () => mockFirebaseAuth.signInWithEmailAndPassword(
            email: email,
            password: password,
          ),
        ).thenThrow(FirebaseAuthException(code: 'user-not-found'));

        final call = authService.signInWithEmailAndPassword;

        expect(
          () => call(email: email, password: password),
          throwsA(isA<UserNotFoundException>()),
        );
      },
    );

    test(
      'Should throw TooManyRequestsException when error is too-many-requests',
      () async {
        when(
          () => mockFirebaseAuth.signInWithEmailAndPassword(
            email: email,
            password: password,
          ),
        ).thenThrow(FirebaseAuthException(code: 'too-many-requests'));

        final call = authService.signInWithEmailAndPassword;

        expect(
          () => call(email: email, password: password),
          throwsA(isA<TooManyRequestsException>()),
        );
      },
    );
  });

  group('AuthService - signUpWithEmailAndPassword', () {
    const email = "test@gmail.com";
    const password = 'password123';
    const username = "test123";

    test('Should create user and update display name', () async {
      when(() => mockUserCredential.user).thenReturn(mockUser);
      when(() => mockUser.updateDisplayName(any())).thenAnswer((_) async => {});
      when(() => mockUser.reload()).thenAnswer((_) async => {});

      when(
        () => mockFirebaseAuth.createUserWithEmailAndPassword(
          email: email,
          password: password,
        ),
      ).thenAnswer((_) async => mockUserCredential);

      await authService.signUpWithEmailAndPassword(
        email: email,
        password: password,
        username: username,
      );

      verify(() => mockUser.updateDisplayName(username)).called(1);
      verify(() => mockUser.reload()).called(1);
    });

    test('Should throw a WeakPasswordException if password is weak', () async {
      when(
        () => mockFirebaseAuth.createUserWithEmailAndPassword(
          email: email,
          password: password,
        ),
      ).thenThrow(FirebaseAuthException(code: 'weak-password'));

      final call = authService.signUpWithEmailAndPassword;

      expect(
        () => call(email: email, password: password, username: username),
        throwsA(isA<WeakPasswordException>()),
      );
    });

    test(
      'Should throw an EmailIsAlreadyInUseException if email is already on use',
      () async {
        when(
          () => mockFirebaseAuth.createUserWithEmailAndPassword(
            email: email,
            password: password,
          ),
        ).thenThrow(FirebaseAuthException(code: 'email-already-in-use'));

        final call = authService.signUpWithEmailAndPassword;

        expect(
          () => call(email: email, password: password, username: username),
          throwsA(isA<EmailAlreadyInUseException>()),
        );
      },
    );
  });

  group('AuthService - signOut', () {
    test('Should call signOut successfully', () async {
      when(() => mockFirebaseAuth.signOut()).thenAnswer((_) async => {});

      await authService.signOut();

      verify(() => mockFirebaseAuth.signOut()).called(1);
    });

    test('Should throw UnknownAuthException if it fails', () async {
      when(() => mockFirebaseAuth.signOut()).thenThrow(Exception());

      expect(() => authService.signOut(), throwsA(isA<UnknownAuthException>()));
    });
  });

  group('AuthService - authStateChanges', () {
    test('Should emit an AppUser when stream changes', () async {
      when(() => mockUser.uid).thenReturn('123');
      when(() => mockUser.email).thenReturn('test@gmail.com');
      when(() => mockUser.displayName).thenReturn("test123");
      when(
        () => mockFirebaseAuth.authStateChanges(),
      ).thenAnswer((_) => Stream.fromIterable([mockUser]));

      expect(authService.authStateChanges, emits(isA<AppUser>()));
    });

    test('Should emit null if firebase returns null', () async {
      when(
        () => mockFirebaseAuth.authStateChanges(),
      ).thenAnswer((_) => Stream.value(null));

      expect(authService.authStateChanges, emits(null));
    });

    test('Should map multiple states correctly', () async {
      when(() => mockUser.uid).thenReturn('123');
      when(() => mockUser.email).thenReturn('teste@gmail.com');
      when(() => mockUser.displayName).thenReturn('Teste');

      when(
        () => mockFirebaseAuth.authStateChanges(),
      ).thenAnswer((_) => Stream.fromIterable([mockUser, null]));

      expect(
        authService.authStateChanges,
        emitsInOrder([isA<AppUser>(), null]),
      );
    });
  });

  group('AuthService - currentUser', () {
    test('Should return AppUser when there is an user signed in', () {
      when(() => mockFirebaseAuth.currentUser).thenReturn(mockUser);
      when(() => mockUser.uid).thenReturn('123');
      when(() => mockUser.email).thenReturn('teste@gmail.com');
      when(() => mockUser.displayName).thenReturn("test123");

      final user = authService.currentUser;

      expect(user, isA<AppUser>());
      expect(user?.id, equals('123'));
      verify(() => mockFirebaseAuth.currentUser).called(1);
    });

    test('Should return null when there is no signed in user', () {
      when(() => mockFirebaseAuth.currentUser).thenReturn(null);

      final user = authService.currentUser;

      expect(user, isNull);
    });
  });
}
