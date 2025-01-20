import 'dart:io';

import 'package:path_provider/path_provider.dart';
import 'package:qr_scan_joseantonioreyes/models/scan_model.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DbProvider {
  static Database? _database;
  static final DbProvider db = DbProvider._();

  DbProvider._();

  Future<Database> get database async {
    if (_database == null) _database = await initDB();

    return _database!;
  }

  Future<Database> initDB() async {
    Directory documentDirectory = await getApplicationDocumentsDirectory();
    final path = join(documentDirectory.path, 'Scans.db');
    print(path);

    return await openDatabase(
      path,
      version: 1,
      onOpen: (db) {},
      onCreate: (Database db, int version) async {
        await db.execute('''
        CREATE TABLE IF NOT EXISTS Scans(
       id INTEGER PRIMARY KEY,
       tipus TEXT,
       valor TEXT
       ) 
        ''');
      },
    );
  }

  Future<int> inserRawScan(ScanModel nouScan) async  {
      final id = nouScan.id;
      final tipus = nouScan.tipus;
      final valor = nouScan.valor;

      final db = await database;

      final res = await db.rawInsert(
        '''
        INSERT INTO Scans (id, tipus, valor)
        VALUES ($id, '$tipus', $valor)
        ''');
      return res;
    }
  Future<int> insertScan(ScanModel nouScan) async {
      final db = await database;

      final res = await db.insert('Scans', nouScan.toJson());
      return res;
    }

  Future<List<ScanModel>> getAllScans() async {
    final db = await database;
    final res = await db.query('Scans');
    //return res.isNotEmpty ? res.map(e) => ScanModel.fromJson(e)).toList() : []; //video P4.2.4 / 2:44
}
}