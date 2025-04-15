import 'package:chore_app/domain/repositories/chore_repository.dart';
import 'package:chore_app/domain/models/chore_model.dart';
import 'package:flutter/material.dart';

class ViewAllChoresTable extends StatelessWidget {
  ViewAllChoresTable({super.key});

  final ChoreRepository _choreRepository = ChoreRepository();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Chore>>(
      future: _choreRepository.getAll(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }
        if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        }

        if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return const Center(child: Text('No data available'));
        }

        final List<DataRow> rows =
            snapshot.data!.map((chore) {
              return DataRow(
                cells: [
                  DataCell(Text(chore.name)),
                  DataCell(Text(chore.description)),
                  DataCell(
  Text(chore.dateCreated.toLocal().toString().split(' ')[0]),
),
                  DataCell(Text(chore.completed ? 'Completed' : 'Pending')),
                ],
              );
            }).toList();

        return DataTable(
          columns: const <DataColumn>[
            DataColumn(
              label: Expanded(
                child: Text(
                  'Name',
                  style: TextStyle(fontStyle: FontStyle.italic),
                ),
              ),
            ),
            DataColumn(
              label: Expanded(
                child: Text(
                  'Description',
                  style: TextStyle(fontStyle: FontStyle.italic),
                ),
              ),
            ),
            DataColumn(
              label: Expanded(
                child: Text(
                  'DateCreated',
                  style: TextStyle(fontStyle: FontStyle.italic),
                ),
              ),
            ),
            DataColumn(
              label: Expanded(
                child: Text(
                  'Completed',
                  style: TextStyle(fontStyle: FontStyle.italic),
                ),
              ),
            ),
          ],
          rows: rows,
        );
      },
    );
  }
}
