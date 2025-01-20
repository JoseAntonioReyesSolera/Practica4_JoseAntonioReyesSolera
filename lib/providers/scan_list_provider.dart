import 'package:flutter/foundation.dart';
import 'package:qr_scan_joseantonioreyes/models/scan_model.dart';
import 'package:qr_scan_joseantonioreyes/providers/db_provider.dart';

class ScanListProvider extends ChangeNotifier{
  List<ScanModel> scans = [];
  String tipusSeleccionat = 'http';

  Future<ScanModel> nouScan(String valor) async {
    final nouScan = ScanModel(valor: valor);
    final id = await DbProvider.db.insertScan(nouScan);
    nouScan.id = id;

    if(nouScan.tipus == tipusSeleccionat) {
      this.scans.add(nouScan);
      notifyListeners();
    }
    return nouScan;
  }

  carregaScans() async {
    final scans = await DbProvider.db.getAllScans();
    this.scans = [...scans];
    notifyListeners();
  }

  // ----- * ----- * ----- * -----
  carregaScansPerTipus(String tipus) async {
    final scans = await DbProvider.db.getScansByType(tipus);
    this.scans = [...scans];
    this.tipusSeleccionat = tipus;
    notifyListeners();
  }

  esborraTots() async {
    await DbProvider.db.deleteAllScans();
    this.scans = [];
    notifyListeners();
  }

  esborraPerId(int id) async {
    await DbProvider.db.deleteScan(id);
    this.scans.removeWhere((scan) => scan.id == id);
    notifyListeners();
  }
  // ----- * ----- * ----- * -----
}