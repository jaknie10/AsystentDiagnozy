import 'package:asystent_diagnozy/models/patient.dart';
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
            gender TEXT
          )
 """);
  }

  Future<Patient> insertUSer(Patient user) async {
    final db = await database;
    db.insert(
      "pacjenci",
      user.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
    return user;
  }

  Future<List<Patient>> batchInsert() async {
    final db = await database;
    final batch = db.batch();
    final List<Patient> userList = List.generate(
      10,
      (index) => Patient(
        id: index + 1,
        name: 'Pacjent',
        surname: '$index',
        gender: 'M',
      ),
    );
    for (final Patient user in userList) {
      batch.insert(
        'pacjenci',
        user.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
    }
    await batch.commit();
    return userList;
  }

  Future<List<Patient>> getAllUsers() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query('pacjenci');

    return List.generate(maps.length, (index) {
      return Patient(
        id: maps[index]['id'],
        name: maps[index]['name'],
        surname: maps[index]['surname'],
        gender: maps[index]['gender'],
      );
    });
  }

  Future<Patient?> getUserById(int userId) async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query(
      'pacjenci',
      where: 'id = ?',
      whereArgs: [userId],
    );

    if (maps.isNotEmpty) {
      return Patient(
        id: maps[0]['id'],
        name: maps[0]['name'],
        surname: maps[0]['surname'],
        gender: maps[0]['gender'],
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
