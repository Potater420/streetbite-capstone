import 'package:streetbite/domain/entities/food_order.dart';
import 'package:streetbite/domain/repositories/orders_repository.dart';

class WatchOrdersUseCase {
  WatchOrdersUseCase(this._repository);
  final OrdersRepository _repository;

  Stream<List<FoodOrder>> call(String uid) => _repository.watchOrders(uid);
}
