import 'package:flutter/widgets.dart';
import 'package:streetbite/l10n/app_localizations.dart';

extension L10nContext on BuildContext {
  AppLocalizations get l10n => AppLocalizations.of(this)!;
}

//shortcut so screens can write context.l10n.appName, review this later