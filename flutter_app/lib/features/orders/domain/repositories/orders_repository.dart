import 'package:streetbite/features/orders/domain/entities/food_order.dart';

abstract class OrdersRepository {
  Future<void> placeOrder(String uid, FoodOrder order);

  /// Live list of the user's orders, newest first.
  Stream<List<FoodOrder>> watchOrders(String uid);
}
