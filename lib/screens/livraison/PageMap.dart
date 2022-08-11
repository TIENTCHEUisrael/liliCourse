import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:lilicourse/main.dart';
import 'package:location/location.dart';

import '../../services/location_service.dart';

class AttentePage extends StatefulWidget {
  const AttentePage({Key? key}) : super(key: key);

  @override
  State<AttentePage> createState() => _AttentePageState();
}

class _AttentePageState extends State<AttentePage> {
  final Completer<GoogleMapController> _controller = Completer();
  static const LatLng sourceLocation = LatLng(37.33500926, -122.03272188);
  static const LatLng destination = LatLng(37.33429383, -122.06600055);

  List<LatLng> polylineCoordinates = [];
  LocationData? currentLocation;

  BitmapDescriptor sourceIcon = BitmapDescriptor.defaultMarker;
  BitmapDescriptor destinationIcon = BitmapDescriptor.defaultMarker;
  BitmapDescriptor currentLocationIcon = BitmapDescriptor.defaultMarker;

  void getPolyPoints() async {
    PolylinePoints polylinePoints = PolylinePoints();

    PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
      GOOGLE_API_KEY,
      PointLatLng(sourceLocation.latitude, sourceLocation.longitude),
      PointLatLng(destination.latitude, destination.longitude),
    );

    if (result.points.isNotEmpty) {
      result.points.forEach((PointLatLng point) {
        return polylineCoordinates.add(
          LatLng(point.latitude, point.longitude),
        );
      });
    }
  }

  void setCustomMarkerIcon() {
    BitmapDescriptor.fromAssetImage(
            ImageConfiguration.empty, "assets/images/israel.jpeg")
        .then((icon) {
      sourceIcon = icon;
    });
    BitmapDescriptor.fromAssetImage(
            ImageConfiguration.empty, "assets/images/israel.jpeg")
        .then((icon) {
      destinationIcon = icon;
    });
    BitmapDescriptor.fromAssetImage(
            ImageConfiguration.empty, "assets/images/israel.jpeg")
        .then((icon) {
      currentLocationIcon = icon;
    });
  }

  void getCurrentLocation() async {
    Location location = Location();

    location.getLocation().then(
      (value) {
        currentLocation = value;
      },
    );
    GoogleMapController googleMapController = await _controller.future;
    location.onLocationChanged.listen((event) {
      currentLocation = event;
      googleMapController.animateCamera(
        CameraUpdate.newCameraPosition(
          CameraPosition(
            zoom: 13.5,
            target: LatLng(event.latitude!, event.longitude!),
          ),
        ),
      );
      setState(() {});
    });
  }

  @override
  void initState() {
    getCurrentLocation();
    setCustomMarkerIcon();
    getPolyPoints();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Track Order",
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: currentLocation == null
          ? attente()
          : GoogleMap(
              initialCameraPosition: CameraPosition(
                target: /**sourceLocation */ LatLng(
                    currentLocation!.latitude!, currentLocation!.longitude!),
                zoom: 13.5,
              ),
              polylines: {
                Polyline(
                    polylineId: const PolylineId("route"),
                    points: polylineCoordinates,
                    color: blue_button,
                    width: 6),
              },
              markers: {
                Marker(
                  markerId: const MarkerId("currentLocation"),
                  icon: currentLocationIcon,
                  position: LatLng(
                      currentLocation!.latitude!, currentLocation!.longitude!),
                ),
                Marker(
                  markerId: const MarkerId("source"),
                  icon: sourceIcon,
                  position: sourceLocation,
                ),
                Marker(
                  markerId: const MarkerId("destination"),
                  icon: destinationIcon,
                  position: sourceLocation,
                ),
              },
              onMapCreated: (mapController) {
                _controller.complete(mapController);
              },
            ),
    );
  }

  Widget attente() {
    return Container(
      child: Padding(
        padding: const EdgeInsets.all(5),
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.only(top: 95),
              child: Center(
                child: SvgPicture.asset(
                  'assets/images/tim.svg',
                  height: 250,
                  width: 200,
                ),
              ),
            ),
            Container(
                padding: const EdgeInsets.only(top: 50, bottom: 50),
                child: const CircularProgressIndicator()),
            Container(
              padding: const EdgeInsets.only(top: 220),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Li',
                    style: GoogleFonts.poppins(color: Colors.red),
                  ),
                  Text(
                    'li',
                    style: GoogleFonts.poppins(color: blue_button),
                  ),
                  Text(
                    ' Course version 1.0',
                    style: GoogleFonts.poppins(),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/*
Widget Attente(){
  return SingleChildScrollView(
        padding: const EdgeInsets.all(5),
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.only(top: 95),
              child: Center(
                child: Lottie.asset(
                  'assets/images/timer.json',
                  height: 250,
                  width: 200,
                ),
              ),
            ),
            Container(
                padding: const EdgeInsets.only(top: 50, bottom: 50),
                child: const CircularProgressIndicator()),
            Container(
              padding: const EdgeInsets.only(top: 220),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Li',
                    style: GoogleFonts.poppins(color: Colors.red),
                  ),
                  Text(
                    'li',
                    style: GoogleFonts.poppins(color: blue_button),
                  ),
                  Text(
                    ' Course version 1.0',
                    style: GoogleFonts.poppins(),
                  ),
                ],
              ),
            ),
          ],
        ),
      );
}*/