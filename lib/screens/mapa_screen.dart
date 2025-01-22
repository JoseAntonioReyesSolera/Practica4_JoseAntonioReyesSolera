import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:qr_scan_joseantonioreyes/models/scan_model.dart';

class MapaScreen extends StatefulWidget {
  const MapaScreen({Key? key}) : super(key: key);

  @override
  State<MapaScreen> createState() => _MapaScreenState();
}

class _MapaScreenState extends State<MapaScreen> {
  Completer<GoogleMapController> _controller = Completer();
  MapType _currentMapType = MapType.hybrid;

  @override
  Widget build(BuildContext context) {
    final ScanModel scan =
        ModalRoute.of(context)!.settings.arguments as ScanModel;

    final CameraPosition _puntInicial = CameraPosition(
      target: scan.getLatLng(),
      zoom: 17,
      tilt: 50,
    );

    Set<Marker> markers = new Set<Marker>();
    markers.add(new Marker(
      markerId: MarkerId('id1'),
      position: scan.getLatLng(),
    ));

    return Scaffold(
      appBar: AppBar(
        title: Text('Mapa'),
        centerTitle: true,
        backgroundColor: Colors.deepPurple,
      ),
      body: Stack(
        children: [
          GoogleMap(
            myLocationEnabled: true,
            myLocationButtonEnabled: false,
            mapType: _currentMapType,
            markers: markers,
            initialCameraPosition: _puntInicial,
            onMapCreated: (GoogleMapController controller) {
              _controller.complete(controller);
            },
          ),
          // ----- * ----- * ----- * -----
          Positioned(
            top: 10,
            right: 10,
            child: FloatingActionButton(
              heroTag: 'btnRecenter',
              onPressed: () async {
                final GoogleMapController controller = await _controller.future;
                controller.animateCamera(
                    CameraUpdate.newCameraPosition(_puntInicial));
              },
              backgroundColor: Colors.deepPurple,
              child: Icon(Icons.center_focus_strong, color: Colors.white),
            ),
          ),
          Positioned(
            bottom: 20,
            right: 60,
            child: FloatingActionButton(
                  heroTag: 'btnMapType',
                  onPressed: () {
                    setState(() {
                      _currentMapType = _currentMapType == MapType.hybrid
                          ? MapType.normal
                          : MapType.hybrid;
                    });
                  },
                  backgroundColor: Colors.deepPurple,
                  child: Icon(Icons.map, color: Colors.white),
                ),)
          // ----- * ----- * ----- * -----
        ],
      ),
    );
  }
}
