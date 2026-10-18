import 'package:flutter_test/flutter_test.dart';
import 'package:streetbite/core/utils/validators.dart';
import 'package:streetbite/l10n/app_localizations_en.dart';

void main() {
  final l10n = AppLocalizationsEn();

  group('fullName', () {
    test('rejects an empty name', () {
      expect(Validators.fullName('', l10n), l10n.validationNameRequired);
    });

    test('rejects a lowercase first letter', () {
      expect(Validators.fullName('peter', l10n), l10n.validationNameCapital);
    });

    test('accepts a capitalized name', () {
      expect(Validators.fullName('Peter', l10n), isNull);
    });

    test('accepts Arabic names (no letter case)', () {
      expect(Validators.fullName('بيتر', l10n), isNull);
    });
  });

  group('email', () {
    test('rejects empty and malformed emails', () {
      expect(Validators.email('', l10n), l10n.validationEmailRequired);
      expect(Validators.email('not-an-email', l10n), l10n.validationEmailInvalid);
    });

    test('accepts a valid email', () {
      expect(Validators.email('peter@gmail.com', l10n), isNull);
    });
  });

  group('password', () {
    test('requires at least six characters', () {
      expect(Validators.password('', l10n), l10n.validationPasswordRequired);
      expect(Validators.password('12345', l10n), l10n.validationPasswordShort);
      expect(Validators.password('123456', l10n), isNull);
    });

    test('confirmation must match', () {
      expect(
        Validators.confirmPassword('abcdef', '123456', l10n),
        l10n.validationPasswordMismatch,
      );
      expect(Validators.confirmPassword('123456', '123456', l10n), isNull);
    });
  });

  group('card fields', () {
    test('card number needs 16 digits', () {
      expect(Validators.cardNumber('1234', l10n), l10n.validationCardNumber);
      expect(Validators.cardNumber('4242424242424242', l10n), isNull);
    });

    test('expiry must be a valid future date', () {
      expect(Validators.cardExpiry('13/30', l10n), l10n.validationCardExpiry);
      expect(Validators.cardExpiry('01/20', l10n), l10n.validationCardExpiry);
      expect(Validators.cardExpiry('12/99', l10n), isNull);
    });

    test('cvv needs 3 or 4 digits', () {
      expect(Validators.cardCvv('12', l10n), l10n.validationCardCvv);
      expect(Validators.cardCvv('123', l10n), isNull);
    });
  });
}