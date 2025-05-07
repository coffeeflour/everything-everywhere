import 'package:chore_app/domain/models/base_model.dart';

class Status extends BaseModel {

  Status({
    super.id,
    required super.name,
  });

  @override
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
    };
  }

  factory Status.fromMap(Map<String, dynamic> map) {
    return Status(
      id: map['id'],
      name: map['name'],
    );
  }
}
