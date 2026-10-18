import 'package:equatable/equatable.dart';
import 'package:streetbite/domain/entities/cart_item.dart';

/// A line of a placed order. It keeps only what the history needs, so old
/// orders don't depend on the live menu.
class OrderItem extends Equatable {
  const OrderItem({
    required this.mealId,
    required this.name,
    required this.thumbnail,
    required this.price,
    required this.quantity,
  });

  factory OrderItem.fromCartItem(CartItem item) => OrderItem(
    mealId: item.meal.id,
    name: item.meal.name,
    thumbnail: item.meal.thumbnail,
    price: item.meal.price,
    quantity: item.quantity,
  );

  final String mealId;
  final String name;
  final String thumbnail;
  final double price;
  final int quantity;

  double get total => price * quantity;

  @override
  List<Object?> get props => [mealId, name, thumbnail, price, quantity];
}
