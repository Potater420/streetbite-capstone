import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:streetbite/core/errors/failure.dart';
import 'package:streetbite/domain/entities/food_order.dart';
import 'package:streetbite/domain/usecases/watch_orders_usecase.dart';
import 'package:streetbite/presentation/blocs/orders/orders_state.dart';

class OrdersCubit extends Cubit<OrdersState> {
  OrdersCubit(this._watchOrders) : super(const OrdersState());

  final WatchOrdersUseCase _watchOrders;

  StreamSubscription<List<FoodOrder>>? _subscription;
  String? _uid;

  /// Starts listening to the signed-in user's orders.
  void watch(String uid) {
    if (_uid == uid) return;
    _uid = uid;
    _subscription?.cancel();
    _subscription = _watchOrders(uid).listen(
      (orders) => emit(OrdersState(orders: orders, isLoaded: true)),
      onError: (Object error) {
        if (error is Failure) {
          emit(
            OrdersState(orders: state.orders, isLoaded: true, failure: error),
          );
        }
      },
    );
  }

  /// Stops listening and forgets the user (called on logout).
  void clear() {
    _subscription?.cancel();
    _subscription = null;
    _uid = null;
    emit(const OrdersState());
  }

  @override
  Future<void> close() {
    _subscription?.cancel();
    return super.close();
  }
}
