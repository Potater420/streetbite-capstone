import 'package:streetbite/domain/entities/cart_item.dart';
import 'package:streetbite/domain/entities/delivery_mode.dart';
import 'package:streetbite/domain/entities/food_order.dart';
import 'package:streetbite/domain/entities/order_item.dart';
import 'package:streetbite/domain/entities/order_pricing.dart';
import 'package:streetbite/domain/payments/payment_method.dart';
import 'package:streetbite/domain/repositories/orders_repository.dart';

/// Charges the chosen payment method, then saves the order.
/// It only knows the [PaymentMethod] interface (Dependency Inversion).
class PlaceOrderUseCase {
  PlaceOrderUseCase(this._repository);

  final OrdersRepository _repository;

  Future<FoodOrder> call({
    required String uid,
    required List<CartItem> items,
    required DeliveryMode deliveryMode,
    required PaymentMethod payment,
  }) async {
    final pricing = OrderPricing.fromItems(items, deliveryMode);
    final receipt = await payment.pay(pricing.total);

    final now = DateTime.now();
    final order = FoodOrder(
      id: now.microsecondsSinceEpoch.toString(),
      items: items.map(OrderItem.fromCartItem).toList(),
      pricing: pricing,
      deliveryMode: deliveryMode,
      paymentMethod: receipt.methodId,
      paymentDetail: receipt.detail,
      createdAt: now,
    );
    await _repository.placeOrder(uid, order);
    return order;
  }
}
