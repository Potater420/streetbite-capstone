import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:streetbite/domain/entities/delivery_mode.dart';
import 'package:streetbite/domain/entities/food_order.dart';
import 'package:streetbite/domain/entities/order_item.dart';
import 'package:streetbite/domain/entities/order_pricing.dart';

class OrderModel extends FoodOrder {
  const OrderModel({
    required super.id,
    required super.items,
    required super.pricing,
    required super.deliveryMode,
    required super.paymentMethod,
    super.paymentDetail,
    required super.createdAt,
  });

  factory OrderModel.fromEntity(FoodOrder order) => OrderModel(
        id: order.id,
        items: order.items,
        pricing: order.pricing,
        deliveryMode: order.deliveryMode,
        paymentMethod: order.paymentMethod,
        paymentDetail: order.paymentDetail,
        createdAt: order.createdAt,
      );

  /// The Firestore document id is the order id, so it is passed separately.
  factory OrderModel.fromJson(String id, Map<String, dynamic> json) =>
      OrderModel(
        id: id,
        items: (json['items'] as List<dynamic>)
            .map((e) => _itemFromJson(Map<String, dynamic>.from(e as Map)))
            .toList(),
        pricing: OrderPricing(
          itemsTotal: (json['itemsTotal'] as num).toDouble(),
          deliveryFee: (json['deliveryFee'] as num).toDouble(),
          taxes: (json['taxes'] as num).toDouble(),
        ),
        deliveryMode: DeliveryMode.values.byName(json['deliveryMode'] as String),
        paymentMethod: json['paymentMethod'] as String,
        paymentDetail: json['paymentDetail'] as String?,
        createdAt: (json['createdAt'] as Timestamp).toDate(),
      );

  Map<String, dynamic> toJson() => {
        'items': items.map(_itemToJson).toList(),
        'itemsTotal': pricing.itemsTotal,
        'deliveryFee': pricing.deliveryFee,
        'taxes': pricing.taxes,
        'total': pricing.total,
        'deliveryMode': deliveryMode.name,
        'paymentMethod': paymentMethod,
        'paymentDetail': paymentDetail,
        'createdAt': Timestamp.fromDate(createdAt),
      };
}

Map<String, dynamic> _itemToJson(OrderItem item) => {
      'mealId': item.mealId,
      'name': item.name,
      'thumbnail': item.thumbnail,
      'price': item.price,
      'quantity': item.quantity,
    };

OrderItem _itemFromJson(Map<String, dynamic> json) => OrderItem(
      mealId: json['mealId'] as String,
      name: json['name'] as String,
      thumbnail: json['thumbnail'] as String,
      price: (json['price'] as num).toDouble(),
      quantity: (json['quantity'] as num).toInt(),
    );