import 'package:flutter_test/flutter_test.dart';
import 'package:streetbite/domain/entities/cart_item.dart';
import 'package:streetbite/domain/entities/delivery_mode.dart';
import 'package:streetbite/domain/entities/meal.dart';
import 'package:streetbite/domain/entities/order_pricing.dart';

void main() {
  // Meal id '1' has a demo price of 7.99.
  const meal = Meal(
    id: '1',
    name: 'Test meal',
    category: 'Category',
    area: 'Area',
    instructions: '',
    thumbnail: '',
  );

  test('a small delivery order pays the delivery fee and 7% taxes', () {
    final pricing = OrderPricing.fromItems(
      [const CartItem(meal: meal)],
      DeliveryMode.delivery,
    );

    expect(pricing.itemsTotal, closeTo(7.99, 0.001));
    expect(pricing.deliveryFee, closeTo(3.99, 0.001));
    expect(pricing.taxes, closeTo(7.99 * 0.07, 0.001));
    expect(pricing.total, closeTo(7.99 + 3.99 + 7.99 * 0.07, 0.001));
  });

  test('delivery is free from 30 upwards', () {
    final pricing = OrderPricing.fromItems(
      [const CartItem(meal: meal, quantity: 4)], // 31.96
      DeliveryMode.delivery,
    );

    expect(pricing.deliveryFee, 0);
  });

  test('pickup never pays a delivery fee', () {
    final pricing = OrderPricing.fromItems(
      [const CartItem(meal: meal)],
      DeliveryMode.pickup,
    );

    expect(pricing.deliveryFee, 0);
  });

  test('an empty cart costs nothing', () {
    final pricing = OrderPricing.fromItems([], DeliveryMode.delivery);

    expect(pricing.total, 0);
  });
}