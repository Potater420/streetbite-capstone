import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:streetbite/domain/entities/cart_item.dart';
import 'package:streetbite/presentation/blocs/cart/cart_event.dart';
import 'package:streetbite/presentation/blocs/cart/cart_state.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  CartBloc() : super(const CartState()) {
    on<CartItemAdded>(_onItemAdded);
  }

  void _onItemAdded(CartItemAdded event, Emitter<CartState> emit) {
    final items = [...state.items];
    final index = items.indexWhere((i) => i.meal.id == event.meal.id);
    if (index == -1) {
      items.add(CartItem(meal: event.meal));
    } else {
      items[index] = items[index].copyWith(quantity: items[index].quantity + 1);
    }
    emit(CartState(items: items));
  }
}