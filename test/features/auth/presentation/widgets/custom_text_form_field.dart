import 'package:backlog_roulette/features/auth/presentation/widgets/custom_text_form_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  late TextEditingController textController;

  setUp(() {
    textController = TextEditingController();

    addTearDown(() => textController);
  });

  testWidgets('All elements are properly rendered', (widgetTester) async {
    await widgetTester.pumpWidget(
      MaterialApp(
        home: Material(
          child: CustomTextFormField(
            hintText: 'Test',
            icon: const Icon(Icons.abc),
            textEditingController: textController,
            isPassword: true,
          ),
        ),
      ),
    );

    final hintTextFinder = find.text('Test');
    expect(hintTextFinder, findsOneWidget);

    final hidePasswordButtonFinder = find.byIcon(Icons.visibility_off);
    expect(hidePasswordButtonFinder, findsOneWidget);

    final iconFinder = find.byIcon(Icons.abc);
    expect(iconFinder, findsOneWidget);
  });

  testWidgets('Text can be entered and is on controller', (widgetTester) async {
    await widgetTester.pumpWidget(
      MaterialApp(
        home: Material(
          child: CustomTextFormField(
            hintText: 'Test',
            textEditingController: textController,
            icon: const Icon(Icons.abc),
          ),
        ),
      ),
    );
    final textFieldFinder = find.byType(TextFormField);

    await widgetTester.enterText(textFieldFinder, "Example Text");
    await widgetTester.pump();

    expect(textController.text, equals("Example Text"));
    expect(find.text("Example Text"), findsOneWidget);
  });

  testWidgets('obscured password works', (widgetTester) async {
    await widgetTester.pumpWidget(
      MaterialApp(
        home: Material(
          child: CustomTextFormField(
            hintText: 'Password',
            textEditingController: textController,
            icon: const Icon(Icons.abc),
            isPassword: true,
          ),
        ),
      ),
    );

    final textFieldFinder = find.byType(TextFormField);
    final textField = widgetTester.widget<TextField>(
      find.descendant(
        of: find.byType(TextFormField),
        matching: find.byType(TextField),
      ),
    );

    await widgetTester.enterText(textFieldFinder, "#P4ssw0rd");
    await widgetTester.pump();

    expect(find.text("#P4ssw0rd"), findsOneWidget);

    final hidePasswordButtonFinder = find.byIcon(Icons.visibility_off);
    expect(hidePasswordButtonFinder, findsOneWidget);
    expect(textField.obscureText, isTrue);

    await widgetTester.tap(hidePasswordButtonFinder);
    await widgetTester.pump();

    expect(find.byIcon(Icons.visibility), findsOneWidget);
    expect(textField.obscureText, isFalse);

    await widgetTester.tap(hidePasswordButtonFinder);
    await widgetTester.pump();

    expect(find.byIcon(Icons.visibility_off), findsOneWidget);
    expect(textField.obscureText, isTrue);
  });
}
