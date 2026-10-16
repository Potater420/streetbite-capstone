import 'package:streetbite/domain/entities/meal.dart';

sealed class CartEvent {
  const CartEvent();
}

class CartItemAdded extends CartEvent {
  const CartItemAdded(this.meal);
  final Meal meal;
}
// Phase 5 adds CartItemRemoved and CartCleared.