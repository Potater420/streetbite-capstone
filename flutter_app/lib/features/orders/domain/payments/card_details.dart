class CardDetails {
  const CardDetails({
    required this.number,
    required this.name,
    required this.expiry,
    required this.cvv,
  });

  final String number;
  final String name;
  final String expiry; // MM/YY
  final String cvv;

  String get last4 =>
      number.length >= 4 ? number.substring(number.length - 4) : number;

  bool get isValid =>
      RegExp(r'^\d{16}$').hasMatch(number) &&
      name.trim().isNotEmpty &&
      RegExp(r'^(0[1-9]|1[0-2])/\d{2}$').hasMatch(expiry) &&
      RegExp(r'^\d{3,4}$').hasMatch(cvv);
}
