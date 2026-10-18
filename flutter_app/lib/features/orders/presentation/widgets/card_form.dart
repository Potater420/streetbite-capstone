import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:streetbite/core/utils/context_extensions.dart';
import 'package:streetbite/core/utils/validators.dart';
import 'package:streetbite/features/orders/presentation/widgets/form_text_field.dart';

/// Card number, name, expiry and CVV fields (Figma "Add card" screen).
/// The parent owns the controllers and the Form key.
class CardForm extends StatelessWidget {
  const CardForm({
    super.key,
    required this.numberController,
    required this.nameController,
    required this.expiryController,
    required this.cvvController,
  });

  final TextEditingController numberController;
  final TextEditingController nameController;
  final TextEditingController expiryController;
  final TextEditingController cvvController;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

    return Column(
      children: [
        FormTextField(
          controller: numberController,
          hint: l10n.cardNumberHint,
          keyboardType: TextInputType.number,
          inputFormatters: [
            FilteringTextInputFormatter.digitsOnly,
            LengthLimitingTextInputFormatter(16),
          ],
          validator: (v) => Validators.cardNumber(v, l10n),
        ),
        const SizedBox(height: 12),
        FormTextField(
          controller: nameController,
          hint: l10n.cardNameHint,
          keyboardType: TextInputType.name,
          validator: (v) => Validators.cardName(v, l10n),
        ),
        const SizedBox(height: 12),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: FormTextField(
                controller: expiryController,
                hint: l10n.cardExpiryHint,
                keyboardType: TextInputType.number,
                inputFormatters: [_ExpiryFormatter()],
                validator: (v) => Validators.cardExpiry(v, l10n),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: FormTextField(
                controller: cvvController,
                hint: l10n.cardCvvHint,
                keyboardType: TextInputType.number,
                obscureText: true,
                textInputAction: TextInputAction.done,
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly,
                  LengthLimitingTextInputFormatter(4),
                ],
                validator: (v) => Validators.cardCvv(v, l10n),
              ),
            ),
          ],
        ),
      ],
    );
  }
}

/// Turns "1228" into "12/28" while the user types.
class _ExpiryFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    final digits = newValue.text.replaceAll(RegExp(r'\D'), '');
    final limited = digits.length > 4 ? digits.substring(0, 4) : digits;
    final text = limited.length > 2
        ? '${limited.substring(0, 2)}/${limited.substring(2)}'
        : limited;
    return TextEditingValue(
      text: text,
      selection: TextSelection.collapsed(offset: text.length),
    );
  }
}
