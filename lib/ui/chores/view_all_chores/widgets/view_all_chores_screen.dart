import 'package:flutter/material.dart';
import 'package:logger/logger.dart';

import 'package:chore_app/domain/repositories/chore_repository.dart';
import 'package:chore_app/ui/chores/edit_chore/widgets/edit_chore_screen.dart';
import 'package:chore_app/ui/chores/insert_chores/widgets/insert_chore_screen.dart';
import 'package:chore_app/ui/chores/view_all_chores/widgets/view_all_chores_table.dart';
import 'package:chore_app/domain/repositories/chore_repository.dart';
import 'package:chore_app/domain/models/chore_model.dart';
import 'package:chore_app/ui/core/ui/widgets/insert_chore_button.dart';

var logger = Logger();

class ViewAllChoresScreen extends StatefulWidget {
  const ViewAllChoresScreen({super.key, required this.title});

  final String title;

  @override
  State<ViewAllChoresScreen> createState() => _ViewAllChoresScreenState();
}

class _ViewAllChoresScreenState extends State<ViewAllChoresScreen> {
  final ChoreRepository _choreRepository = ChoreRepository();
  List<Chore> _chores = [];

  @override
  void initState() {
    super.initState();
    _loadChores();
  }

  Future<void> _loadChores() async {

    logger.t('Loading Chores...');
    _chores = await _choreRepository.getAll();
    logger.t('Chores Loaded.');

    setState(() {});
  }

  Future<void> _createChore() async {

    final newChore = await Navigator.push<Chore>(
      context,
      MaterialPageRoute(builder: (_) => const InsertChoreScreen()),
    );

    if (newChore != null) {
      logger.t('Chore returned: ${newChore.name}');
      await _choreRepository.insert(newChore); // insert logic is here
      await _loadChores(); // refresh table
    }
  }


  Future<void> _deleteChore(int id) async {
    await _choreRepository.delete(id);
    await _loadChores();
  }

  Future<void> _editChore(int id) async {
    final chore = _chores.firstWhere((c) => c.id == id);

    final didEdit = await Navigator.of(context).push<bool>(
      MaterialPageRoute(
        builder: (_) => EditChoreScreen(chore: chore),
         ),
    );

    if(didEdit == true) {
      await _loadChores();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Column(
        children: [
          Expanded(child: ViewAllChoresTable(
            chores: _chores,
            onDelete: _deleteChore, 
            onEdit: _editChore, 
            ),
          ),
          Padding(padding: const EdgeInsets.all(16.0),
          child: InsertChoreButton(
            onCreate: _createChore
          ),
        ),
      ],
    ),
  );
}
}
