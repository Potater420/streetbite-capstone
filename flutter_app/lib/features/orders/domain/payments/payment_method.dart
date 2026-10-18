import 'package:streetbite/features/orders/domain/payments/payment_receipt.dart';

/// SOLID (Interface Segregation + Dependency Inversion): checkout depends on
/// this small abstraction, never on a concrete payment class.
abstract class PaymentMethod {
  /// Saved with the order, e.g. 'cash' or 'card'.
  String get id;

  /// Completes the payment or throws a `Failure`.
  Future<PaymentReceipt> pay(double amount);
}
