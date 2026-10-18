import 'package:flutter/material.dart';
import 'package:streetbite/core/utils/context_extensions.dart';
import 'package:streetbite/domain/entities/order_pricing.dart';

/// Order / Delivery fee / Fees & taxes / Total rows (Figma Order screen).
/// Also used by the checkout screen in Part B.
class OrderSummary extends StatelessWidget {
  const OrderSummary({super.key, required this.pricing});

  final OrderPricing pricing;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

    return Column(
      children: [
        _SummaryRow(
          label: l10n.summaryOrder,
          value: context.formatPrice(pricing.itemsTotal),
        ),
        _SummaryRow(
          label: l10n.summaryDeliveryFee,
          value: context.formatPrice(pricing.deliveryFee),
        ),
        _SummaryRow(
          label: l10n.summaryTaxes,
          value: context.formatPrice(pricing.taxes),
        ),
        const SizedBox(height: 4),
        _SummaryRow(
          label: l10n.summaryTotal,
          value: context.formatPrice(pricing.total),
          isTotal: true,
        ),
      ],
    );
  }
}

class _SummaryRow extends StatelessWidget {
  const _SummaryRow({
    required this.label,
    required this.value,
    this.isTotal = false,
  });

  final String label;
  final String value;
  final bool isTotal;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final style = isTotal
        ? textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.w700)
        : textTheme.bodyLarge;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          Expanded(child: Text(label, style: style)),
          Text(value, style: style),
        ],
      ),
    );
  }
}
