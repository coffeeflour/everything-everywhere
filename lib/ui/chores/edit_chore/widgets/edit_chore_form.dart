import 'package:flutter/material.dart';

import 'package:chore_app/domain/models/chore_model.dart';

class EditChoreForm extends StatefulWidget {
  final Chore initial;
  final Future<void> Function(Chore) onSubmit;

  const EditChoreForm({Key? key, required this.initial, required this.onSubmit})
    : super(key: key);

  @override
  _EditChoreFormState createState() => _EditChoreFormState();
}

class _EditChoreFormState extends State<EditChoreForm> {
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

  Future<void> _pickDate() async {
    final picked = await showDatePicker(
      context: context,
      initialDate: _date,
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );
    if (picked != null) {
      setState(() => _date = picked);
    }
  }

  void _submit() {
    if (!_formKey.currentState!.validate()) return;
    final updated = Chore(
      id: widget.initial.id,
      name: _nameCtrl.text,
      description: _descCtrl.text,
      dateCreated: _date,
      completed: _completed,
    );
    widget.onSubmit(updated);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text('Edit Chore', style: Theme.of(context).textTheme.titleLarge),
        Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _nameCtrl,
                decoration: const InputDecoration(labelText: 'Chore Name'),
                validator: (v) => v!.isEmpty ? 'Required' : null,
              ),
              TextFormField(
                controller: _descCtrl,
                decoration: const InputDecoration(labelText: 'Description'),
                validator: (v) => v!.isEmpty ? 'Required' : null,
              ),
              // … date picker & checkbox …
              ElevatedButton(
                onPressed: _submit,
                child: const Text('Save Changes'),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
