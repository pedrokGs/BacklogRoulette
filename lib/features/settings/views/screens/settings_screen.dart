import 'package:backlog_roulette/features/settings/views/widgets/include_free_tile.dart';
import 'package:backlog_roulette/features/settings/views/widgets/settings_tab.dart';
import 'package:backlog_roulette/features/settings/views/widgets/signout_tile.dart';
import 'package:backlog_roulette/features/settings/views/widgets/switch_theme_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';

class SettingsScreen extends ConsumerWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 32.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Configurações",
                style: GoogleFonts.poppins(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                "Ajuste o sistema como você quiser",
                style: TextStyle(fontSize: 16, color: Colors.grey[600]),
              ),
              const SizedBox(height: 8),
              Expanded(
                child: ListView(
                  children: [
                    SettingsTab(label: "Appearance"),
                    SwitchThemeTile(),
                    SettingsTab(label: "Library"),
                    IncludeFreeTile(),
                    SettingsTab(label: 'My Account'),
                    SignoutTile(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
