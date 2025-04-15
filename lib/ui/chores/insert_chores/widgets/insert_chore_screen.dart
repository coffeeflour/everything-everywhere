import 'package:chore_app/domain/repositories/chore_repository.dart';
import 'package:flutter/material.dart';
import 'package:chore_app/domain/models/chore_model.dart';

class InsertChoreScreen extends StatefulWidget {
  const InsertChoreScreen({super.key, required this.title});

  final String title;

  @override
  State<InsertChoreScreen> createState() => _InsertChoreScreenState();
}

class _InsertChoreScreenState extends State<InsertChoreScreen> {
  final _formKey = GlobalKey<FormState>();

  // Controllers for the form fields.
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();

  DateTime _selectedDate = DateTime.now();
  bool _completed = false;

  final ChoreRepository _choreRepository = ChoreRepository();

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );
    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
      });
    }
  }

  Future<void> _submitForm() async {
    if (_formKey.currentState!.validate()) {
      // Create a new Chore object based on user input.
      final newChore = Chore(
        name: _nameController.text,
        description: _descriptionController.text,
        dateCreated: _selectedDate,
        completed: _completed,
      );

      await _choreRepository.insert(newChore);

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Chore inserted successfully')),
      );

      // Optionally, navigate back or clear the form.
      Navigator.of(context).pop();
    }
  }

  @override
  void dispose() {
    // Dispose controllers when not needed.
    _nameController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              //Name Field
              TextFormField(
                controller: _nameController,
                decoration: const InputDecoration(labelText: 'Chore Name'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the chore name';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16.0),
              //DescriptionField
              TextFormField(
                controller: _descriptionController,
                decoration: const InputDecoration(labelText: 'Description'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a description';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16.0),
              //DateField
              Row(
                children: [
                  Expanded(
                    child: Text(
                      'Date Created: ${_selectedDate.toLocal().toString().split(' ')[0]}',
                    ),
                  ),
                  TextButton(
                    onPressed: () => _selectDate(context),
                    child: const Text('Select Date'),
                  ),
                ],
              ),
              const SizedBox(height: 16.0),
              //CompletedCheckBox
              Row(
                children: [
                  const Text('Completed:'),
                  Checkbox(
                    value: _completed,
                    onChanged: (value) {
                      setState(() {
                        _completed = value ?? false;
                      });
                    },
                  ),
                ],
              ),
              const SizedBox(height: 32.0),
              //SubmitButton
              ElevatedButton(
                onPressed: _submitForm,
                child: const Text('Insert Chore'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
