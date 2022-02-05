import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  static Future<Database> get database async {
    final databasePath = await getDatabasesPath();

    return await openDatabase(
      join(databasePath, 'places.db'),
      onCreate: (database, version) {
        database.execute('''
        CREATE TABLE places(
          id TEXT PRIMARY KEY,
          title TEXT,
          image TEXT,
          location_latitude REAL,
          location_longitude REAL,
          address TEXT
        );
        ''');
      },
      version: 1,
    );
  }

  static Future<void> insert(String table, Map<String, dynamic> data) async {
    final database = await DatabaseHelper.database;

    await database.insert(
      table,
      data,
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  static Future<List<Map<String, dynamic>>> getData(String table) async {
    final database = await DatabaseHelper.database;

    return database.query(table);
  }
}
