// ignore: unused_import
import 'package:intl/intl.dart' as intl;

import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appName => 'StreetBite';

  @override
  String get errorNetwork =>
      'Can\'t reach the internet. Check your connection and try again.';

  @override
  String get errorTimeout => 'The request took too long. Please try again.';

  @override
  String get errorServer =>
      'Something went wrong on our side. Please try later.';

  @override
  String get errorInvalidCredentials => 'Incorrect email or password.';

  @override
  String get errorEmailInUse => 'This email is already registered.';

  @override
  String get errorWeakPassword => 'That password is too weak.';

  @override
  String get errorInvalidEmail => 'Please enter a valid email address.';

  @override
  String get errorTooManyRequests =>
      'Too many attempts. Please try again later.';

  @override
  String get errorUnknown => 'An unexpected error occurred. Please try again.';
}
