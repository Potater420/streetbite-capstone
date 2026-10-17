import 'package:streetbite/core/errors/failure.dart';
import 'package:streetbite/l10n/app_localizations.dart';

extension FailureMessage on Failure {
  String localized(AppLocalizations l10n) {
    switch (type) {
      case FailureType.network:
        return l10n.errorNetwork;
      case FailureType.timeout:
        return l10n.errorTimeout;
      case FailureType.server:
        return l10n.errorServer;
      case FailureType.invalidCredentials:
        return l10n.errorInvalidCredentials;
      case FailureType.emailInUse:
        return l10n.errorEmailInUse;
      case FailureType.weakPassword:
        return l10n.errorWeakPassword;
      case FailureType.invalidEmail:
        return l10n.errorInvalidEmail;
      case FailureType.tooManyRequests:
        return l10n.errorTooManyRequests;
      case FailureType.invalidCard:
        return l10n.errorInvalidCard;
      case FailureType.unknown:
        return l10n.errorUnknown;
    }
  }
}
