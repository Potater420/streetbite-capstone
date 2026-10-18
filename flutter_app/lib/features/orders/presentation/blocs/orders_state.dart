import 'package:streetbite/core/errors/failure.dart';
import 'package:streetbite/features/orders/domain/entities/food_order.dart';

// No Equatable on purpose: repeated errors must still emit.
class OrdersState {
  const OrdersState({
    this.orders = const [],
    this.isLoaded = false,
    this.failure,
  });

  final List<FoodOrder> orders;
  final bool isLoaded; // false until the first Firestore snapshot arrives
  final Failure? failure;
}
