import 'package:flutter/material.dart';

import 'package:chore_app/ui/chores/edit_chore/widgets/edit_chore_form.dart';
import 'package:chore_app/domain/models/chore_model.dart';
import 'package:chore_app/domain/repositories/chore_repository.dart';

class EditChoreScreen extends StatefulWidget {
  final Chore chore;
  const EditChoreScreen({Key? key, required this.chore}) : super(key: key);

  @override
  _EditChoreScreenState createState() => _EditChoreScreenState();
}

class _EditChoreScreenState extends State<EditChoreScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Edit Chore')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: EditChoreForm(
          initial: widget.chore,
          onSubmit: (updated) async {
            await ChoreRepository().update(updated);
            Navigator.pop(context, true);
          },
        ),
      ),
    );
  }
}