import 'package:streetbite/core/errors/failure.dart';
import 'package:streetbite/features/orders/domain/entities/food_order.dart';

// No Equatable on purpose: repeated failures must emit again.
sealed class CheckoutState {
  const CheckoutState();
}

class CheckoutInitial extends CheckoutState {
  const CheckoutInitial();
}

class CheckoutProcessing extends CheckoutState {
  const CheckoutProcessing();
}

class CheckoutSuccess extends CheckoutState {
  const CheckoutSuccess(this.order);
  final FoodOrder order;
}

class CheckoutFailure extends CheckoutState {
  CheckoutFailure(this.failure);
  final Failure failure;
}
