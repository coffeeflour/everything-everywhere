import 'package:chore_app/domain/models/base_model.dart';

class Chore extends BaseModel {
  final String description;
  final DateTime dateCreated;
  final bool completed;
  final String status;
  final DateTime dueDate;

  Chore({
    super.id,
    required super.name,
    required this.description,
    required this.dateCreated,
    required this.completed,
    required this.status,
    required this.dueDate,
  });

  @override
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'status' : status,
      'dateCreated': dateCreated.toIso8601String(),
      'dueDate' : dueDate.toIso8601String(),
      'completed': completed ? 1 : 0,
    };
  }

  factory Chore.fromMap(Map<String, dynamic> map) {
    return Chore(
      id: map['id'],
      name: map['name'],
      description: map['description'],
      status: map['status'],
      dateCreated: DateTime.parse(map['dateCreated']),
      dueDate: DateTime.parse(map['dueDate']),
      completed: map['completed'] == 1,
    );
  }
}
