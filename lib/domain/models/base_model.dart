abstract class BaseModel {
  
  final int? id;
  final String name;

  BaseModel({
    this.id,
    required this.name
  });

  /// Convert the model into a Map for database operations.
  Map<String, dynamic> toMap();

  /// Create an instance of the model from a Map.
  /// Each implementing class should provide its own implementation.
  // It's not enforced at the language level, but you can document it.
  // factory DbModel.fromMap(Map<String, dynamic> map);
}
