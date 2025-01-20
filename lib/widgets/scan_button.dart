import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qr_scan_joseantonioreyes/models/scan_model.dart';
import 'package:qr_scan_joseantonioreyes/providers/db_provider.dart';
import 'package:qr_scan_joseantonioreyes/providers/scan_list_provider.dart';

class ScanButton extends StatelessWidget {
  const ScanButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      elevation: 0,
      child: Icon(
        Icons.filter_center_focus,
      ),
      onPressed: () {
        print('Botó polsat!');
        String barcodeScanRes = 'https://paucasesnovescifp.cat';
        final scanListProvider = 
          Provider.of<ScanListProvider>(context, listen: false);
        scanListProvider.nouScan(barcodeScanRes);
      },
    );
  }
}
