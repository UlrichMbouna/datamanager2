import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import '../models/data_usage.dart';
import '../models/activation.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper._internal();
  factory DatabaseHelper() => _instance;
  DatabaseHelper._internal();

  static Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    String path = join(await getDatabasesPath(), 'datamanager.db');
    return await openDatabase(
      path,
      version: 1,
      onCreate: _createTables,
    );
  }

  Future<void> _createTables(Database db, int version) async {
    await db.execute('''
      CREATE TABLE data_usage(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        date INTEGER NOT NULL,
        usedData REAL NOT NULL,
        totalData REAL NOT NULL,
        periodType TEXT NOT NULL
      )
    ''');

    await db.execute('''
      CREATE TABLE activation(
        key TEXT PRIMARY KEY,
        activationDate INTEGER NOT NULL,
        expirationDate INTEGER,
        isValid INTEGER NOT NULL
      )
    ''');
  }

  // Data Usage Methods
  Future<int> insertDataUsage(DataUsage usage) async {
    final db = await database;
    return await db.insert('data_usage', usage.toMap());
  }

  Future<List<DataUsage>> getDataUsages() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query('data_usage');
    return List.generate(maps.length, (i) => DataUsage.fromMap(maps[i]));
  }

  Future<List<DataUsage>> getDataUsagesByPeriod(String periodType) async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query(
      'data_usage',
      where: 'periodType = ?',
      whereArgs: [periodType],
      orderBy: 'date DESC',
    );
    return List.generate(maps.length, (i) => DataUsage.fromMap(maps[i]));
  }

  // Activation Methods
  Future<int> insertActivation(Activation activation) async {
    final db = await database;
    return await db.insert('activation', activation.toMap());
  }

  Future<Activation?> getActivation() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query('activation');
    if (maps.isEmpty) return null;
    return Activation.fromMap(maps.first);
  }

  Future<int> deleteActivation() async {
    final db = await database;
    return await db.delete('activation');
  }
}