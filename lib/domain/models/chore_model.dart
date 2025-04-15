import 'package:chore_app/domain/models/base_model.dart';

class Chore extends BaseModel {
  final String name;
  final String description;
  final DateTime dateCreated;
  final bool completed;

  Chore({
    super.id,
    required this.name,
    required this.description,
    required this.dateCreated,
    required this.completed,
  });

  @override
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'dateCreated': dateCreated.toIso8601String(),

      'completed': completed ? 1 : 0,
    };
  }

  factory Chore.fromMap(Map<String, dynamic> map) {
    return Chore(
      id: map['id'],
      name: map['name'],
      description: map['description'],
      dateCreated: DateTime.parse(map['dateCreated']),
      completed: map['completed'] == 1,
    );
  }
}
