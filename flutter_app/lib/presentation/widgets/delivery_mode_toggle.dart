import 'package:flutter/material.dart';
import 'package:streetbite/core/utils/context_extensions.dart';
import 'package:streetbite/domain/entities/delivery_mode.dart';

/// Green Delivery / Pickup pill from the Figma Order screen.
class DeliveryModeToggle extends StatelessWidget {
  const DeliveryModeToggle({
    super.key,
    required this.selected,
    required this.onChanged,
  });

  final DeliveryMode selected;
  final ValueChanged<DeliveryMode> onChanged;

  @override
  Widget build(BuildContext context) {
    final primary = Theme.of(context).colorScheme.primary;

    return Container(
      height: 40,
      decoration: BoxDecoration(
        color: primary.withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(52),
      ),
      child: Row(
        children: [
          _Segment(
            label: context.l10n.deliveryLabel,
            isSelected: selected == DeliveryMode.delivery,
            onTap: () => onChanged(DeliveryMode.delivery),
          ),
          _Segment(
            label: context.l10n.pickupLabel,
            isSelected: selected == DeliveryMode.pickup,
            onTap: () => onChanged(DeliveryMode.pickup),
          ),
        ],
      ),
    );
  }
}

class _Segment extends StatelessWidget {
  const _Segment({
    required this.label,
    required this.isSelected,
    required this.onTap,
  });

  final String label;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final primary = Theme.of(context).colorScheme.primary;

    return Expanded(
      child: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: isSelected ? primary : Colors.transparent,
            borderRadius: BorderRadius.circular(35),
          ),
          child: Text(
            label,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: isSelected ? Colors.white : primary,
            ),
          ),
        ),
      ),
    );
  }
}