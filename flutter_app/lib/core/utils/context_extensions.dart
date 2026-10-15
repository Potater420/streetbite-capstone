import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';
import 'package:streetbite/l10n/app_localizations.dart';

extension L10nContext on BuildContext {
  AppLocalizations get l10n => AppLocalizations.of(this)!;

  /// Formats a price using the current language's number style.
  String formatPrice(double value) => NumberFormat.currency(
        locale: Localizations.localeOf(this).toString(),
        symbol: r'$',
      ).format(value);
}