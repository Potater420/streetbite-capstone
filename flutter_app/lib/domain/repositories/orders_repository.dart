import 'package:streetbite/domain/entities/food_order.dart';

abstract class OrdersRepository {
  Future<void> placeOrder(String uid, FoodOrder order);
}