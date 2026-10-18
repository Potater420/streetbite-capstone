import 'package:flutter_test/flutter_test.dart';
import 'package:streetbite/core/errors/failure.dart';
import 'package:streetbite/domain/payments/card_details.dart';
import 'package:streetbite/domain/payments/card_payment.dart';
import 'package:streetbite/domain/payments/cash_payment.dart';
import 'package:streetbite/domain/payments/payment_method.dart';

void main() {
  const validCard = CardDetails(
    number: '4242424242424242',
    name: 'Test User',
    expiry: '12/99',
    cvv: '123',
  );

  test('CashPayment returns a cash receipt', () async {
    final receipt = await const CashPayment().pay(10);

    expect(receipt.methodId, 'cash');
    expect(receipt.detail, isNull);
  });

  test('CardPayment keeps only the last 4 digits', () async {
    final receipt = await const CardPayment(validCard).pay(10);

    expect(receipt.methodId, 'card');
    expect(receipt.detail, '4242');
  });

  test('CardPayment rejects invalid details with a Failure', () async {
    const invalid = CardDetails(number: '123', name: '', expiry: '1', cvv: '1');

    await expectLater(
      const CardPayment(invalid).pay(10),
      throwsA(
        isA<Failure>().having((f) => f.type, 'type', FailureType.invalidCard),
      ),
    );
  });

  test('both methods can be used wherever a PaymentMethod is expected', () {
    final methods = <PaymentMethod>[const CashPayment(), const CardPayment(validCard)];

    expect(methods.map((m) => m.id), ['cash', 'card']);
  });
}