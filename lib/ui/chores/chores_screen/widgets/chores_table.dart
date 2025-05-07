import 'package:flutter/material.dart';

import 'package:chore_app/domain/models/chore_model.dart';
import 'package:chore_app/domain/models/status_model.dart';

class ChoresTable extends StatelessWidget {
  final List<Chore> chores;
  final List<Status> statuses;
  final Future<void> Function(int) onDelete;
  final Future<void> Function(Chore) onEdit;
  final void Function(Chore chore, bool isChecked) onToggleCompleted;


  const ChoresTable({
    Key? key,
    required this.chores,
    required this.statuses,
    required this.onDelete,
    required this.onEdit,
    required this.onToggleCompleted
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DataTable(
      columns: const <DataColumn>[
        DataColumn(label: Text('Completed')),
        DataColumn(label: Text('Name')),
        DataColumn(label: Text('Description')),
        DataColumn(label: Text('Due Date')),
        DataColumn(label: Text('Status')),
        DataColumn(label: Text('Actions')),
      ],
      rows:
          chores.map((chore) {
            return DataRow(
              cells: [ 
                DataCell(Checkbox(
                  shape: CircleBorder(),
                  value: chore.completed,
                  onChanged: (bool? newValue){
                    if (newValue != null) {
                      onToggleCompleted(chore, newValue);
                    }
                  },
                ),
              ),
              DataCell(
                SizedBox(
                  width: 250,
                  child: Text(
                    chore.name,
                    softWrap: true,
                  ),
                ),
              ),
              DataCell(
                SizedBox(
                width: 250,
                child: Text(
                  chore.description,
                  softWrap: true,
                  ),
                ),
              ),
              DataCell(
                SizedBox(
                  width: 100,
                  child: Text(
                    // format the DateTime to 'YYYY‑MM‑DD'
                    chore.dueDate.toLocal().toString().split(' ')[0],
                    softWrap: true,
                  ),
                ),
              ),
              DataCell(
                SizedBox(
                  width: 150,
                  child: Text(
                    chore.status,
                    softWrap: true,
                  ),)
              ),
              DataCell(
                Center(
                  child: Row(
                    children: [
                      IconButton(
                        icon: const Icon(Icons.edit),
                        onPressed: () => onEdit(chore),
                      ),
                      IconButton(
                      icon: const Icon(Icons.delete),
                      onPressed: () => onDelete(chore.id!),
                      ),
                    ],
                  ),
                ),
              ),
            ]);
          }).toList(),
        );
      }
}
