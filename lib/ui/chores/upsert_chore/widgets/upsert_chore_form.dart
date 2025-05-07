import 'package:flutter/material.dart';
import 'package:logger/logger.dart';

import 'package:chore_app/domain/models/chore_model.dart';
import 'package:chore_app/domain/models/status_model.dart';

var logger = Logger();

class UpsertChoreForm extends StatefulWidget {
  final Chore initialChore;
  final List<Status> statuses;
  final Future<void> Function(Chore) onSubmit;
  final String submitButtonText;


  const UpsertChoreForm({
    Key? key,
    required this.initialChore,
    required this.statuses,
    required this.onSubmit,
    this.submitButtonText = 'Save',
    })
    :super(key: key);

  @override
  _UpsertChoreFormState createState() => _UpsertChoreFormState();
}

class _UpsertChoreFormState extends State<UpsertChoreForm> {
  
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _nameCtrl;
  late TextEditingController _descCtrl;
  late String _status;
  late DateTime _dueDate;
  late DateTime _dateCreated;
  late bool _completed;

  late List<Status> _statuses;



  @override
  void initState() {
    super.initState();
    _nameCtrl = TextEditingController(text: widget.initialChore.name);
    _descCtrl = TextEditingController(text: widget.initialChore.description);
    _status = widget.initialChore.status;
    _dueDate = widget.initialChore.dueDate;
    _dateCreated = widget.initialChore.dateCreated;
    _completed = widget.initialChore.completed;
    _statuses = widget.statuses;
  }

  @override
  void dispose() {
    _nameCtrl.dispose();
    _descCtrl.dispose();
    super.dispose();
  }

Future<void> _submit() async {
  logger.t('Submit Button Pressed...');
  if (!_formKey.currentState!.validate()) return;

  final updatedChore = Chore(
    id: widget.initialChore.id,
    name: _nameCtrl.text.trim(),
    description: _descCtrl.text.trim(),
    //status: _status,
    //dueDate: _dueDate,
    dateCreated: _dateCreated,
    completed: _completed,
  );

  await widget.onSubmit(updatedChore); 
}


  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _nameCtrl,
                decoration: const InputDecoration(labelText: 'Chore Name'),
                validator: (value) => value!.isEmpty ? 'Name Required' : null,
              ),
              TextFormField(
                controller: _descCtrl,
                decoration: const InputDecoration(labelText: 'Description'),
              ),
              DropdownButtonFormField<Status>(items: _status, onChanged: _status.map)
              ElevatedButton(
                onPressed: _submit,
                child: Text(widget.submitButtonText),
                ),
            ],
          ),
        )
      ],
    );
  }
}