import 'package:backlog_roulette/core/l10n/app_localizations.dart';
import 'package:backlog_roulette/core/providers/home_screen_index_provider.dart';
import 'package:backlog_roulette/features/games/presentation/screens/library_screen.dart';
import 'package:backlog_roulette/features/games/presentation/screens/roulette_screen.dart';
import 'package:backlog_roulette/features/settings/presentation/screens/settings_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  final PageController _pageController = PageController();

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    const List<Widget> screens = [
      LibraryScreen(),
      RouletteScreen(),
      SettingsScreen(),
    ];

    return Scaffold(
      body: PageView(
        controller: _pageController,
        onPageChanged: (index) {
          ref.read(homeScreenIndexProvider.notifier).update(index);
        },
        children: screens,
      ),
      bottomNavigationBar: BottomNavigationBar(
        selectedIconTheme: IconThemeData(size: 40),
        elevation: 5,
        showUnselectedLabels: false,
        enableFeedback: true,
        selectedFontSize: 17,
        currentIndex: ref.watch(homeScreenIndexProvider),
        onTap: (index) {
          _pageController.animateToPage(
            index,
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeInOut,
          );
        },
        items: [
          BottomNavigationBarItem(
            icon: const Icon(Icons.videogame_asset_sharp),
            label: AppLocalizations.of(
              context,
            )!.bottom_navigation_bar_library_label,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.loop),
            label: AppLocalizations.of(
              context,
            )!.bottom_navigation_bar_roulette_label,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: AppLocalizations.of(
              context,
            )!.bottom_navigation_bar_settings_label,
          ),
        ],
      ),
    );
  }
}
