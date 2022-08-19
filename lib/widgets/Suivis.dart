import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:lilicourse/main.dart';
import 'package:lilicourse/services/directionrepository.dart';

import '../models/direction.dart';
import '../screens/Home/HomePage.dart';

class SuiviRequest extends StatefulWidget {
  final double Rlatitude;
  final double Rlongitude;
  final double Elatitude;
  final double Elongitude;

  SuiviRequest(
      {required this.Rlatitude,
      required this.Rlongitude,
      required this.Elatitude,
      required this.Elongitude});

  @override
  State<SuiviRequest> createState() => _SuiviRequestState();
}

class _SuiviRequestState extends State<SuiviRequest> {
  static const _initialCameraPosition = CameraPosition(
    target: LatLng(4.0571001, 9.721927),
    zoom: 12.5,
  );

  GoogleMapController? _googleMapController;
  Marker? _origin;
  Marker? _destination;
  Marker? _currentLocation;
  Directions? _info;

  @override
  void dispose() {
    _googleMapController!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        title: const Text('Google Maps'),
        actions: [
          if (_origin != null)
            TextButton(
              onPressed: () {
                _googleMapController!.animateCamera(
                  CameraUpdate.newCameraPosition(
                    CameraPosition(
                        target: _origin!.position, zoom: 14.5, tilt: 50.0),
                  ),
                );
              },
              style: TextButton.styleFrom(
                primary: blue_button,
                textStyle: const TextStyle(fontWeight: FontWeight.w600),
              ),
              child: const Text('ORIGIN'),
            ),
          if (_destination != null)
            TextButton(
              onPressed: () {
                _googleMapController!.animateCamera(
                  CameraUpdate.newCameraPosition(
                    CameraPosition(
                        target: _destination!.position, zoom: 14.5, tilt: 50.0),
                  ),
                );
              },
              style: TextButton.styleFrom(
                primary: blue_button,
                textStyle: const TextStyle(fontWeight: FontWeight.w600),
              ),
              child: const Text('DEST'),
            ),
        ],
      ),
      body: Stack(
        children: [
          GoogleMap(
            myLocationButtonEnabled: false,
            zoomControlsEnabled: false,
            initialCameraPosition: _initialCameraPosition,
            onMapCreated: (controller) {
              _googleMapController = controller;
            },
            markers: {
              if (_origin != null) _origin!,
              if (_destination != null) _destination!
            },
            onLongPress: _addMarker,
          ),
          Positioned(
            top: 20.0,
            child: Container(
              padding:
                  const EdgeInsets.symmetric(vertical: 6.0, horizontal: 12.0),
              decoration: BoxDecoration(
                  color: red_button,
                  borderRadius: BorderRadius.circular(20.0),
                  boxShadow: const [
                    BoxShadow(
                        color: Colors.black26,
                        offset: Offset(0, 2),
                        blurRadius: 6.0),
                  ]),
              child: Text(
                "${_info!.totalDistance},${_info!.totalDuration}",
                style: const TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Theme.of(context).primaryColor,
        foregroundColor: Colors.black,
        onPressed: () {
          _googleMapController!.animateCamera(
            _info != null
                ? CameraUpdate.newLatLngBounds(_info!.bounds, 100.0)
                : CameraUpdate.newCameraPosition(_initialCameraPosition),
          );
        },
        child: const Icon(Icons.center_focus_strong),
      ),
    );
  }

  void _addMarker(LatLng argument) async {
    if (_origin == null || (_origin != null && _destination != null)) {
      setState(() {
        _origin = Marker(
            markerId: const MarkerId('origin'),
            infoWindow: const InfoWindow(title: 'Origin'),
            icon:
                BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed),
            position: argument);
      });
      _destination = null;
      _info = null;
    } else {
      setState(() {
        _destination = Marker(
            markerId: const MarkerId('destination'),
            infoWindow: const InfoWindow(title: 'Destination'),
            icon:
                BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue),
            position: argument);
      });

      final directions = await DirectionRepository()
          .getDirections(origin: _origin!.position, destination: argument);
    }
  }
}
