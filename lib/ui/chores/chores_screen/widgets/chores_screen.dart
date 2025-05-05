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
  bool _customTileExpanded = false;

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
      await _choreRepository.insert(newChore);
      await _loadChores();
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

  Future<void> _toggleChoreCompleted(Chore chore, bool isChecked) async {
   
    Chore updatedChore = Chore(
      id: chore.id,
      name: chore.name,
      description: chore.description,
      completed: isChecked,
      dateCreated: chore.dateCreated 
    );

      await _choreRepository.update(updatedChore);
      await _loadChores();
    
    logger.t('Updated Chore ${updatedChore.id} to ${updatedChore.completed}');
}


  @override
  Widget build(BuildContext context) {

  final incompleteChores = _chores.where((chore) => !chore.completed).toList();
  final completedChores = _chores.where((chore) => chore.completed).toList();

  return Scaffold(
    appBar: AppBar(
      backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      title: Text(widget.title),
    ),
    body: Padding(padding: const EdgeInsets.all(16.0),
    child: Column(
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              margin: const EdgeInsets.all(10.0),
              width: 1000.0,
              child: ExpansionTile(
                title: Text('Chores'),
                trailing: Icon(
                  _customTileExpanded ? Icons.arrow_drop_down_circle : Icons.arrow_drop_down,
                ),
                children: [
                    SizedBox(
                      height: 300.0,
                      child: SingleChildScrollView(
                        child: ChoresTable(
                          chores: incompleteChores,
                          onDelete: _deleteChore,
                          onEdit: _editChore,
                          onToggleCompleted: _toggleChoreCompleted,
                        ),
                      ),
                    ),
                ],
              ),
            ),
               
            SizedBox(width: 16),
          
            UpsertChoreButton(
              onCreate: _createChore
            ),
          ],
        ),
        Row(
          children: [
            Container(
              margin: const EdgeInsets.all(10.0),
              width: 1000.0,
              child: ExpansionTile(
                title: Text('Completed Chores'),
                trailing: Icon(
                _customTileExpanded ? Icons.arrow_drop_down_circle : Icons.arrow_drop_down,
                ),
                children: [
                  SizedBox(
                    height: 150.0,
                    child: SingleChildScrollView(
                        child: ChoresTable(
                          chores: completedChores,
                          onDelete: _deleteChore,
                          onEdit: _editChore,
                          onToggleCompleted: _toggleChoreCompleted,
                        ),
                      ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ],
    ),
  ),
  );
}
}
