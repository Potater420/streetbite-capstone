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

  /// e.g. "Oct 17, 2026, 3:45 PM", in the current language.
  String formatDateTime(DateTime value) =>
      DateFormat.yMMMd(Localizations.localeOf(this).toString())
          .add_jm()
          .format(value);
}
