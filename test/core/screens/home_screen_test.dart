import 'package:backlog_roulette/core/providers/home_screen_index_provider.dart';
import 'package:backlog_roulette/core/screens/home_screen.dart';
import 'package:backlog_roulette/features/games/presentation/screens/library_screen.dart';
import 'package:backlog_roulette/features/games/presentation/screens/roulette_screen.dart';
import 'package:backlog_roulette/features/settings/presentation/screens/settings_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../helpers/test_helper.dart';

void main() {
  late ProviderContainer container;
  setUp(() {
    container = ProviderContainer();
  });

  testWidgets('bottom navigation bar and its itens should render correctly', (
    widgetTester,
  ) async {
    await widgetTester.pumpWidget(initializeWidget(HomeScreen()));

    final bottomNavFinder = find.byType(BottomNavigationBar);
    expect(bottomNavFinder, findsOneWidget);

    final libraryItem = find.descendant(
      of: bottomNavFinder,
      matching: find.byIcon(Icons.videogame_asset_sharp),
    );
    expect(libraryItem, findsOneWidget);

    final rouletteItem = find.descendant(
      of: bottomNavFinder,
      matching: find.byIcon(Icons.loop),
    );
    expect(rouletteItem, findsOneWidget);

    final settingsItem = find.descendant(
      of: bottomNavFinder,
      matching: find.byIcon(Icons.settings),
    );
    expect(settingsItem, findsOneWidget);
  });

  testWidgets('navigation should be working', (widgetTester) async {
    await widgetTester.pumpWidget(
      initializeWidget(HomeScreen(), container: container),
    );

    // Start at library screen
    final libraryScreenFinder = find.byType(LibraryScreen);
    expect(libraryScreenFinder, findsOneWidget);
    expect(container.read(homeScreenIndexProvider), equals(0));

    final rouletteButton = find.text("Roulette");
    await widgetTester.tap(rouletteButton);
    await widgetTester.pumpAndSettle();

    // go to roulette
    final rouletteScreenFinder = find.byType(RouletteScreen);
    expect(rouletteScreenFinder, findsOneWidget);
    expect(container.read(homeScreenIndexProvider), equals(1));

    final settingsButton = find.text("Settings");
    await widgetTester.tap(settingsButton);
    await widgetTester.pumpAndSettle();

    // then settings
    final settingsScreenFinder = find.byType(SettingsScreen);
    expect(settingsScreenFinder, findsOneWidget);
    expect(container.read(homeScreenIndexProvider), equals(2));
  });
}
