import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import '../models/calculation.dart';

class DBProvider {
  DBProvider._();
  static final DBProvider db = DBProvider._();
  static Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB();
    return _database!;
  }

  Future<Database> _initDB() async {
    final dir = await getApplicationDocumentsDirectory();
    final path = join(dir.path, 'calculations.db');
    return await openDatabase(
      path,
      version: 1,
      onCreate: _createDB,
    );
  }

  Future<void> _createDB(Database db, int version) async {
    await db.execute('''
      CREATE TABLE Calculations(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        capital REAL,
        term REAL,
        rate REAL,
        interest REAL,
        date TEXT
      )
    ''');
  }

  Future<int> addCalculation(Calculation calculation) async {
    final db = await database;
    return await db.insert('Calculations', calculation.toMap());
  }

  Future<List<Calculation>> getAllCalculations() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query('Calculations', orderBy: 'date DESC');
    return List.generate(maps.length, (i) => Calculation.fromMap(maps[i]));
  }

  Future<int> deleteCalculation(int id) async {
    final db = await database;
    return await db.delete('Calculations', where: 'id = ?', whereArgs: [id]);
  }

  Future<void> clearAllCalculations() async {
    final db = await database;
    await db.delete('Calculations');
  }
}
