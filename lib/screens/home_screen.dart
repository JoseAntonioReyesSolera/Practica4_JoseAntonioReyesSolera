import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qr_scan_joseantonioreyes/models/scan_model.dart';
import 'package:qr_scan_joseantonioreyes/providers/db_provider.dart';
import 'package:qr_scan_joseantonioreyes/providers/scan_list_provider.dart';
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
            onPressed: () {
              Provider.of<ScanListProvider>(context, listen: false)
              .esborraTots();
            },
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

    final scanListProvider = Provider.of<ScanListProvider>(context, listen: false);

    switch (currentIndex) {
      case 0:
        scanListProvider.carregaScansPerTipus('geo');
        return MapasScreen();

      case 1:
      scanListProvider.carregaScansPerTipus('http');
        return DireccionsScreen();

      default:
      scanListProvider.carregaScansPerTipus('geo');
        return MapasScreen();
    }
  }
}
