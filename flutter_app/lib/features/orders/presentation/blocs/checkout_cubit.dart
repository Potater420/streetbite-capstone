import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:streetbite/core/errors/failure.dart';
import 'package:streetbite/features/cart/domain/entities/cart_item.dart';
import 'package:streetbite/features/cart/domain/entities/delivery_mode.dart';
import 'package:streetbite/features/orders/domain/payments/payment_method.dart';
import 'package:streetbite/features/orders/domain/usecases/place_order_usecase.dart';
import 'package:streetbite/features/orders/presentation/blocs/checkout_state.dart';

class CheckoutCubit extends Cubit<CheckoutState> {
  CheckoutCubit(this._placeOrder) : super(const CheckoutInitial());

  final PlaceOrderUseCase _placeOrder;

  Future<void> placeOrder({
    required String uid,
    required List<CartItem> items,
    required DeliveryMode deliveryMode,
    required PaymentMethod payment,
  }) async {
    emit(const CheckoutProcessing());
    try {
      final order = await _placeOrder(
        uid: uid,
        items: items,
        deliveryMode: deliveryMode,
        payment: payment,
      );
      emit(CheckoutSuccess(order));
    } on Failure catch (failure) {
      emit(CheckoutFailure(failure));
    }
  }
}
