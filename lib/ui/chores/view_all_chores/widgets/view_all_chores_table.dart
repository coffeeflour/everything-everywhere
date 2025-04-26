import 'package:chore_app/domain/models/chore_model.dart';
import 'package:chore_app/ui/chores/edit_chore/widgets/edit_chore_screen.dart';
import 'package:chore_app/ui/core/ui/widgets/delete_chore_popup.dart';
import 'package:flutter/material.dart';

class ViewAllChoresTable extends StatelessWidget {
  final List<Chore> chores;
  final Future<void> Function(int) onDelete;
  final Future<void> Function(int) onEdit;

  const ViewAllChoresTable({
    Key? key,
    required this.chores,
    required this.onDelete,
    required this.onEdit,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DataTable(
      columns: const <DataColumn>[
        DataColumn(label: Text('Name')),
        DataColumn(label: Text('Description')),
        DataColumn(label: Text('Date Created')),
        DataColumn(label: Text('Completed')),
        DataColumn(label: Text('Actions')),
      ],
      rows:
          chores.map((chore) {
            return DataRow(
              cells: [
                DataCell(Text(chore.name)),
                DataCell(Text(chore.description)),
                DataCell(
                  Text(
                    // format the DateTime to 'YYYY‑MM‑DD'
                    chore.dateCreated.toLocal().toString().split(' ')[0],
                  ),
                ),
                DataCell(Text(chore.completed ? '✅' : '❌')),
                 DataCell(Row(
            children: [
              IconButton(
                icon: const Icon(Icons.edit),
                onPressed: () => onEdit(chore.id!),
              ),
              IconButton(
                icon: const Icon(Icons.delete),
                onPressed: () => onDelete(chore.id!),
              ),
            ],
          )),
        ]);
      }).toList(),
    );
  }
}
