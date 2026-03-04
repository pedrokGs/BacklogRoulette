import 'dart:async';

import 'package:backlog_roulette/core/router/route_paths.dart';
import 'package:backlog_roulette/core/screens/home_screen.dart';
import 'package:backlog_roulette/features/auth/auth_di.dart';
import 'package:backlog_roulette/features/auth/data/services/auth_service.dart';
import 'package:backlog_roulette/features/auth/domain/entities/app_user.dart';
import 'package:backlog_roulette/features/auth/presentation/screens/signin_screen.dart';
import 'package:backlog_roulette/features/auth/presentation/screens/signup_screen.dart';
import 'package:backlog_roulette/features/auth/presentation/widgets/auth_button.dart';
import 'package:backlog_roulette/features/auth/presentation/widgets/custom_text_form_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../../../helpers/test_helper.dart';

class MockAuthService extends Mock implements AuthService {}

void main() {
  late ProviderContainer container;

  setUp(() {
    container = ProviderContainer();
  });

  testWidgets('all elements should be rendered correctly', (
    widgetTester,
  ) async {
    await widgetTester.pumpWidget(
      initializeWidget(
        container: container,
        initialLocation: RoutePaths.signin,
      ),
    );

    final titleFinder = find.text("Sign in.");
    expect(titleFinder, findsOneWidget);

    final emailFieldFinder = find.byType(CustomTextFormField).at(0);
    expect(emailFieldFinder, findsOneWidget);

    final passwordFieldFinder = find.byType(CustomTextFormField).at(1);
    expect(passwordFieldFinder, findsOneWidget);

    final hidePasswordButtonFinder = find.byIcon(Icons.visibility_off);
    expect(hidePasswordButtonFinder, findsOneWidget);

    final signInButtonFinder = find.byType(AuthButton);
    expect(signInButtonFinder, findsOneWidget);

    final createAnAccountLinkFinder = find.byType(RichText);

    expect(createAnAccountLinkFinder, findsAny);
  });

  testWidgets('sign up link should navigate to sign up screen', (
    widgetTester,
  ) async {
    await widgetTester.pumpWidget(
      initializeWidget(
        container: container,
        initialLocation: RoutePaths.signin,
      ),
    );

    final createAnAccountLinkFinder = find.byType(TextButton);
    expect(createAnAccountLinkFinder, findsOneWidget);

    await widgetTester.tap(createAnAccountLinkFinder);
    await widgetTester.pumpAndSettle();

    final signUpScreenFinder = find.byType(SignupScreen);
    expect(signUpScreenFinder, findsOneWidget);
  });

  testWidgets(
    'should display "field cannot be empty" message and stay at same screen when submitting form with empty fields',
    (widgetTester) async {
      await widgetTester.pumpWidget(
        initializeWidget(
          container: container,
          initialLocation: RoutePaths.signin,
        ),
      );

      final signInButton = find.byType(AuthButton);
      await widgetTester.tap(signInButton);
      await widgetTester.pump();

      expect(find.text("The fields are invalid"), findsOneWidget);
      expect(find.text("Email cannot be empty!"), findsOneWidget);
      expect(find.text("Password cannot be empty!"), findsOneWidget);
      expect(find.byType(SigninScreen), findsOneWidget);
    },
  );

  testWidgets(
    'should display "password is not strong enough" if validation fails',
    (widgetTester) async {
      await widgetTester.pumpWidget(
        initializeWidget(
          container: container,
          initialLocation: RoutePaths.signin,
        ),
      );

      final passwordFieldFinder = find.byType(CustomTextFormField).at(1);
      await widgetTester.enterText(passwordFieldFinder, 'weak');

      final signInButton = find.byType(AuthButton);
      await widgetTester.tap(signInButton);
      await widgetTester.pump();

      expect(find.text("Password is not strong enough!"), findsOneWidget);
    },
  );

  testWidgets('should display "invalid email" if email is not strong enough', (
    widgetTester,
  ) async {
    await widgetTester.pumpWidget(
      initializeWidget(
        container: container,
        initialLocation: RoutePaths.signin,
      ),
    );

    final emailFieldFinder = find.byType(CustomTextFormField).at(0);
    await widgetTester.enterText(emailFieldFinder, 'invalid-email.com');

    final signInButton = find.byType(AuthButton);
    await widgetTester.tap(signInButton);
    await widgetTester.pump();

    expect(find.text("Email is invalid!"), findsOneWidget);
  });

  testWidgets('Sign in should complete successfully if fields are valid', (
    widgetTester,
  ) async {
    final mockService = MockAuthService();
    final mockUser = AppUser(
      id: '123',
      email: 'test@gmail.com',
      username: 'testUser',
    );

    final authStreamController = StreamController<AppUser?>.broadcast();

    when(
      () => mockService.authStateChanges,
    ).thenAnswer((_) => authStreamController.stream);

    authStreamController.add(null);

    when(
      () => mockService.signInWithEmailAndPassword(
        email: 'test@gmail.com',
        password: 'TestPassword123',
      ),
    ).thenAnswer((_) async => mockUser);

    final container = ProviderContainer(
      overrides: [authServiceProvider.overrideWithValue(mockService)],
    );

    await widgetTester.pumpWidget(
      initializeWidget(
        container: container,
        initialLocation: RoutePaths.signin,
        shouldIncludeAuthentication: true,
      ),
    );

    final emailFieldFinder = find.byType(CustomTextFormField).at(0);
    final passwordFieldFinder = find.byType(CustomTextFormField).at(1);
    final signInButton = find.byType(AuthButton);

    await widgetTester.enterText(emailFieldFinder, "test@gmail.com");
    await widgetTester.enterText(passwordFieldFinder, "TestPassword123");
    await widgetTester.tap(signInButton);

    authStreamController.add(mockUser);

    await widgetTester.pump();
    await widgetTester.pumpAndSettle();

    expect(find.byType(HomeScreen), findsOneWidget);

    authStreamController.close();
  });
}
