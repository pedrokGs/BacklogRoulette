import 'package:backlog_roulette/core/l10n/app_localizations.dart';

class Validators {
  static String? validateEmail(String? value, AppLocalizations l10n) {
    if (value == null || value.trim().isEmpty) {
      return l10n.validators_email_cannot_be_empty;
    }

    final regex = r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$';
    if (!RegExp(regex).hasMatch(value)) {
      return l10n.validators_email_is_invalid;
    }
    return null;
  }

  static String? validatePassword(String? value, AppLocalizations l10n) {
    if (value == null || value.trim().isEmpty) {
      return l10n.validators_password_cannot_be_empty;
    }

    final regex = r'^(?=.*[A-Za-z])(?=.*\d)[A-Za-z\d]{8,}$';
    if (!RegExp(regex).hasMatch(value)) {
      return l10n.validators_password_is_not_strong_enough;
    }
    return null;
  }

  static String? validateUsername(String? value, AppLocalizations l10n) {
    if (value == null || value.trim().isEmpty) {
      return l10n.validators_username_cannot_be_empty;
    }
    return null;
  }
}
