import 'package:backlog_roulette/core/l10n/app_localizations.dart';
import 'package:backlog_roulette/features/settings/views/widgets/change_language_tile.dart';
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
                AppLocalizations.of(context)!.settings_screen_title,
                style: GoogleFonts.poppins(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                AppLocalizations.of(context)!.settings_screen_subtitle,
                style: TextStyle(fontSize: 16, color: Colors.grey[600]),
              ),
              const SizedBox(height: 8),
              Expanded(
                child: ListView(
                  children: [
                    SettingsTab(
                      label: AppLocalizations.of(
                        context,
                      )!.settings_screen_appearance_divider_label,
                    ),
                    SwitchThemeTile(),
                    ChangeLanguageTile(),
                    SettingsTab(
                      label: AppLocalizations.of(
                        context,
                      )!.settings_screen_library_divider_label,
                    ),
                    IncludeFreeTile(),
                    SettingsTab(
                      label: AppLocalizations.of(
                        context,
                      )!.settings_screen_my_account_divider_label,
                    ),
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
