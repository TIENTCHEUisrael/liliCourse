import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:lilicourse/main.dart';
import 'package:lilicourse/models/adresse/Adresse/Adresse.dart';
import 'package:lilicourse/screens/Home/HomePage.dart';
import 'package:lilicourse/services/location_service.dart';
import 'package:location/location.dart';

class AttentePage extends StatefulWidget {
  final PlaceLocation st;
  final PlaceLocation de;

  AttentePage({required this.st, required this.de});

  @override
  State<AttentePage> createState() => _AttentePageState();
}

class _AttentePageState extends State<AttentePage> {
  final Completer<GoogleMapController> _controller = Completer();
  double? t;
  double? e;
  double? j;
  double? i;
  /**4.0571001, 9.721927 */

  void start() {
    setState(() {
      j = widget.st.longitude;
      i = widget.st.latitude;
      t = widget.de.latitude;
      e = widget.de.longitude;
    });
  }

  static const LatLng sourceLocation = LatLng(4.0571001, 9.721927);
  static const LatLng destination =
      LatLng(4.057882565127137, 9.720073007047176);

  List<LatLng> polyLinecoordinates = [];
  LocationData? currentLocation;

  void getCurrentLocation() async {
    Location location = Location();

    location.getLocation().then((value) {
      setState(() {
        currentLocation = value;
      });
    });
    GoogleMapController googleMapController = await _controller.future;
    location.onLocationChanged.listen((event) {
      setState(() {
        currentLocation = event;
      });
      googleMapController.animateCamera(
        CameraUpdate.newCameraPosition(
          CameraPosition(
            zoom: 13.5,
            target: LatLng(event.latitude!, event.longitude!),
          ),
        ),
      );
    });
  }

  Future<void> getPolyPoints() async {
    PolylinePoints polylinePoints = PolylinePoints();
    PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
      GOOGLE_API_KEY,
      PointLatLng(sourceLocation.latitude, sourceLocation.longitude),
      PointLatLng(destination.latitude, destination.longitude),
    );

    if (result.points.isNotEmpty) {
      result.points.forEach(
        (element) => polyLinecoordinates.add(
          LatLng(element.latitude, element.longitude),
        ),
      );
      setState(() {});
    }
  }

  @override
  void initState() {
    start();
    getCurrentLocation();
    getPolyPoints();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: [
          IconButton(
            onPressed: () {
              Navigator.of(context).pushReplacement(
                MaterialPageRoute(
                  builder: (context) {
                    return Home();
                  },
                ),
              );
            },
            icon: const Icon(
              Icons.arrow_right,
              size: 45,
              color: Colors.black,
            ),
          ),
        ],
        title: const Text(
          'Map Card',
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: true,
      ),
      body: currentLocation == null
          ? const Center(
              child: Text("loading ..."),
            )
          : GoogleMap(
              initialCameraPosition: CameraPosition(
                  target: /*sourceLocation*/ LatLng(
                      currentLocation!.latitude!, currentLocation!.longitude!),
                  zoom: 13.5),
              polylines: {
                Polyline(
                    polylineId: const PolylineId("route"),
                    points: polyLinecoordinates,
                    color: blue_button,
                    width: 6)
              },
              markers: {
                Marker(
                  markerId: const MarkerId("currentLocation"),
                  position: LatLng(
                      currentLocation!.latitude!, currentLocation!.longitude!),
                ),
                Marker(
                  markerId: MarkerId("source"),
                  position: sourceLocation,
                ),
                Marker(
                  markerId: MarkerId("destination"),
                  position: destination,
                ),
              },
              onMapCreated: (mapController) {
                _controller.complete(mapController);
              },
            ),
    );
  }
}
