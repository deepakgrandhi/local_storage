import 'package:local_storage/models/employee_model.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper {
  Database? _database;

  Future<void> open() async {
    _database ??= await openDatabase(
      join(await getDatabasesPath(), 'employees_database.db'),
      onCreate: (db, version) {
        return db.execute(
          'CREATE TABLE employees(id INTEGER PRIMARY KEY, name TEXT, role TEXT, startDate TEXT, endDate TEXT)',
        );
      },
      version: 1,
    );
  }

  Future<void> insertEmployee(Employee employee) async {
    await open();
    await _database?.insert('employees', employee.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<List<Employee>> getEmployees() async {
    await open();
    final List<Map<String, dynamic>>? maps =
    await _database?.query('employees');
    return List.generate(maps!.length, (i) {
      return Employee(
        id: maps[i]['id'],
        name: maps[i]['name'],
        role: maps[i]['role'],
        startDate: DateTime.parse(maps[i]['startDate']),
        endDate: maps[i]['endDate'].toString()!="0" ? int.parse(maps[i]['endDate']) : 0,
      );
    });
  }

  Future<void> updateEmployee(Employee employee) async {
    await open();
    await _database?.update(
      'employees',
      employee.toMap(),
      where: 'id = ?',
      whereArgs: [employee.id],
    );
  }

  Future<void> deleteEmployee(int id) async {
    await open();
    await _database?.delete('employees', where: 'id = ?', whereArgs: [id]);
  }
}