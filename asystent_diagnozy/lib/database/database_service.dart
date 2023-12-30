import 'dart:convert';
import 'package:asystent_diagnozy/models/patient_model.dart';
import 'package:asystent_diagnozy/models/test_result_model.dart';
import 'package:asystent_diagnozy/models/user_model.dart';
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
    db.delete('testResults', where: 'patientId = ?', whereArgs: [patientId]);

    return db.delete(
      'patients',
      where: 'id = ?',
      whereArgs: [patientId],
    );
  }

  Future<int> updatePatient(int patientId, Map<String, Object?> patient) async {
    final db = await database;
    db.delete('testResults', where: 'patientId = ?', whereArgs: [patientId]);

    return db.update(
      'patients',
      patient,
      where: 'id = ?',
      whereArgs: [patientId],
    );
  }

  Future<List<Patient>> getPatients(String order, String searchValue) async {
    final db = await database;
    List<Map<String, dynamic>> maps;
    var query = "SELECT * FROM patients";
    if (searchValue.isNotEmpty) {
      query =
          "$query WHERE (name || ' ' || surname LIKE ?) OR (surname || ' ' || name LIKE ?)";
      query = "$query ORDER BY $order";
      maps = await db.rawQuery(query, ['%$searchValue%', '%$searchValue%']);
    } else {
      query = "$query ORDER BY $order";
      maps = await db.rawQuery(query);
    }

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

  Future<Patient> getPatientById(int patientId) async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query(
      'patients',
      where: 'id = ?',
      whereArgs: [patientId],
    );

    return Patient(
      id: maps[0]['id'],
      name: maps[0]['name'],
      surname: maps[0]['surname'],
      gender: maps[0]['gender'],
      birthdate: DateTime.parse(maps[0]['birthdate']),
      createdAt: DateTime.parse(maps[0]['createdAt']),
    );
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

  Future<List<TestResult>> getTests(String order) async {
    final db = await database;
    var query = "SELECT * FROM testResults";

    query = "$query ORDER BY $order";
    final List<Map<String, dynamic>> maps = await db.rawQuery(query);

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

  Future<int> deleteResultById(int testId) async {
    final db = await database;
    return db.delete(
      'testResults',
      where: 'id = ?',
      whereArgs: [testId],
    );
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

  Future<List<List<Map<String, Object?>>>> getDoctorStatistics() async {
    final db = await database;
    final List<Map<String, Object?>> liczbaBadan =
        await db.rawQuery("SELECT COUNT(id) FROM testResults LIMIT 1");
    final List<Map<String, Object?>> najczestszeBadanie = await db.rawQuery(
        "SELECT testType, COUNT(id) FROM testResults ORDER BY COUNT(id) desc");
    final List<Map<String, Object?>> liczbaPacjentow =
        await db.rawQuery("SELECT COUNT(id) FROM patients");
    return [liczbaBadan, najczestszeBadanie, liczbaPacjentow];
  }

  Future<String> checkIfUserInDatabase(String login) async {
    final db = await database;
    final odp = await db
        .rawQuery("SELECT COUNT(id) FROM users WHERE login=? LIMIT 1", [login]);
    return odp[0].values.first.toString();
  }

  Future<List<User>> getAllUsers() async {
    final db = await database;
    List<Map<String, dynamic>> maps = await db.rawQuery("SELECT * FROM users");
    return List.generate(maps.length, (index) {
      return User(
          name: maps[index]['name'],
          surname: maps[index]['surname'],
          login: maps[index]['login'],
          rsaPublicKey: maps[index]['RSApublicKey'],
          encryptedPrivateKey: maps[index]['encryptedPrivateKey'],
          saltOne: maps[index]['saltOne'],
          saltTwo: maps[index]['saltTwo']);
    });
  }

  Future<void> addUserToDatabase(
      String name,
      String surname,
      String login,
      String publicKey,
      String privateKey,
      String saltOne,
      String saltTwo) async {
    final db = await database;

    var user = {
      'name': name,
      'surname': surname,
      'login': login,
      'RSApublicKey': publicKey,
      'encryptedPrivateKey': privateKey,
      'saltOne': saltOne,
      'saltTwo': saltTwo,
    };

    db.insert(
      "users",
      user,
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<User> getUserLoginData(String login) async {
    final db = await database;
    List<Map<String, dynamic>> ans =
        await db.rawQuery("SELECT * FROM users WHERE login=? LIMIT 1", [login]);

    return User(
        name: ans[0]['name'],
        surname: ans[0]['surname'],
        login: ans[0]["login"],
        rsaPublicKey: ans[0]['RSApublicKey'],
        encryptedPrivateKey: ans[0]['encryptedPrivateKey'],
        saltOne: ans[0]['saltOne'],
        saltTwo: ans[0]['saltTwo']);
  }

  Future<void> updateUserPassword(String publicKey, String privateKey,
      String saltOne, String saltTwo, String login) async {
    final db = await database;

    await db.rawUpdate(
        "UPDATE users SET RSApublicKey=?, encryptedPrivateKey=?, saltOne=?, saltTwo=? WHERE login=?",
        [publicKey, privateKey, saltOne, saltTwo, login]);
  }
}

String sqlInitValues = """
  CREATE TABLE IF NOT EXISTS users(
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    name TEXT,
    surname TEXT,
    login TEXT,
    RSApublicKey TEXT,
    encryptedPrivateKey TEXT,
    saltOne TEXT,
    saltTwo TEXT
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
