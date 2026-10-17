/// What a successful payment returns. It never contains card numbers.
class PaymentReceipt {
  const PaymentReceipt({required this.methodId, this.detail});

  final String methodId;
  final String? detail;
}
