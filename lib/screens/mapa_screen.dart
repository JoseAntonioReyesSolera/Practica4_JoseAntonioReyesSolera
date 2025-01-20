import 'package:flutter/material.dart';
import 'package:qr_scan_joseantonioreyes/providers/scan_list_provider.dart';
import 'package:qr_scan_joseantonioreyes/widgets/scan_tiles.dart';

class MapaScreen extends StatelessWidget {
  const MapaScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScanTiles(tipus: 'geo');
  }
}
