// ignore: unused_import
import 'package:intl/intl.dart' as intl;

import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Arabic (`ar`).
class AppLocalizationsAr extends AppLocalizations {
  AppLocalizationsAr([String locale = 'ar']) : super(locale);

  @override
  String get appName => 'ستريت بايت';

  @override
  String get errorNetwork =>
      'تعذّر الاتصال بالإنترنت. تحقق من اتصالك وحاول مرة أخرى.';

  @override
  String get errorTimeout => 'استغرق الطلب وقتًا طويلًا. حاول مرة أخرى.';

  @override
  String get errorServer => 'حدث خطأ في الخادم. حاول لاحقًا.';

  @override
  String get errorInvalidCredentials =>
      'البريد الإلكتروني أو كلمة المرور غير صحيحة.';

  @override
  String get errorEmailInUse => 'هذا البريد الإلكتروني مسجّل بالفعل.';

  @override
  String get errorWeakPassword => 'كلمة المرور ضعيفة جدًا.';

  @override
  String get errorInvalidEmail => 'صيغة البريد الإلكتروني غير صحيحة.';

  @override
  String get errorTooManyRequests => 'محاولات كثيرة. حاول لاحقًا.';

  @override
  String get errorUnknown => 'حدث خطأ غير متوقع. حاول مرة أخرى.';

  @override
  String get loginTitle => 'مرحبًا بعودتك';

  @override
  String get loginSubtitle => 'سجّل الدخول لطلب أكلات الشارع المفضلة لديك';

  @override
  String get signupTitle => 'أنشئ حسابك';

  @override
  String get signupSubtitle =>
      'انضم إلى ستريت بايت واكتشف أكلات الشارع بالقرب منك';

  @override
  String get fullNameHint => 'الاسم الكامل';

  @override
  String get emailHint => 'البريد الإلكتروني';

  @override
  String get passwordHint => 'كلمة المرور';

  @override
  String get confirmPasswordHint => 'تأكيد كلمة المرور';

  @override
  String get loginButton => 'تسجيل الدخول';

  @override
  String get signupButton => 'إنشاء حساب';

  @override
  String get noAccountPrompt => 'ليس لديك حساب؟';

  @override
  String get haveAccountPrompt => 'لديك حساب بالفعل؟';

  @override
  String get validationNameRequired => 'يرجى إدخال اسمك الكامل';

  @override
  String get validationNameCapital => 'يجب أن يبدأ الاسم بحرف كبير';

  @override
  String get validationEmailRequired => 'يرجى إدخال البريد الإلكتروني';

  @override
  String get validationEmailInvalid => 'أدخل بريدًا إلكترونيًا صحيحًا';

  @override
  String get validationPasswordRequired => 'يرجى إدخال كلمة المرور';

  @override
  String get validationPasswordShort => 'يجب ألا تقل كلمة المرور عن 6 أحرف';

  @override
  String get validationConfirmRequired => 'يرجى تأكيد كلمة المرور';

  @override
  String get validationPasswordMismatch => 'كلمتا المرور غير متطابقتين';

  @override
  String homeWelcome(String name) {
    return 'مرحبًا، $name!';
  }

  @override
  String get logoutButton => 'تسجيل الخروج';

  @override
  String get changeLanguage => 'تغيير اللغة';

  @override
  String homeGreeting(String name) {
    return 'أهلًا، $name';
  }

  @override
  String get searchHint => 'ابحث عن وجبة';

  @override
  String get categoryAll => 'الكل';

  @override
  String get hotOffersTitle => 'عروض ساخنة';

  @override
  String get allMealsTitle => 'كل الوجبات';

  @override
  String get noMealsFound => 'لا توجد وجبات';

  @override
  String get retryButton => 'حاول مرة أخرى';

  @override
  String get addToCart => 'أضف إلى السلة';

  @override
  String addedToCart(String name) {
    return 'تمت إضافة $name إلى السلة';
  }

  @override
  String get cartTooltip => 'السلة';

  @override
  String get toggleTheme => 'تبديل المظهر';

  @override
  String get instructionsTitle => 'طريقة التحضير';

  @override
  String addToCartWithPrice(String price) {
    return 'أضف إلى السلة • $price';
  }

  @override
  String addAnotherWithCount(int count) {
    return 'أضف المزيد • $count في السلة';
  }

  @override
  String get addToFavorites => 'أضف إلى المفضلة';

  @override
  String get removeFromFavorites => 'إزالة من المفضلة';

  @override
  String get cartTitle => 'الطلب';

  @override
  String get deliveryLabel => 'توصيل';

  @override
  String get pickupLabel => 'استلام';

  @override
  String get seeMenu => 'عرض القائمة';

  @override
  String get summaryOrder => 'الطلب';

  @override
  String get summaryDeliveryFee => 'رسوم التوصيل';

  @override
  String get summaryTaxes => 'الرسوم والضرائب';

  @override
  String get summaryTotal => 'الإجمالي';

  @override
  String get continueButton => 'متابعة';

  @override
  String get cartEmpty => 'سلتك فارغة';

  @override
  String get browseMeals => 'تصفح الوجبات';

  @override
  String get removeFromCart => 'إزالة';

  @override
  String get decreaseQuantity => 'تقليل الكمية';

  @override
  String get increaseQuantity => 'زيادة الكمية';

  @override
  String get checkoutTitle => 'إتمام الطلب';

  @override
  String get paymentMethodTitle => 'طريقة الدفع';

  @override
  String get payCash => 'نقدًا';

  @override
  String get payCashSubtitle => 'ادفع عند الاستلام';

  @override
  String get payCard => 'بطاقة';

  @override
  String get payCardSubtitle => 'ادفع الآن';

  @override
  String get cardNumberHint => 'رقم البطاقة';

  @override
  String get cardNameHint => 'الاسم على البطاقة';

  @override
  String get cardExpiryHint => 'شهر/سنة';

  @override
  String get cardCvvHint => 'رمز الأمان';

  @override
  String placeOrderWithTotal(String total) {
    return 'تأكيد الطلب • $total';
  }

  @override
  String get validationCardNumber => 'أدخل رقم بطاقة من 16 رقمًا';

  @override
  String get validationCardName => 'أدخل الاسم على البطاقة';

  @override
  String get validationCardExpiry =>
      'أدخل تاريخًا صالحًا في المستقبل (شهر/سنة)';

  @override
  String get validationCardCvv => 'أدخل رمزًا من 3 أو 4 أرقام';

  @override
  String get errorInvalidCard => 'بيانات البطاقة غير صحيحة.';

  @override
  String get orderPlacedTitle => 'تم تأكيد الطلب!';

  @override
  String orderPlacedMessage(String number) {
    return 'تم استلام طلبك رقم #$number.';
  }

  @override
  String get backToHome => 'العودة إلى الرئيسية';

  @override
  String get navHome => 'الرئيسية';

  @override
  String get navFavorites => 'المفضلة';

  @override
  String get navOrders => 'الطلبات';

  @override
  String get navProfile => 'الملف الشخصي';

  @override
  String get favoritesTitle => 'المفضلة';

  @override
  String get favoritesEmpty =>
      'لا توجد مفضلات بعد. اضغط على القلب في أي وجبة لحفظها.';

  @override
  String get ordersTitle => 'الطلبات';

  @override
  String get ordersEmpty => 'لم تقم بأي طلب بعد.';

  @override
  String orderItemsCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count عنصرًا',
      few: '$count عناصر',
      two: 'عنصران',
      one: 'عنصر واحد',
      zero: 'لا عناصر',
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
