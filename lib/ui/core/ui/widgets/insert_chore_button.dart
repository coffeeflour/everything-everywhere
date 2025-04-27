import 'package:chore_app/ui/chores/insert_chores/widgets/insert_chore_screen.dart';
import 'package:flutter/material.dart';

import 'package:chore_app/domain/models/chore_model.dart';

class InsertChoreButton extends StatelessWidget{
  final Chore newChore;
  final Future<void> Function(Chore) onCreate;

  const InsertChoreButton({
    Key? key,
    required this.onCreate,
    required this.newChore,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        Navigator.push(
          context, 
          MaterialPageRoute(
            builder: (context) => InsertChoreScreen(chore: newChore),
            ),
            );
      },
      child:  const Text('Insert Chores'),
    );
  }
}
