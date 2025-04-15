import 'package:chore_app/ui/chores/view_all_chores/widgets/view_all_chores_table.dart';
import 'package:flutter/material.dart';

class ViewAllChoresScreen extends StatefulWidget {
  const ViewAllChoresScreen({super.key, required this.title});

  final String title;

  @override
  State<ViewAllChoresScreen> createState() => _ViewAllChoresScreenState();
}

class _ViewAllChoresScreenState extends State<ViewAllChoresScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: ViewAllChoresTable(),
    );
  }
}
