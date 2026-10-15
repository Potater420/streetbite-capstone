import 'package:streetbite/l10n/app_localizations.dart';

/// Form validators. They return a localized message, or null when valid.
class Validators {
  Validators._();

  static String? fullName(String? value, AppLocalizations l10n) {
    final name = value?.trim() ?? '';
    if (name.isEmpty) return l10n.validationNameRequired;
    // Lowercase letters fail; scripts without case (e.g. Arabic) pass.
    if (name[0] != name[0].toUpperCase()) return l10n.validationNameCapital;
    return null;
  }

  static String? email(String? value, AppLocalizations l10n) {
    final email = value?.trim() ?? '';
    if (email.isEmpty) return l10n.validationEmailRequired;
    final valid = RegExp(r'^[^@\s]+@[^@\s]+\.[^@\s]+$').hasMatch(email);
    return valid ? null : l10n.validationEmailInvalid;
  }

  static String? password(String? value, AppLocalizations l10n) {
    final password = value ?? '';
    if (password.isEmpty) return l10n.validationPasswordRequired;
    if (password.length < 6) return l10n.validationPasswordShort;
    return null;
  }

  static String? confirmPassword(
    String? value,
    String password,
    AppLocalizations l10n,
  ) {
    if (value == null || value.isEmpty) return l10n.validationConfirmRequired;
    return value == password ? null : l10n.validationPasswordMismatch;
  }
}