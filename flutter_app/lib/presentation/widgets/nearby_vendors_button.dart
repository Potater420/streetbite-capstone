import 'package:flutter/material.dart';
import 'package:streetbite/core/utils/context_extensions.dart';

/// Soft-green row on Home that opens the vendor map.
class NearbyVendorsButton extends StatelessWidget {
  const NearbyVendorsButton({super.key, required this.onTap});

  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final primary = Theme.of(context).colorScheme.primary;

    return Material(
      color: primary.withValues(alpha: 0.12),
      borderRadius: BorderRadius.circular(12),
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
          child: Row(
            children: [
              Icon(Icons.map_outlined, color: primary),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  context.l10n.nearbyVendorsTitle,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: primary,
                  ),
                ),
              ),
              Icon(Icons.chevron_right, color: primary),
            ],
          ),
        ),
      ),
    );
  }
}