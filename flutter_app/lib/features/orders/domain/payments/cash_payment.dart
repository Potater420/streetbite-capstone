import 'package:streetbite/features/orders/domain/payments/payment_method.dart';
import 'package:streetbite/features/orders/domain/payments/payment_receipt.dart';

/// Pay on delivery: nothing to charge now.
class CashPayment implements PaymentMethod {
  const CashPayment();

  @override
  String get id => 'cash';

  @override
  Future<PaymentReceipt> pay(double amount) async {
    return PaymentReceipt(methodId: id);
  }
}
