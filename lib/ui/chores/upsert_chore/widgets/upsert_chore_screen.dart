import 'package:flutter/material.dart';
import 'package:logger/logger.dart';

import 'package:chore_app/ui/chores/upsert_chore/widgets/upsert_chore_form.dart';
import 'package:chore_app/domain/models/chore_model.dart';

var logger = Logger();

class UpsertChoreScreen extends StatefulWidget {
  final Chore? initial;
  const UpsertChoreScreen({Key? key, this.initial}) 
    :super(key: key);

  @override
  _UpsertChoreScreenState createState() => _UpsertChoreScreenState();

}

class _UpsertChoreScreenState extends State<UpsertChoreScreen> {
  late Chore _chore;

  @override
  void initState() {
    super.initState();
    _chore = widget.initial ??
      Chore(
        id: null,
        name: '',
        description: '',
        dateCreated: DateTime.now(),
        completed: false,
      );
    } 

  @override
  Widget build(BuildContext context) {
    final isEditing = widget.initial != null;
    return Scaffold(
      appBar: AppBar(title: Text(isEditing ? 'Edit Chore' : 'Add Chore')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: UpsertChoreForm(
          initial: _chore,
          submitButtonText: isEditing ? 'Update Chore' : 'Save Chore',
          onSubmit: (updatedChore) async {
            logger.t('Submitting chore and popping screen.');
            logger.t('Chore submitted: ${updatedChore.name}');
            Navigator.pop(context, updatedChore);
          },
        ),
      ),
    );
  }
}
