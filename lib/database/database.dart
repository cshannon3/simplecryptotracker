import 'package:path/path.dart';

import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'dart:async';
import 'dart:io';

class CryptoDatabase {

  static final CryptoDatabase _instance = CryptoDatabase._internal();

  factory CryptoDatabase() => _instance;
  static Database _db;

  Future<Database> get db async {
    if (_db != null) {
      return _db;
    }
    _db = await initDB();
    return _db;
  }

  CryptoDatabase._internal();

  Future<Database> initDB() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, "main.db");
    var theDB = await openDatabase(path, version: 1, onCreate: _onCreate);
    return theDB;
  }

  void _onCreate(Database db, int version) async {
    await db.execute(
        '''CREATE TABLE Coins(id STRING PRIMARY KEY, name TEXT, symbol TEXT, paid_usd TEXT, assets REAL, favored BIT)''');

    await db.execute(
        '''CREATE TABLE Transactions(id STRING PRIMARY KEY, Coin_id_from TEXT, Coin_id_to TEXT, amt_from TEXT, amt_to TEXT, amt_usd TEXT, date TEXT)''');


    print("Database was Created!");
  }


}