import 'package:backlog_roulette/core/l10n/app_localizations.dart';
import 'package:backlog_roulette/features/games/views/screens/library_screen.dart';
import 'package:backlog_roulette/features/games/views/screens/roulette_screen.dart';
import 'package:backlog_roulette/features/settings/views/screens/settings_screen.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final PageController _pageController = PageController();
  int selectedIndex = 0;
  List<Widget> screens = [LibraryScreen(), RouletteScreen(), SettingsScreen()];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: _pageController,
        onPageChanged: (index) {
          setState(() {
            selectedIndex = index;
          });
        },
        children: screens,
      ),
      bottomNavigationBar: BottomNavigationBar(
        selectedIconTheme: IconThemeData(size: 40),

        selectedFontSize: 17,
        currentIndex: selectedIndex,
        onTap: (index) {
          _pageController.animateToPage(
            index,
            duration: const Duration(milliseconds: 400),
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
