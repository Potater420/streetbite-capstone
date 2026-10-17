import 'package:equatable/equatable.dart';
import 'package:streetbite/domain/entities/delivery_mode.dart';
import 'package:streetbite/domain/entities/order_item.dart';
import 'package:streetbite/domain/entities/order_pricing.dart';

class FoodOrder extends Equatable {
  const FoodOrder({
    required this.id,
    required this.items,
    required this.pricing,
    required this.deliveryMode,
    required this.paymentMethod,
    this.paymentDetail,
    required this.createdAt,
  });

  final String id;
  final List<OrderItem> items;
  final OrderPricing pricing;
  final DeliveryMode deliveryMode;
  final String paymentMethod; // 'cash' or 'card'
  final String? paymentDetail; // last 4 digits for cards
  final DateTime createdAt;

  @override
  List<Object?> get props => [
        id,
        items,
        pricing,
        deliveryMode,
        paymentMethod,
        paymentDetail,
        createdAt,
      ];
}