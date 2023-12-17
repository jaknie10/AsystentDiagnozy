import 'dart:convert';

import 'package:asystent_diagnozy/models/patient_model.dart';
import 'package:asystent_diagnozy/models/test_result_model.dart';
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
      join(await getDatabasesPath(), 'database.db'),
      options: OpenDatabaseOptions(
        onCreate: _onCreate,
        version: 1,
      ),
    );
  }

  Future<void> _onCreate(Database database, int version) async {
    final db = database;

    await db.execute(sqlInitValues);
  }

  Future<Patient> insertPatient(Patient patient) async {
    final db = await database;
    db.insert(
      "patients",
      patient.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
    return patient;
  }

  Future<int> deletePatient(int patientId) async {
    final db = await database;
    return db.delete(
      'patients',
      where: 'id = ?',
      whereArgs: [patientId],
    );
  }

  Future<List<Patient>> getPatients(String order, String searchValue) async {
    final db = await database;
    var query = "SELECT * FROM patients";
    if (searchValue.isNotEmpty) {
      query =
          "$query WHERE (name || ' ' || surname LIKE '%$searchValue%') OR (surname || ' ' || name LIKE '%$searchValue%')";
    }
    query = "$query ORDER BY $order";
    final List<Map<String, dynamic>> maps = await db.rawQuery(query);

    return List.generate(maps.length, (index) {
      return Patient(
          id: maps[index]['id'],
          name: maps[index]['name'],
          surname: maps[index]['surname'],
          gender: maps[index]['gender'],
          birthdate: DateTime.parse(maps[index]['birthdate']),
          createdAt: DateTime.parse(maps[index]['createdAt']));
    });
  }

  Future<Patient?> getPatientById(int patientId) async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query(
      'patients',
      where: 'id = ?',
      whereArgs: [patientId],
    );

    if (maps.isNotEmpty) {
      return Patient(
        id: maps[0]['id'],
        name: maps[0]['name'],
        surname: maps[0]['surname'],
        gender: maps[0]['gender'],
        birthdate: DateTime.parse(maps[0]['birthdate']),
        createdAt: DateTime.parse(maps[0]['createdAt']),
      );
    }

    return null;
  }

  Future<List<TestResult>> getAllTests() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query(
      'testResults',
    );

    return List.generate(maps.length, (index) {
      return TestResult(
          id: maps[index]['id'],
          patientId: maps[index]['patientId'],
          testType: maps[index]['testType'],
          createdAt: DateTime.parse(maps[index]['createdAt']),
          results: json.decode(maps[index]['results']));
    });
  }

  Future<TestResult> insertTestResult(TestResult testResult) async {
    final db = await database;
    db.insert(
      "testResults",
      testResult.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
    return testResult;
  }

  Future<List<TestResult>> getTestsByPatientId(int patientId) async {
    final db = await database;

    final List<Map<String, dynamic>> maps = await db.query(
      'testResults',
      where: 'patientId = ?',
      whereArgs: [patientId],
    );

    return List.generate(maps.length, (index) {
      return TestResult(
          id: maps[index]['id'],
          patientId: maps[index]['patientId'],
          testType: maps[index]['testType'],
          createdAt: DateTime.parse(maps[index]['createdAt']),
          results: json.decode(maps[index]['results']));
    });
  }
}

String sqlInitValues = """
  CREATE TABLE IF NOT EXISTS users(
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    username TEXT,
    password TEXT,
    createdAt TEXT
  );

  CREATE TABLE IF NOT EXISTS patients(
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    name TEXT,
    surname TEXT,
    gender TEXT,
    birthdate TEXT,
    createdAt TEXT
  );

  CREATE TABLE IF NOT EXISTS testResults(
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    patientId INTEGER REFERENCES patients(id),
    testType TEXT,
    createdAt TEXT,
    results TEXT
  );
""";
