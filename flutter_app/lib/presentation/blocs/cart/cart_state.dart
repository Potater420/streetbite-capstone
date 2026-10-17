import 'package:equatable/equatable.dart';
import 'package:streetbite/domain/entities/cart_item.dart';
import 'package:streetbite/domain/entities/delivery_mode.dart';
import 'package:streetbite/domain/entities/order_pricing.dart';

class CartState extends Equatable {
  const CartState({
    this.items = const [],
    this.deliveryMode = DeliveryMode.delivery,
  });

  final List<CartItem> items;
  final DeliveryMode deliveryMode;

  int get totalCount => items.fold<int>(0, (sum, item) => sum + item.quantity);
  OrderPricing get pricing => OrderPricing.fromItems(items, deliveryMode);

  @override
  List<Object?> get props => [items, deliveryMode];
}
