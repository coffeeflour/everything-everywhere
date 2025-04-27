import 'package:flutter/material.dart';

import 'package:chore_app/domain/models/chore_model.dart';

class InsertChoreForm extends StatefulWidget {
  final Chore initial;
  final Future<void> Function(Chore) onSubmit;

  const InsertChoreForm({Key? key, required this.initial, required this.onSubmit})
    :super(key: key);

  @override
  _InsertChoreFormState createState() => _InsertChoreFormState();
}

class _InsertChoreFormState extends State<InsertChoreForm> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameCtrl = TextEditingController();
  final TextEditingController _descCtrl = TextEditingController();

  DateTime _date = DateTime.now();
  bool _completed = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _nameCtrl.dispose();
    _descCtrl.dispose();
    super.dispose();
  }

  void _submit() {
    if(!_formKey.currentState!.validate()) return;
    final newChore = Chore(
      name: _nameCtrl.text,
      description: _descCtrl.text,
      dateCreated: _date,
      completed: _completed,
    );
    widget.onSubmit(newChore);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text('Insert Chore', style: Theme.of(context).textTheme.titleLarge),
        Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _nameCtrl,
                decoration: const InputDecoration(labelText: 'Chore Name'),
                validator: (value) => value!.isEmpty ? 'Required' : null,
              ),
              ElevatedButton(
                onPressed: _submit,
                child: const Text('Add Chore'),
                ),
            ],
          ),
        )
      ],
    );
  }
}