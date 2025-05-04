import 'package:flutter/material.dart';
import 'package:logger/logger.dart';

var logger = Logger();

class UpsertChoreButton extends StatelessWidget{
    final Future<void> Function() onCreate;
  const UpsertChoreButton({required this.onCreate});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () => onCreate(),
      child: const Text('Add Chore'),
    );
  }
}
