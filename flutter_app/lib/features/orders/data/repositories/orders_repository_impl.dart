import 'dart:async';

import 'package:streetbite/core/errors/error_handler.dart';
import 'package:streetbite/core/services/firestore_service.dart';
import 'package:streetbite/features/orders/data/models/order_model.dart';
import 'package:streetbite/features/orders/domain/entities/food_order.dart';
import 'package:streetbite/features/orders/domain/repositories/orders_repository.dart';

class OrdersRepositoryImpl implements OrdersRepository {
  OrdersRepositoryImpl(this._service);

  final FirestoreService _service;

  /// Orders live in the user's `orders` sub-collection.
  static const _collection = 'orders';

  @override
  Future<void> placeOrder(String uid, FoodOrder order) async {
    try {
      await _service.setUserDocument(
        uid,
        _collection,
        order.id,
        OrderModel.fromEntity(order).toJson(),
        failWhenOffline: true,
      );
    } catch (e) {
      throw ErrorHandler.handle(e);
    }
  }

  @override
  Stream<List<FoodOrder>> watchOrders(String uid) {
    return _service
        .watchUserCollection(
          uid,
          _collection,
          orderBy: 'createdAt',
          descending: true,
        )
        .transform(
          StreamTransformer<
            List<FirestoreDocument>,
            List<FoodOrder>
          >.fromHandlers(
            handleData: (documents, sink) {
              try {
                sink.add(
                  documents
                      .map((doc) => OrderModel.fromJson(doc.id, doc.data))
                      .toList(),
                );
              } catch (e) {
                sink.addError(ErrorHandler.handle(e));
              }
            },
            handleError: (error, stackTrace, sink) =>
                sink.addError(ErrorHandler.handle(error), stackTrace),
          ),
        );
  }
}
