import 'package:flutter_test/flutter_test.dart';
import 'package:streetbite/features/cart/domain/entities/delivery_mode.dart';
import 'package:streetbite/features/home/domain/entities/meal.dart';
import 'package:streetbite/features/cart/presentation/blocs/cart_bloc.dart';
import 'package:streetbite/features/cart/presentation/blocs/cart_event.dart';
import 'package:streetbite/features/cart/presentation/blocs/cart_state.dart';

void main() {
  const mealA = Meal(
    id: '1',
    name: 'A',
    category: 'c',
    area: 'a',
    instructions: '',
    thumbnail: '',
  );

  late CartBloc bloc;

  setUp(() => bloc = CartBloc());
  tearDown(() => bloc.close());

  Matcher cartWith({required int count, int? lines}) {
    return isA<CartState>()
        .having((s) => s.totalCount, 'totalCount', count)
        .having((s) => s.items.length, 'lines', lines ?? (count == 0 ? 0 : 1));
  }

  test('adds a new meal', () async {
    final expectation = expectLater(bloc.stream, emits(cartWith(count: 1)));
    bloc.add(const CartItemAdded(mealA));
    await expectation;
  });

  test('adding the same meal again increases its quantity', () async {
    final expectation = expectLater(
      bloc.stream,
      emitsInOrder([cartWith(count: 1), cartWith(count: 2)]),
    );
    bloc
      ..add(const CartItemAdded(mealA))
      ..add(const CartItemAdded(mealA));
    await expectation;
  });

  test('decrementing the last unit removes the item', () async {
    final expectation = expectLater(
      bloc.stream,
      emitsInOrder([cartWith(count: 1), cartWith(count: 0)]),
    );
    bloc
      ..add(const CartItemAdded(mealA))
      ..add(const CartItemDecremented('1'));
    await expectation;
  });

  test('removing deletes the item whatever its quantity', () async {
    final expectation = expectLater(
      bloc.stream,
      emitsInOrder([cartWith(count: 1), cartWith(count: 2), cartWith(count: 0)]),
    );
    bloc
      ..add(const CartItemAdded(mealA))
      ..add(const CartItemAdded(mealA))
      ..add(const CartItemRemoved('1'));
    await expectation;
  });

  test('clearing empties the cart but keeps the delivery mode', () async {
    final expectation = expectLater(
      bloc.stream,
      emitsInOrder([
        isA<CartState>()
            .having((s) => s.deliveryMode, 'mode', DeliveryMode.pickup),
        cartWith(count: 1),
        isA<CartState>()
            .having((s) => s.items, 'items', isEmpty)
            .having((s) => s.deliveryMode, 'mode', DeliveryMode.pickup),
      ]),
    );
    bloc
      ..add(const CartDeliveryModeChanged(DeliveryMode.pickup))
      ..add(const CartItemAdded(mealA))
      ..add(const CartCleared());
    await expectation;
  });
}