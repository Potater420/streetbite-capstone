import 'package:equatable/equatable.dart';
import 'package:streetbite/domain/entities/cart_item.dart';

class CartState extends Equatable {
  const CartState({this.items = const []});

  final List<CartItem> items;

  int get totalCount => items.fold<int>(0, (sum, item) => sum + item.quantity);
  double get totalPrice => items.fold<double>(0, (sum, item) => sum + item.total);

  @override
  List<Object?> get props => [items];
}