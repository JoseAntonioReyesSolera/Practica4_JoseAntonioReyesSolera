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
    //Obtenir es Path
    Directory documentDirectory = await getApplicationDocumentsDirectory();
    final path = join(documentDirectory.path, 'Scans.db');
    print(path);

    //Creació de la BBDD
    return await openDatabase(
      path,
      version: 1,
      onOpen: (db) {},
      onCreate: (Database db, int version) async {
        await db.execute(
        '''
          CREATE TABLE Scans(
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
      print(res);
      return res;
    }

  Future<List<ScanModel>> getAllScans() async {
    final db = await database;
    final res = await db.query('Scans');
    return res.isNotEmpty ? res.map((e) => ScanModel.fromJson(e)).toList() : [];
  }

  Future<ScanModel?> getScanById(int id) async {
    final db = await database;
    final res = await db.query('Scans', where: 'id = ?', whereArgs: [id]);

    if (res.isNotEmpty) {
      return ScanModel.fromJson(res.first);
    }
    return null;
  }

  // ----- * ----- * ----- * -----
  Future<List<ScanModel>> getScansByType(String tipus) async {
  final db = await database;
  final res = await db.query(
    'Scans',
    where: 'tipus = ?',
    whereArgs: [tipus],
  );

  return res.isNotEmpty ? res.map((e) => ScanModel.fromJson(e)).toList() : [];
  }
  // ----- * ----- * ----- * -----

  Future<int> updateScan(ScanModel nouScan) async {
    final db = await database;
    final res = db.update('Scans', nouScan.toJson(),
    where: 'id = ?', whereArgs: [nouScan.id]);

    return res;
  }

  Future<int> deleteAllScans() async {
    final db = await database;
    final res = await db.rawDelete(
    '''
      DELETE FROM Scans
    ''');
    return res;
  }

  // ----- * ----- * ----- * -----
  Future<int> deleteScan(int id) async {
  final db = await database;
  final res = await db.delete(
    'Scans',
    where: 'id = ?',
    whereArgs: [id],
  );

  return res;
  }
  // ----- * ----- * ----- * -----
}