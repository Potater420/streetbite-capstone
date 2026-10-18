import 'package:equatable/equatable.dart';
import 'package:streetbite/domain/entities/meal.dart';

class CartItem extends Equatable {
  const CartItem({required this.meal, this.quantity = 1});

  final Meal meal;
  final int quantity;

  double get total => meal.price * quantity;

  CartItem copyWith({int? quantity}) =>
      CartItem(meal: meal, quantity: quantity ?? this.quantity);

  @override
  List<Object?> get props => [meal, quantity];
}
