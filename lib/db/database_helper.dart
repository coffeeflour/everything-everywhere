import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper {
  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();
  static Database? _database;

  DatabaseHelper._privateConstructor();

  Future<Database> get database async {
    if (_database != null) {
      return _database!;
    }

    _database = await initDatabase();
    return _database!;
  }

  Future<Database> initDatabase() async {
    String path = join(await getDatabasesPath(), 'app_database.db');

    return await openDatabase(
      path,
      version: 1,
      onCreate: (Database db, int version) async {
        await db.execute('''
        CREATE TABLE chores(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        name TEXT NOT NULL,
        dateCreated TEXT NOT NULL,
        description TEXT,
        completed INTEGER NOT NULL,
        dueDate TEXT,
        status TEXT
        );

        INSERT INTO chores(name, dateCreated, description, completed)
        VALUES
        ('Walk dog', '2025-04-27T14:30:00.000', 'take the dog a short walk', 0),
        ('Wash dishes', '2025-04-27T14:30:00.000', 'wash the dishes in the sink', 0),
        ('Develop app', '2025-04-27T14:30:00.000', 'seed chores to database', 0);

        CREATE TABLE statuses(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        name TEXT NOT NULL
        );

        INSERT INTO statuses(name)
        VALUES
        ('In Progress'),
        ('Completed'),
        ('Not Started');
      ''');
      },
    );
  }

  Future<void> insert(String table, Map<String, dynamic> values) async {
    final Database db = await database;

    await db.insert(
      table,
      values,
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<List<Map<String, dynamic>>> query(String table) async {
    final db = await database;
    return await db.query(table);
  }

  // Generic Update
  Future<int> update(
    String table,
    Map<String, dynamic> values, {
    required String where,
    required List<dynamic> whereArgs,
  }) async {
    final db = await database;
    return await db.update(table, values, where: where, whereArgs: whereArgs);
  }

  // Generic Delete
  Future<int> delete(
    String table, {
    required String where,
    required List<dynamic> whereArgs,
  }) async {
    final db = await database;
    return await db.delete(table, where: where, whereArgs: whereArgs);
  }
}
