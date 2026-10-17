import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:streetbite/domain/entities/cart_item.dart';
import 'package:streetbite/presentation/blocs/cart/cart_event.dart';
import 'package:streetbite/presentation/blocs/cart/cart_state.dart';
import 'package:streetbite/domain/entities/delivery_mode.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  CartBloc() : super(const CartState()) {
    on<CartItemAdded>(_onAdded);
    on<CartItemDecremented>(_onDecremented);
    on<CartItemRemoved>(_onRemoved);
    on<CartDeliveryModeChanged>(
      (event, emit) => emit(_withItems(state.items, mode: event.mode)),
    );
    on<CartCleared>((event, emit) => emit(_withItems(const [])));
  }

  CartState _withItems(List<CartItem> items, {DeliveryMode? mode}) =>
      CartState(items: items, deliveryMode: mode ?? state.deliveryMode);

  void _onAdded(CartItemAdded event, Emitter<CartState> emit) {
    final items = [...state.items];
    final index = items.indexWhere((i) => i.meal.id == event.meal.id);
    if (index == -1) {
      items.add(CartItem(meal: event.meal));
    } else {
      items[index] = items[index].copyWith(quantity: items[index].quantity + 1);
    }
    emit(_withItems(items));
  }

  void _onDecremented(CartItemDecremented event, Emitter<CartState> emit) {
    final items = [...state.items];
    final index = items.indexWhere((i) => i.meal.id == event.mealId);
    if (index == -1) return;
    if (items[index].quantity <= 1) {
      items.removeAt(index);
    } else {
      items[index] = items[index].copyWith(quantity: items[index].quantity - 1);
    }
    emit(_withItems(items));
  }

  void _onRemoved(CartItemRemoved event, Emitter<CartState> emit) {
    emit(
      _withItems(state.items.where((i) => i.meal.id != event.mealId).toList()),
    );
  }
}
