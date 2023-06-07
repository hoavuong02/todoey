import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseProvider extends ChangeNotifier {
  static const String tableName = 'tasks';
  Database? _database;
  String title = ''; //biến lưu giá trị khi nhập tên task mới
  Future<void> open() async {
    final dbPath = await getDatabasesPath();
    _database = await openDatabase(
      join(dbPath, 'todoey_v2.db'),
      onCreate: (db, version) {
        return db.execute('''
          CREATE TABLE IF NOT EXISTS $tableName (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            name TEXT,
            isDone INTEGER DEFAULT 0
          )
        ''');
      },
      version: 1,
    );
  }

  Future<void> dropTable() async {
    // Drop the table with the specified name from the database
    await _database?.execute('DROP TABLE IF EXISTS $tableName');
  }

  Future<List<Map<String, dynamic>>> getTasks() async {
    if (_database == null) {
      await open();
    }
    return await _database!.query(tableName);
  }

  Future<void> insertTask() async {
    if (_database == null) {
      await open();
    }
    if (title != null) {
      await _database!.rawInsert(
        'INSERT INTO $tableName (name) VALUES (?)',
        [title],
      );
      notifyListeners();
    }
  }

  //method that update isDone column
  Future<void> handleChechBox(int id) async {
    if (_database == null) {
      await open();
    }
    await _database!.execute('''
    UPDATE $tableName
    SET isDone = CASE isDone
                     WHEN 0 THEN 1
                     WHEN 1 THEN 0
                   END
    WHERE id = ?
  ''', [id]);
    notifyListeners();
  }

  Future<void> handleLongpress(int id) async {
    if (_database == null) {
      await open();
    }
    await _database!.delete(
      '$tableName',
      where: 'id = ?',
      whereArgs: [id],
    );
    notifyListeners();
  }

  void getValueInput(String value) {
    title = value;
    notifyListeners();
  }
}
