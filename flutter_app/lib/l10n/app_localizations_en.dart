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

  @override
  String get loginTitle => 'Welcome back';

  @override
  String get loginSubtitle => 'Log in to order your favourite street food';

  @override
  String get signupTitle => 'Create your account';

  @override
  String get signupSubtitle =>
      'Join StreetBite and discover street food near you';

  @override
  String get fullNameHint => 'Full name';

  @override
  String get emailHint => 'Email';

  @override
  String get passwordHint => 'Password';

  @override
  String get confirmPasswordHint => 'Confirm password';

  @override
  String get loginButton => 'Log in';

  @override
  String get signupButton => 'Sign up';

  @override
  String get noAccountPrompt => 'Don\'t have an account?';

  @override
  String get haveAccountPrompt => 'Already have an account?';

  @override
  String get validationNameRequired => 'Please enter your full name';

  @override
  String get validationNameCapital => 'Name must start with a capital letter';

  @override
  String get validationEmailRequired => 'Please enter your email';

  @override
  String get validationEmailInvalid => 'Enter a valid email address';

  @override
  String get validationPasswordRequired => 'Please enter your password';

  @override
  String get validationPasswordShort =>
      'Password must be at least 6 characters';

  @override
  String get validationConfirmRequired => 'Please confirm your password';

  @override
  String get validationPasswordMismatch => 'Passwords do not match';

  @override
  String homeWelcome(String name) {
    return 'Welcome, $name!';
  }

  @override
  String get logoutButton => 'Log out';

  @override
  String get changeLanguage => 'Change language';

  @override
  String homeGreeting(String name) {
    return 'Hi, $name';
  }

  @override
  String get searchHint => 'Search meals';

  @override
  String get categoryAll => 'All';

  @override
  String get hotOffersTitle => 'Hot Offers';

  @override
  String get allMealsTitle => 'All meals';

  @override
  String get noMealsFound => 'No meals found';

  @override
  String get retryButton => 'Try again';

  @override
  String get addToCart => 'Add to cart';

  @override
  String addedToCart(String name) {
    return '$name added to cart';
  }

  @override
  String get cartTooltip => 'Cart';

  @override
  String get toggleTheme => 'Toggle theme';
}
