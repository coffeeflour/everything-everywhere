import 'package:flutter/material.dart';

Future<bool> confirmDialog({
  required BuildContext context,
  String title = 'Are you sure?',
  String message = 'This action cannot be undone.',
  String confirmText = 'Confirm',
  String cancelText = 'Cancel',
}) async {
  final result = await showDialog<bool>(
    context: context,
    builder: (context) => AlertDialog(
      title: Text(title),
      content: Text(message),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(false),
          child: Text(cancelText),
          ),
          ElevatedButton(
            onPressed: () => Navigator.of(context).pop(true), 
            child: Text(confirmText),
            ),
      ],
    ),
    );
    return result ?? false;
}