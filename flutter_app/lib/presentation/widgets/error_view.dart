import 'package:flutter/material.dart';
import 'package:streetbite/core/constants/app_colors.dart';
import 'package:streetbite/core/utils/context_extensions.dart';

class ErrorView extends StatelessWidget {
  const ErrorView({super.key, required this.message, required this.onRetry});

  final String message;
  final VoidCallback onRetry;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.cloud_off, size: 56, color: AppColors.grayDark),
            const SizedBox(height: 16),
            Text(message, textAlign: TextAlign.center),
            const SizedBox(height: 16),
            SizedBox(
              width: 200,
              child: ElevatedButton(
                onPressed: onRetry,
                child: Text(context.l10n.retryButton),
              ),
            ),
          ],
        ),
      ),
    );
  }
}