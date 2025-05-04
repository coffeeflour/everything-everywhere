import 'package:flutter/material.dart';
import 'package:logger/logger.dart';

import 'package:chore_app/ui/chores/insert_chores/widgets/insert_chore_form.dart';
import 'package:chore_app/domain/models/chore_model.dart';

var logger = Logger();

class InsertChoreScreen extends StatefulWidget {
  const InsertChoreScreen({Key? key}) 
    :super(key: key);

  @override
  _InsertChoreScreenState createState() => _InsertChoreScreenState();

}

class _InsertChoreScreenState extends State<InsertChoreScreen> {
  late Chore _newChore;

  @override
  void initState() {
    super.initState();
    _newChore = Chore(
      id: null,
      name: '',
      description: '',
      dateCreated: DateTime.now(),
      completed: false,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Add Chore')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: InsertChoreForm(
          initial: _newChore,
          onSubmit: (newChore) async {
            logger.t('Submitting chore and popping screen.');
            logger.t('Chore submitted: ${newChore.name}');
            Navigator.pop(context, newChore);
          },
        ),
      ),
    );
  }
}
