import 'package:flutter/material.dart';

class DeleteChorePopup extends StatelessWidget {
  final String choreName;
  final VoidCallback onDelete;

  const DeleteChorePopup({
    Key? key,
    required this.choreName,
    required this.onDelete,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Delete Chore'),
      content: Text(
        'Are you sure you want to delete this chore: "$choreName"?',
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('Cancel'),
        ),
        TextButton(
          onPressed: () {
            onDelete();
            Navigator.of(context).pop();
          },
          child: const Text('Delete'),
        ),
      ],
    );
  }
}
