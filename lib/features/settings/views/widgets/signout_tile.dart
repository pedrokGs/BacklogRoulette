import 'package:backlog_roulette/features/auth/auth_di.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class SignoutTile extends ConsumerWidget {
  const SignoutTile({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ListTile(
      leading: const Icon(Icons.logout, color: Colors.redAccent),
      title: Text(
        'Sign out',
        style: Theme.of(
          context,
        ).textTheme.bodyLarge?.copyWith(color: Colors.redAccent),
      ),
      onTap: () => _showLogoutDialog(context, ref),
    );
  }

  Future<void> _showLogoutDialog(BuildContext context, WidgetRef ref) async {
    HapticFeedback.mediumImpact();

    return showDialog(
      context: context,
      builder: (context) {
        final colorScheme = Theme.of(context).colorScheme;
        final textTheme = Theme.of(context).textTheme;

        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          backgroundColor: colorScheme.surface,
          title: Text(
            "Log Out",
            style: textTheme.headlineSmall?.copyWith(
              fontWeight: FontWeight.bold,
              color: colorScheme.onSurface,
            ),
          ),
          content: Text(
            "Are you sure you want to log out? You will need to sign in again to access your data.",
            style: textTheme.bodyMedium?.copyWith(
              color: colorScheme.onSurfaceVariant,
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text(
                "Cancel",
                style: TextStyle(color: colorScheme.primary),
              ),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: colorScheme.errorContainer,
                foregroundColor: colorScheme.onErrorContainer,
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              onPressed: () {
                HapticFeedback.vibrate();
                ref.read(authNotifierProvider.notifier).signOut();
                context.pop();
              },
              child: const Text("Log Out"),
            ),
          ],
        );
      },
    );
  }
}
