import 'package:streetbite/core/errors/failure.dart';
import 'package:streetbite/domain/payments/card_details.dart';
import 'package:streetbite/domain/payments/payment_method.dart';
import 'package:streetbite/domain/payments/payment_receipt.dart';

/// Card payment. This is a simulated gateway (no real charge is made).
/// Only the last 4 digits are kept; the full number and CVV are discarded.
class CardPayment implements PaymentMethod {
  const CardPayment(this._details);

  final CardDetails _details;

  @override
  String get id => 'card';

  @override
  Future<PaymentReceipt> pay(double amount) async {
    if (!_details.isValid) throw const Failure(FailureType.invalidCard);
    await Future<void>.delayed(const Duration(seconds: 1)); // fake gateway
    return PaymentReceipt(methodId: id, detail: _details.last4);
  }
}