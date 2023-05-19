import 'package:flutter/material.dart';

/// Helper utilities
abstract class Utils {
  /// Remove the current snackbars and show a new one
  static void showMessage(BuildContext context, String message) {
    ScaffoldMessenger.of(context).removeCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        behavior: SnackBarBehavior.floating,
        width: 300,
      ),
    );
  }
}
