import 'package:equatable/equatable.dart';
import 'package:streetbite/core/constants/app_constants.dart';
import 'package:streetbite/features/cart/domain/entities/cart_item.dart';
import 'package:streetbite/features/cart/domain/entities/delivery_mode.dart';

/// All the money math for an order in one place, shared by the cart,
/// the checkout and the saved order.
class OrderPricing extends Equatable {
  const OrderPricing({
    required this.itemsTotal,
    required this.deliveryFee,
    required this.taxes,
  });

  factory OrderPricing.fromItems(List<CartItem> items, DeliveryMode mode) {
    final itemsTotal = items.fold<double>(0, (sum, item) => sum + item.total);
    final isFree =
        mode == DeliveryMode.pickup ||
        itemsTotal == 0 ||
        itemsTotal >= AppConstants.freeDeliveryThreshold;
    return OrderPricing(
      itemsTotal: itemsTotal,
      deliveryFee: isFree ? 0 : AppConstants.deliveryFee,
      taxes: itemsTotal * AppConstants.taxRate,
    );
  }

  final double itemsTotal;
  final double deliveryFee;
  final double taxes;

  double get total => itemsTotal + deliveryFee + taxes;

  @override
  List<Object?> get props => [itemsTotal, deliveryFee, taxes];
}
