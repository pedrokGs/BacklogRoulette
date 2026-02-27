import 'package:backlog_roulette/core/l10n/app_localizations.dart';
import 'package:backlog_roulette/features/settings/presentation/widgets/sign_out_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// ListTile for Signing out
class SignoutTile extends ConsumerWidget {
  const SignoutTile({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ListTile(
      leading: const Icon(Icons.logout, color: Colors.redAccent),
      title: Text(
        AppLocalizations.of(context)!.settings_screen_sign_out_button_label,
        style: Theme.of(
          context,
        ).textTheme.bodyLarge?.copyWith(color: Colors.redAccent),
      ),
      onTap: () => _showLogoutDialog(context, ref),
    );
  }

  Future<void> _showLogoutDialog(BuildContext context, WidgetRef ref) async {
    HapticFeedback.mediumImpact();

    return showDialog(context: context, builder: (context) => SignOutDialog());
  }
}
