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

  @override
  String get instructionsTitle => 'Instructions';

  @override
  String addToCartWithPrice(String price) {
    return 'Add to cart • $price';
  }

  @override
  String addAnotherWithCount(int count) {
    return 'Add another • $count in cart';
  }

  @override
  String get addToFavorites => 'Add to favourites';

  @override
  String get removeFromFavorites => 'Remove from favourites';

  @override
  String get cartTitle => 'Order';

  @override
  String get deliveryLabel => 'Delivery';

  @override
  String get pickupLabel => 'Pickup';

  @override
  String get seeMenu => 'See menu';

  @override
  String get summaryOrder => 'Order';

  @override
  String get summaryDeliveryFee => 'Delivery fee';

  @override
  String get summaryTaxes => 'Fees & taxes';

  @override
  String get summaryTotal => 'Total';

  @override
  String get continueButton => 'Continue';

  @override
  String get cartEmpty => 'Your cart is empty';

  @override
  String get browseMeals => 'Browse meals';

  @override
  String get removeFromCart => 'Remove';

  @override
  String get decreaseQuantity => 'Decrease quantity';

  @override
  String get increaseQuantity => 'Increase quantity';

  @override
  String get checkoutTitle => 'Checkout';

  @override
  String get paymentMethodTitle => 'Payment method';

  @override
  String get payCash => 'Cash';

  @override
  String get payCashSubtitle => 'Pay when you receive it';

  @override
  String get payCard => 'Card';

  @override
  String get payCardSubtitle => 'Pay now';

  @override
  String get cardNumberHint => 'Card number';

  @override
  String get cardNameHint => 'Name on card';

  @override
  String get cardExpiryHint => 'MM/YY';

  @override
  String get cardCvvHint => 'CVV';

  @override
  String placeOrderWithTotal(String total) {
    return 'Place order • $total';
  }

  @override
  String get validationCardNumber => 'Enter a 16-digit card number';

  @override
  String get validationCardName => 'Enter the name on the card';

  @override
  String get validationCardExpiry => 'Enter a valid future date (MM/YY)';

  @override
  String get validationCardCvv => 'Enter a 3 or 4 digit code';

  @override
  String get errorInvalidCard => 'The card details are not valid.';

  @override
  String get orderPlacedTitle => 'Order placed!';

  @override
  String orderPlacedMessage(String number) {
    return 'Your order #$number has been received.';
  }

  @override
  String get backToHome => 'Back to home';

  @override
  String get navHome => 'Home';

  @override
  String get navFavorites => 'Favourites';

  @override
  String get navOrders => 'Orders';

  @override
  String get navProfile => 'Profile';

  @override
  String get favoritesTitle => 'Favourites';

  @override
  String get favoritesEmpty =>
      'No favourites yet. Tap the heart on a meal to save it.';

  @override
  String get ordersTitle => 'Orders';

  @override
  String get ordersEmpty => 'You haven\'t placed any orders yet.';

  @override
  String orderItemsCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count items',
      one: '1 item',
    );
    return '$_temp0';
  }

  @override
  String get changePhoto => 'تغيير الصورة';

  @override
  String get profileLanguage => 'اللغة';

  @override
  String get languageName => 'العربية';

  @override
  String get profileDarkMode => 'الوضع الداكن';

  @override
  String get recentOrdersTitle => 'أحدث الطلبات';

  @override
  String get deviceDetailsTitle => 'تفاصيل الجهاز';

  @override
  String get deviceModelLabel => 'الجهاز';

  @override
  String get deviceOsLabel => 'النظام';

  @override
  String get biometricReason => 'تحقق من هويتك لفتح ملفك الشخصي';

  @override
  String get biometricFailed => 'فشلت المصادقة. سيبقى ملفك الشخصي مقفلًا.';

  @override
  String get biometricUnavailable =>
      'قفل البصمة غير مفعّل على هذا الجهاز، لذلك فُتح الملف الشخصي بدونه.';
}
