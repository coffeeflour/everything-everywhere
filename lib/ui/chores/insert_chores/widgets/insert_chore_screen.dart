import 'package:flutter/material.dart';

import 'package:chore_app/ui/chores/insert_chores/widgets/insert_chore_form.dart';
import 'package:chore_app/domain/repositories/chore_repository.dart';
import 'package:chore_app/domain/models/chore_model.dart';

class InsertChoreScreen extends StatefulWidget {
  final Chore chore;
  const InsertChoreScreen({Key? key, required this.chore}) 
    :super(key: key);

  @override
  _InsertChoreScreenState createState() => _InsertChoreScreenState();

}

class _InsertChoreScreenState extends State<InsertChoreScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Add Chore')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: InsertChoreForm(
          initial: widget.chore,
          onSubmit: (newChore) async {
            await ChoreRepository().insert(newChore);
            Navigator.pop(context, true);
          },
        ),
      ),
    );
  }
}
