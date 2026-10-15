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
}
