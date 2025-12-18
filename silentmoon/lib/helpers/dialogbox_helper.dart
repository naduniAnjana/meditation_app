import 'package:flutter/material.dart';

class DialogHelper {
  static void showErrorDialog(
    BuildContext context,
    String message, {
    String title = 'Login Failed',
  }) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text(title),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }
}