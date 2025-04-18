import 'package:chore_app/ui/chores/view_all_chores/widgets/view_all_chores_table.dart';
import 'package:chore_app/domain/repositories/chore_repository.dart';
import 'package:chore_app/domain/models/chore_model.dart';
import 'package:flutter/material.dart';

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
    _chores = await _choreRepository.getAll();
    setState(() {});
  }

  Future<void> _deleteChore(int id) async {
    await _choreRepository.delete(id);
    await _loadChores();

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: ViewAllChoresTable(
        chores: _chores,
        onDelete: _deleteChore,
      ),
    );
  }
}
