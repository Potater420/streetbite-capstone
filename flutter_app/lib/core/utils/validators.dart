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

  static String? cardNumber(String? value, AppLocalizations l10n) {
    final digits = value?.replaceAll(' ', '') ?? '';
    return RegExp(r'^\d{16}$').hasMatch(digits)
        ? null
        : l10n.validationCardNumber;
  }

  static String? cardName(String? value, AppLocalizations l10n) {
    return (value?.trim().isEmpty ?? true) ? l10n.validationCardName : null;
  }

  static String? cardExpiry(String? value, AppLocalizations l10n) {
    final match = RegExp(r'^(0[1-9]|1[0-2])/(\d{2})$').firstMatch(value ?? '');
    if (match == null) return l10n.validationCardExpiry;
    final month = int.parse(match.group(1)!);
    final year = 2000 + int.parse(match.group(2)!);
    final now = DateTime.now();
    final isPast = year < now.year || (year == now.year && month < now.month);
    return isPast ? l10n.validationCardExpiry : null;
  }

  static String? cardCvv(String? value, AppLocalizations l10n) {
    return RegExp(r'^\d{3,4}$').hasMatch(value ?? '')
        ? null
        : l10n.validationCardCvv;
  }
}
