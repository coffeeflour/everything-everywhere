import 'package:flutter/material.dart';
import 'package:logger/logger.dart';

import 'package:chore_app/domain/models/chore_model.dart';

var logger = Logger();

class UpsertChoreForm extends StatefulWidget {
  final Chore initial;
  final Future<void> Function(Chore) onSubmit;
  final String submitButtonText;


  const UpsertChoreForm({
    Key? key,
    required this.initial,
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

  late DateTime _date;
  late bool _completed;

  @override
  void initState() {
    super.initState();
    _nameCtrl = TextEditingController(text: widget.initial.name);
    _descCtrl = TextEditingController(text: widget.initial.description);
    _date = widget.initial.dateCreated;
    _completed = widget.initial.completed;
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

  final updated = Chore(
    id: widget.initial.id,
    name: _nameCtrl.text.trim(),
    description: _descCtrl.text.trim(),
    dateCreated: _date,
    completed: _completed,
  );

  await widget.onSubmit(updated); 
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