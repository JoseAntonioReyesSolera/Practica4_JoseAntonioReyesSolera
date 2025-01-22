import 'package:flutter/material.dart';
import 'package:qr_scan_joseantonioreyes/widgets/scan_tiles.dart';

class MapasScreen extends StatelessWidget {
  const MapasScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScanTiles(tipus: 'geo');
  }
}