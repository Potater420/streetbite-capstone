import 'package:streetbite/core/errors/error_handler.dart';
import 'package:streetbite/data/datasources/firestore_service.dart';
import 'package:streetbite/data/models/order_model.dart';
import 'package:streetbite/domain/entities/food_order.dart';
import 'package:streetbite/domain/repositories/orders_repository.dart';

class OrdersRepositoryImpl implements OrdersRepository {
  OrdersRepositoryImpl(this._service);

  final FirestoreService _service;

  @override
  Future<void> placeOrder(String uid, FoodOrder order) async {
    try {
      await _service.placeOrder(uid, OrderModel.fromEntity(order));
    } catch (e) {
      throw ErrorHandler.handle(e);
    }
  }
}