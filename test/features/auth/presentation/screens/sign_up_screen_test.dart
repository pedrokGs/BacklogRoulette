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
        initialLocation: RoutePaths.signup,
      ),
    );

    final titleFinder = find.text("Sign up.");
    expect(titleFinder, findsOneWidget);

    final usernameFieldFinder = find.byType(CustomTextFormField).at(0);
    expect(usernameFieldFinder, findsOneWidget);

    final emailFieldFinder = find.byType(CustomTextFormField).at(1);
    expect(emailFieldFinder, findsOneWidget);

    final passwordFieldFinder = find.byType(CustomTextFormField).at(2);
    expect(passwordFieldFinder, findsOneWidget);

    final confirmPasswordFieldFinder = find.byType(CustomTextFormField).at(3);
    expect(confirmPasswordFieldFinder, findsOneWidget);

    final hidePasswordButtonFinder = find.byIcon(Icons.visibility_off);
    expect(hidePasswordButtonFinder, findsNWidgets(2));

    final signUpButtonFinder = find.byType(AuthButton);
    expect(signUpButtonFinder, findsOneWidget);

    final signInLinkFinder = find.byType(RichText);

    expect(signInLinkFinder, findsAny);
  });

  testWidgets('sign in link should navigate to sign in screen', (
    widgetTester,
  ) async {
    await widgetTester.pumpWidget(
      initializeWidget(
        container: container,
        initialLocation: RoutePaths.signup,
      ),
    );

    final signInLinkFinder = find.byType(TextButton);
    expect(signInLinkFinder, findsOneWidget);

    await widgetTester.tap(signInLinkFinder);
    await widgetTester.pumpAndSettle();

    final signInScreenFinder = find.byType(SigninScreen);
    expect(signInScreenFinder, findsOneWidget);
  });

  testWidgets(
    'should display "field cannot be empty" message and stay at same screen when submitting form with empty fields',
    (widgetTester) async {
      await widgetTester.pumpWidget(
        initializeWidget(
          container: container,
          initialLocation: RoutePaths.signup,
        ),
      );

      final signInButton = find.byType(AuthButton);
      await widgetTester.tap(signInButton);
      await widgetTester.pump();

      expect(find.text("The fields are invalid"), findsOneWidget);
      expect(find.text("Email cannot be empty!"), findsOneWidget);
      expect(find.text("Password cannot be empty!"), findsOneWidget);
      expect(find.byType(SignupScreen), findsOneWidget);
    },
  );

  testWidgets(
    'should display "password is not strong enough" if validation fails',
    (widgetTester) async {
      await widgetTester.pumpWidget(
        initializeWidget(
          container: container,
          initialLocation: RoutePaths.signup,
        ),
      );

      final passwordFieldFinder = find.byType(CustomTextFormField).at(2);
      await widgetTester.enterText(passwordFieldFinder, 'weak');

      final signInButton = find.byType(AuthButton);
      await widgetTester.tap(signInButton);
      await widgetTester.pump();

      expect(find.text("Password is not strong enough!"), findsOneWidget);
    },
  );

  testWidgets('should display "invalid email" if email is malformed', (
    widgetTester,
  ) async {
    await widgetTester.pumpWidget(
      initializeWidget(
        container: container,
        initialLocation: RoutePaths.signup,
      ),
    );

    final emailFieldFinder = find.byType(CustomTextFormField).at(1);
    await widgetTester.enterText(emailFieldFinder, 'invalid-email.com');

    final signInButton = find.byType(AuthButton);
    await widgetTester.tap(signInButton);
    await widgetTester.pump();

    expect(find.text("Email is invalid!"), findsOneWidget);
  });

  testWidgets(
    'Entering a different password in confirm password field should display an error message',
    (widgetTester) async {
      await widgetTester.pumpWidget(
        initializeWidget(
          container: container,
          initialLocation: RoutePaths.signup,
        ),
      );

      final passwordFieldFinder = find.byType(CustomTextFormField).at(2);
      final confirmPasswordFieldFinder = find.byType(CustomTextFormField).at(3);

      await widgetTester.enterText(passwordFieldFinder, "Password");
      await widgetTester.enterText(confirmPasswordFieldFinder, "password");

      final signInButton = find.byType(AuthButton);
      await widgetTester.tap(signInButton);
      await widgetTester.pump();

      expect(find.text("The passwords don't match!"), findsOneWidget);
    },
  );

  testWidgets('Sign up should complete successfully if fields are valid', (
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
      () => mockService.signUpWithEmailAndPassword(
        username: 'testUser',
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

    final createAccountLink = find.byType(TextButton);
    await widgetTester.tap(createAccountLink);
    await widgetTester.pump();

    final usernameFieldFinder = find.byType(CustomTextFormField).at(0);
    final emailFieldFinder = find.byType(CustomTextFormField).at(1);
    final passwordFieldFinder = find.byType(CustomTextFormField).at(2);
    final confirmPasswordFieldFinder = find.byType(CustomTextFormField).at(3);
    final signInButton = find.byType(AuthButton).last;

    await widgetTester.enterText(usernameFieldFinder, "testUser");
    await widgetTester.enterText(emailFieldFinder, "test@gmail.com");
    await widgetTester.enterText(passwordFieldFinder, "TestPassword123");
    await widgetTester.enterText(confirmPasswordFieldFinder, "TestPassword123");
    await widgetTester.tap(signInButton);

    authStreamController.add(mockUser);

    await widgetTester.pump();
    await widgetTester.pumpAndSettle();

    expect(find.byType(HomeScreen), findsOneWidget);

    authStreamController.close();
  });
}
