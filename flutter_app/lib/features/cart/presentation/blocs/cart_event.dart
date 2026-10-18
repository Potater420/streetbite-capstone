import 'package:streetbite/features/cart/domain/entities/delivery_mode.dart';
import 'package:streetbite/features/home/domain/entities/meal.dart';

sealed class CartEvent {
  const CartEvent();
}

class CartItemAdded extends CartEvent {
  const CartItemAdded(this.meal);
  final Meal meal;
}

/// Removes one unit; the item disappears when its quantity reaches zero.
class CartItemDecremented extends CartEvent {
  const CartItemDecremented(this.mealId);
  final String mealId;
}

/// Removes the item completely.
class CartItemRemoved extends CartEvent {
  const CartItemRemoved(this.mealId);
  final String mealId;
}

class CartDeliveryModeChanged extends CartEvent {
  const CartDeliveryModeChanged(this.mode);
  final DeliveryMode mode;
}

class CartCleared extends CartEvent {
  const CartCleared();
}
