import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:provider/provider.dart';
import 'package:qr_scan_joseantonioreyes/models/scan_model.dart';
import 'package:qr_scan_joseantonioreyes/providers/scan_list_provider.dart';
import 'package:qr_scan_joseantonioreyes/util/utils.dart';

class ScanButton extends StatelessWidget {
  const ScanButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      elevation: 0,
      child: Icon(
        Icons.filter_center_focus,
      ),
      onPressed: () async {
        print('Botó polsat!');
        final MobileScannerController cameraController =
            MobileScannerController();

        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              contentPadding: EdgeInsets.zero,
              content: SizedBox(
                width: double.maxFinite,
                height: 300,
                child: Stack(
                  children: [
                    MobileScanner(
                      controller: cameraController,
                      onDetect: (BarcodeCapture capture) {
                        final barcode = capture.barcodes
                            .first; // Obtiene el primer código escaneado.
                        if (barcode.rawValue != null) {
                          final String code = barcode.rawValue!;
                          Navigator.pop(context); // Cierra el diálogo

                          final scanListProvider =
                              Provider.of<ScanListProvider>(context,
                                  listen: false);
                          ScanModel nouScan = ScanModel(valor: code);
                          scanListProvider.nouScan(code);
                          launchURL(context, nouScan);
                          
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                                content: Text('No se pudo leer el código QR.')),
                          );
                        }
                      },
                    ),
                    Positioned(
                      top: 10,
                      right: 10,
                      child: IconButton(
                        icon: Icon(Icons.close, color: Colors.red),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ).then((_) {
          // Aquí cerramos la cámara cuando se cierra el diálogo.
          cameraController.dispose();
        });
      },
    );
  }
}