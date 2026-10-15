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
}
