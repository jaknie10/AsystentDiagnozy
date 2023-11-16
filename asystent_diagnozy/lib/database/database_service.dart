import 'dart:math';

import 'package:asystent_diagnozy/models/pacjent.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

class SQLiteHelper {
  Database? _database;

  Future<Database> get database async {
    if (_database != null) {
      return _database!;
    }
    _database = await initWinDB();
    return _database!;
  }

  Future<Database> initWinDB() async {
    sqfliteFfiInit();
    final databaseFactory = databaseFactoryFfi;
    return await databaseFactory.openDatabase(
      inMemoryDatabasePath,
      options: OpenDatabaseOptions(
        onCreate: _onCreate,
        version: 1,
      ),
    );
  }

  Future<void> _onCreate(Database database, int version) async {
    final db = database;
    await db.execute(""" CREATE TABLE IF NOT EXISTS pacjenci(
            id INTEGER PRIMARY KEY,
            name TEXT,
            surname TEXT,
            sex TEXT
          )
 """);
  }

  Future<Pacjent> insertUSer(Pacjent user) async {
    final db = await database;
    db.insert(
      "pacjenci",
      user.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
    return user;
  }

  Future<List<Pacjent>> batchInsert() async {
    final db = await database;
    final batch = db.batch();
    final Random random = Random();
    final List<Pacjent> userList = List.generate(
      10,
      (index) => Pacjent(
        id: index + 1,
        name: 'Pacjent',
        surname: '$index',
        sex: 'M',
      ),
    );
    for (final Pacjent user in userList) {
      batch.insert(
        'pacjenci',
        user.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
    }
    await batch.commit();
    return userList;
  }

  Future<List<Pacjent>> getAllUsers() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query('pacjenci');

    return List.generate(maps.length, (index) {
      return Pacjent(
        id: maps[index]['id'],
        name: maps[index]['name'],
        surname: maps[index]['surname'],
        sex: maps[index]['sex'],
      );
    });
  }

  Future<Pacjent?> getUserById(int userId) async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query(
      'pacjenci',
      where: 'id = ?',
      whereArgs: [userId],
    );

    if (maps.isNotEmpty) {
      return Pacjent(
        id: maps[0]['id'],
        name: maps[0]['name'],
        surname: maps[0]['surname'],
        sex: maps[0]['sex'],
      );
    }

    return null;
  }

  Future<void> deleteAllUsers() async {
    final db = await database;
    final Batch batch = db.batch();

    batch.delete('pacjenci');

    await batch.commit();
  }
}
