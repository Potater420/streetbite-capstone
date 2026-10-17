import 'package:flutter/material.dart';
import 'package:streetbite/core/constants/app_colors.dart';
import 'package:streetbite/core/utils/context_extensions.dart';

/// Trash / count / plus stepper from the Figma Order screen (80 x 36).
/// The left button is a trash can at quantity 1 and a minus above that.
class QuantityStepper extends StatelessWidget {
  const QuantityStepper({
    super.key,
    required this.quantity,
    required this.onDecrease,
    required this.onIncrease,
  });

  final int quantity;
  final VoidCallback onDecrease;
  final VoidCallback onIncrease;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final scheme = Theme.of(context).colorScheme;
    final isLast = quantity == 1;

    return Container(
      width: 88,
      height: 36,
      decoration: BoxDecoration(
        color: scheme.surface,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: scheme.outlineVariant, width: 2),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _StepButton(
            icon: isLast ? Icons.delete_outline : Icons.remove,
            tooltip: isLast ? l10n.removeFromCart : l10n.decreaseQuantity,
            onPressed: onDecrease,
          ),
          Text(
            '$quantity',
            style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
          ),
          _StepButton(
            icon: Icons.add,
            tooltip: l10n.increaseQuantity,
            onPressed: onIncrease,
          ),
        ],
      ),
    );
  }
}

class _StepButton extends StatelessWidget {
  const _StepButton({
    required this.icon,
    required this.tooltip,
    required this.onPressed,
  });

  final IconData icon;
  final String tooltip;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Tooltip(
      message: tooltip,
      child: InkResponse(
        onTap: onPressed,
        radius: 18,
        child: SizedBox(
          width: 28,
          height: 28,
          child: Icon(icon, size: 20, color: AppColors.grayDark),
        ),
      ),
    );
  }
}