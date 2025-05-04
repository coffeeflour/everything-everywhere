import 'package:flutter/material.dart';
import 'package:logger/logger.dart';

import 'package:chore_app/domain/repositories/chore_repository.dart';
import 'package:chore_app/ui/chores/upsert_chore/widgets/upsert_chore_screen.dart';
import 'package:chore_app/ui/chores/chores_screen/widgets/chores_table.dart';
import 'package:chore_app/domain/models/chore_model.dart';
import 'package:chore_app/ui/core/ui/widgets/upsert_chore_button.dart';
import 'package:chore_app/ui/core/ui/widgets/alert_popup.dart';

var logger = Logger();

class ChoreScreen extends StatefulWidget {
  const ChoreScreen({super.key, required this.title});

  final String title;

  @override
  State<ChoreScreen> createState() => _ChoreScreenState();
}

class _ChoreScreenState extends State<ChoreScreen> {
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
      MaterialPageRoute(builder: (_) => const UpsertChoreScreen()),
    );

    if (newChore != null) {
      logger.t('Chore returned: ${newChore.name}');
      await _choreRepository.insert(newChore); // insert logic is here
      await _loadChores(); // refresh table
    }
  }


  Future<void> _deleteChore(int id) async {
    final confirmed = await confirmDialog(
      context: context,
      title: 'Delete Chore',
      message: 'Are you sure you want to delete this chore?',
      confirmText: 'Delete',
      cancelText: 'Cancel',
      );

      if(!confirmed) return;

      await _choreRepository.delete(id);
      await _loadChores();

      logger.t('Deleted chore $id');
  }

  Future<void> _editChore(Chore chore) async {
    final updatedChore = await Navigator.push<Chore>(
      context,
      MaterialPageRoute(
        builder: (_) => UpsertChoreScreen(initial: chore),
        ),
    );
    if(updatedChore != null) {
      await _choreRepository.update(updatedChore);
      await _loadChores();
      logger.t('Chore $updatedChore.id_ updated');
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
          Expanded(child: ChoresTable(
            chores: _chores,
            onDelete: _deleteChore, 
            onEdit: _editChore, 
            ),
          ),
          Padding(padding: const EdgeInsets.all(16.0),
          child: UpsertChoreButton(
            onCreate: _createChore
          ),
        ),
      ],
    ),
  );
}
}
