import 'package:flutter/material.dart';
import 'package:streetbite/core/errors/failure.dart';
import 'package:streetbite/core/errors/failure_message.dart';
import 'package:streetbite/core/utils/context_extensions.dart';

/// One place for SnackBars, so screens don't repeat the same code.
extension SnackBarContext on BuildContext {
  void showMessage(
    String message, {
    Duration duration = const Duration(seconds: 4),
  }) {
    ScaffoldMessenger.of(this)
      ..hideCurrentSnackBar()
      ..showSnackBar(SnackBar(content: Text(message), duration: duration));
  }

  /// Shows a failure as a friendly, localized message.
  void showFailure(Failure failure) => showMessage(failure.localized(l10n));
}
