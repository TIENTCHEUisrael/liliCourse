import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:lilicourse/main.dart';
import 'package:lilicourse/models/adresse/Adresse/Adresse.dart';
import 'package:lilicourse/screens/Home/HomePage.dart';
import 'package:lilicourse/services/location_service.dart';
import 'package:location/location.dart';

import '../../models/direction.dart';
import '../../services/directionrepository.dart';

class AttentePage extends StatefulWidget {
  final PlaceLocation st;
  final PlaceLocation de;

  AttentePage({required this.st, required this.de});

  @override
  State<AttentePage> createState() => _AttentePageState();
}

class _AttentePageState extends State<AttentePage> {
  final Completer<GoogleMapController> _controller = Completer();
  LatLng? sourceLocation;
  LatLng? destination;
  LatLng? coursierLocalisation;
  Marker? _origin;
  Marker? _current;
  Directions? _info;
  Marker? _destination;
  double t = 4.057882565127137;
  double e = 9.720073007047176;
  double j = 9.721927;
  double i = 4.0571001;
  /**4.0571001, 9.721927 */
  /**4.057882565127137, 9.720073007047176 */

  void start() {
    setState(() {
      j = widget.st.longitude;
      i = widget.st.latitude;
      t = widget.de.latitude;
      e = widget.de.longitude;
      sourceLocation = LatLng(widget.st.latitude, widget.st.longitude);
      destination = LatLng(widget.de.latitude, widget.de.longitude);
    });
  }

  @override
  void didChangeDependencies() {
    j = widget.st.longitude;
    i = widget.st.latitude;
    t = widget.de.latitude;
    e = widget.de.longitude;
    sourceLocation = LatLng(widget.st.latitude, widget.st.longitude);
    destination = LatLng(widget.de.latitude, widget.de.longitude);
    coursierLocalisation = const LatLng(4.057882565127137, 9.720073007047176);
    _addMarkerLivraison(destination!);
    _addMarkerRamassage(sourceLocation!);
    getPolyPoints();
    super.didChangeDependencies();
  }

  /*static const LatLng sourceLocation = LatLng(4.0571001, 9.721927);
  static const LatLng destination = LatLng(4.057882565127137, 9.720073007047176);*/

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

  void _addMarkerRamassage(LatLng argument) async {
    if (_destination != null && _origin == null) {
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
      print('error');
      final directions = await DirectionRepository()
          .getDirections(origin: _origin!.position, destination: argument);
    }
  }

  void _addMarkerLivraison(LatLng argument) async {
    if (_origin != null && _destination == null) {
      setState(() {
        _destination = Marker(
            markerId: const MarkerId('destination'),
            infoWindow: const InfoWindow(title: 'Destination'),
            icon:
                BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue),
            position: argument);
      });
      _destination = null;
      _info = null;
    } else {
      final directions = await DirectionRepository()
          .getDirections(origin: _origin!.position, destination: argument);
    }
  }

  Future<void> getPolyPoints() async {
    PolylinePoints polylinePoints = PolylinePoints();
    PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
      GOOGLE_API_KEY,
      PointLatLng(sourceLocation!.latitude, sourceLocation!.longitude),
      PointLatLng(destination!.latitude, destination!.longitude),
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
    //start();
    getCurrentLocation();
    //getPolyPoints();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: [
          const Text('Back'),
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
                  markerId: const MarkerId('Client'),
                  infoWindow: const InfoWindow(title: 'Client'),
                  icon: BitmapDescriptor.defaultMarkerWithHue(
                      BitmapDescriptor.hueRed),
                  position: LatLng(
                      currentLocation!.latitude!, currentLocation!.longitude!),
                ),
                if (_origin != null) _origin!,
                if (_destination != null) _destination!
              },
              onMapCreated: (mapController) {
                _controller.complete(mapController);
              },
            ),
    );
  }
}
