import 'package:asystent_diagnozy/models/patient.dart';
import 'package:path/path.dart';
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
    databaseFactoryOrNull = null;
    sqfliteFfiInit();
    databaseFactory = databaseFactoryFfi;
    return await databaseFactory.openDatabase(
      // inMemoryDatabasePath,
      join(await getDatabasesPath(), 'database.db'),
      options: OpenDatabaseOptions(
        onCreate: _onCreate,
        version: 1,
      ),
    );
  }

  Future<void> _onCreate(Database database, int version) async {
    final db = database;
    await db.execute(""" CREATE TABLE IF NOT EXISTS pacjenci(
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            name TEXT,
            surname TEXT,
            gender TEXT,
            birthdate TEXT,
            datecreated TEXT
          )""");
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

  // Future<List<Patient>> batchInsert() async {
  //   final db = await database;
  //   final batch = db.batch();
  //   final List<Patient> userList = List.generate(
  //     10,
  //     (index) => Patient(name: 'Pacjent', surname: '$index', gender: 'M', birthDate: '01/01/2000'),
  //   );
  //   for (final Patient user in userList) {
  //     batch.insert(
  //       'pacjenci',
  //       user.toMap(),
  //       conflictAlgorithm: ConflictAlgorithm.replace,
  //     );
  //   }
  //   await batch.commit();
  //   return userList;
  // }

  Future<List<Patient>> getPatients(String order, String searchValue) async {
    final db = await database;
    var query = "SELECT * FROM pacjenci";
    if (searchValue.isNotEmpty) {
      query =
          "$query WHERE name LIKE '%$searchValue%' OR surname LIKE '%$searchValue%'";
    }
    query = "$query ORDER BY $order";
    final List<Map<String, dynamic>> maps = await db.rawQuery(query);
    //final List<Map<String, dynamic>> maps = await db.query('pacjenci', orderBy: order, where: 'name LIKE ?', whereArgs: [searchValue]);

    return List.generate(maps.length, (index) {
      return Patient(
          id: maps[index]['id'],
          name: maps[index]['name'],
          surname: maps[index]['surname'],
          gender: maps[index]['gender'],
          birthDate: maps[index]['birthdate']);
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
        birthDate: maps[0]['birthdate'],
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
