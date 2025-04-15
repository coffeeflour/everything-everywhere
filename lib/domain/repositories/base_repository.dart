import 'package:chore_app/db/database_helper.dart';
import 'package:chore_app/domain/models/base_model.dart';
import 'package:sqflite/sql.dart';
import 'package:sqflite/sqlite_api.dart';

class BaseRepository<T extends BaseModel> {
  final String tableName;
  final T Function(Map<String, dynamic> map) fromMap;

  BaseRepository({required this.tableName, required this.fromMap});

  Future<int> insert(T model) async {
    final db = await DatabaseHelper.instance.database;
    return await db.insert(
      tableName,
      model.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<List<T>> getAll() async {
    final db = await DatabaseHelper.instance.database;
    final List<Map<String, dynamic>> maps = await db.query(tableName);
    return maps.map((map) => fromMap(map)).toList();
  }

  Future<int> update(T model) async {
    final db = await DatabaseHelper.instance.database;
    return await db.update(
      tableName,
      model.toMap(),
      where: 'id = ?',
      whereArgs: [model.id],
    );
  }

  Future<int> delete(int id) async {
    final db = await DatabaseHelper.instance.database;
    return await db.delete(
      tableName,
      where: 'id = ?',
      whereArgs: [id]
      );
  }
}
