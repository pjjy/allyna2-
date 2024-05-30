import 'dart:async';
import 'dart:io';
import 'package:flutter_application_1/Main%20Pages/addinventory.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class CheckData {
  static final CheckData _instance = CheckData._();
  Database? _database;

  CheckData._();

  factory CheckData() {
    return _instance;
  }

  Future<Database> get db async {
    if (_database != null) {
      return _database!;
    }

    _database = await init();

    return _database!;
  }

  Future<Database> init() async {
    Directory directory = await getApplicationDocumentsDirectory();
    String dbPath = join(directory.path, 'check_data.db');
    var database = openDatabase(dbPath,
        version: 1,
        onCreate: _onCreate,
        onUpgrade: _onUpgrade, onConfigure: (Database db) async {
      await db.execute('PRAGMA cache_size = 10097152;');
    });

    return database;
  }

  void _onCreate(Database db, int version) {
    db.execute('''
      CREATE TABLE dailyInvetory(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        sBoar TEXT,
        jBoar TEXT,
        drySow TEXT,
        sowBreed TEXT,
        lactatingSow TEXT,
        rplcmentGlit TEXT,
        glitBreed TEXT,
        date TEXT
        )''');

    db.execute('''
      CREATE TABLE dailyFarrowing(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        litterOrder TEXT,
        age TEXT,
        birthWt TEXT,
        pigsWearned TEXT,
        interval TEXT,
        date TEXT
        )''');

    db.execute('''
      CREATE TABLE dailyMotality(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        suckling TEXT,
        weanings TEXT,
        starter TEXT,
        grower TEXT,
        breeders TEXT,
        date TEXT
        )''');

    db.execute('''
      CREATE TABLE expenses(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        type TEXT,
        amount TEXT,
        date TEXT
        )''');

    print("Database was created!");
  }

  void _onUpgrade(Database db, int oldVersion, int newVersion) {
    // Run migration according database versions
  }

  Future<int> addInventory(sBoar, jBoar, drySow, sowBreed, lactatingSow,
      rplcmentGlit, glitBreed, date) async {
    var client = await db;
    return client.insert('dailyInvetory', {
      'sBoar': sBoar,
      'jBoar': jBoar,
      'drySow': drySow,
      'sowBreed': sowBreed,
      'lactatingSow': lactatingSow,
      'rplcmentGlit': rplcmentGlit,
      'glitBreed': glitBreed,
      'date': date
    });
  }

  Future<int> addMortality(
      suckling, weanings, starter, grower, breeders, date) async {
    var client = await db;
    return client.insert('dailyMotality', {
      'suckling': suckling,
      'weanings': weanings,
      'starter': starter,
      'grower': grower,
      'breeders': breeders,
      'date': date
    });
  }

  Future<int> addFarrowing(
      litterOrder, age, birthWt, pigsWearned, interval, date) async {
    var client = await db;
    return client.insert('dailyFarrowing', {
      'litterOrder': litterOrder,
      'age': age,
      'birthWt': birthWt,
      'pigsWearned': pigsWearned,
      'interval': interval,
      'date': date
    });
  }

  Future<int> addExpenses(type, amount, date) async {
    var client = await db;
    return client
        .insert('expenses', {'type': type, 'amount': amount, 'date': date});
  }

  Future<List> fetInventoryData() async {
    var client = await db;
    return await client.rawQuery('SELECT * FROM dailyInvetory');
  }

  Future<List> fetcFarrowingData() async {
    var client = await db;
    return await client.rawQuery('SELECT * FROM dailyFarrowing');
  }

  Future<List> fetcDailyMotalityData() async {
    var client = await db;
    return await client.rawQuery('SELECT * FROM dailyMotality');
  }

  Future<List> fetcDailyExpenseData() async {
    var client = await db;
    return await client.rawQuery('SELECT * FROM expenses');
  }

  // dash
  Future<List> fetchDashMortality(id) async {
    var client = await db;
    return await client
        .rawQuery('SELECT * FROM dailyMotality WHERE id = ?', [id]);
  }

  Future<List> fetchDashFarrowing(id) async {
    var client = await db;
    return await client
        .rawQuery('SELECT * FROM dailyFarrowing WHERE id = ?', [id]);
  }

  Future<List> fetchDash(id) async {
    var client = await db;
    return await client
        .rawQuery('SELECT * FROM dailyInvetory WHERE id = ?', [id]);
  }

  Future<List> fetchDashExpenses(id) async {
    var client = await db;
    return await client.rawQuery('SELECT * FROM expenses WHERE id = ?', [id]);
  }

  //delete
  Future deleteInventory(id) async {
    var client = await db;
    client.rawQuery('DELETE FROM dailyInvetory WHERE id = ?', [id]);
  }

  Future deleteMortality(id) async {
    var client = await db;
    client.rawQuery('DELETE FROM dailyMotality WHERE id = ?', [id]);
  }

  Future deleteFarrowing(id) async {
    var client = await db;
    client.rawQuery('DELETE FROM dailyFarrowing WHERE id = ?', [id]);
  }

  Future deleteExpense(id) async {
    var client = await db;
    client.rawQuery('DELETE FROM expenses WHERE id = ?', [id]);
  }

  //total
  Future totalInventory() async {
    var client = await db;
    return await client.rawQuery(
        'SELECT strftime("%Y-%m", date) AS month, SUM(sBoar) AS Total_sBoar, SUM(jBoar) AS Total_jBoar,  SUM(drySow) AS Total_drySow, SUM(lactatingSow) AS Total_lactatingSow, SUM(rplcmentGlit) AS Total_rplcmentGlit, SUM(glitBreed) AS Total_glitBreed FROM dailyInvetory GROUP BY strftime("%Y-%m", date)');
  }

  Future totalExpenses() async {
    var client = await db;
    return await client.rawQuery(
        'SELECT strftime("%Y-%m", date) AS month, type as tottype, SUM(amount) AS Total_amount FROM expenses GROUP BY type');
  }
}
