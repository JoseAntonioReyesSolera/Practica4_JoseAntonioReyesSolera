import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qr_scan_joseantonioreyes/models/scan_model.dart';
import 'package:qr_scan_joseantonioreyes/providers/db_provider.dart';
import 'package:qr_scan_joseantonioreyes/providers/ui_provider.dart';
import 'package:qr_scan_joseantonioreyes/screens/screens.dart';
import 'package:qr_scan_joseantonioreyes/widgets/widgets.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Historial'),
        actions: [
          IconButton(
            icon: Icon(Icons.delete_forever),
            onPressed: () {},
          )
        ],
      ),
      body: _HomeScreenBody(),
      bottomNavigationBar: CustomNavigationBar(),
      floatingActionButton: ScanButton(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}

class _HomeScreenBody extends StatelessWidget {
  const _HomeScreenBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final uiProvider = Provider.of<UIProvider>(context);
    // Canviar per a anar canviant entre pantalles
    final currentIndex = uiProvider.selectedMenuOpt;

    DbProvider.db.database;
    final nouScan = ScanModel(
      valor: "https://www.paucasesnocescifp.cat"
    );
    DbProvider.db.insertScan(nouScan);

    switch (currentIndex) {
      case 0:
        return MapasScreen();

      case 1:
        return DireccionsScreen();

      default:
        return MapasScreen();
    }
  }
}
