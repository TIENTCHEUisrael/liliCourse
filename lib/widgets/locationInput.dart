import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:lilicourse/main.dart';
import 'package:location/location.dart';

import '../screens/livraison/map_screens.dart';
import '../services/location_service.dart';

class LocationInput extends StatefulWidget {
  final TextEditingController controller;
  Function onselectPlace;

  LocationInput({required this.controller, required this.onselectPlace});
  @override
  State<LocationInput> createState() => _LocationInputState();
}

class _LocationInputState extends State<LocationInput> {
  String? _previewimageUrl;

  void _showPreview(double? lat, double? lng) {
    final staticMapImageUrl = LocationHelper.generateLocationPreviewImage(
        latitude: lat!, longitude: lng!);
    print(lat);
    print(lng);
    setState(() {
      _previewimageUrl = staticMapImageUrl;
    });
  }

  Future<void> _getCurrentUserLocation() async {
    try {
      final locData = await Location().getLocation();
      _showPreview(locData.latitude, locData.longitude);
      widget.onselectPlace(locData.latitude, locData.longitude);
      print('ok');
    } catch (error) {
      print('Error :' + error.toString());
    }
  }

  Future<void> _selectOnMap() async {
    final LatLng selectedLocation = await Navigator.of(context).push(
      MaterialPageRoute(
        fullscreenDialog: true,
        builder: (ctx) => MapScreen(
          isSelecting: true,
        ),
      ),
    );
    if (selectedLocation == null) {
      return;
    }
    _showPreview(selectedLocation.latitude, selectedLocation.longitude);
    widget.onselectPlace(selectedLocation.latitude, selectedLocation.longitude);
  }

  final bool read = false;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.zero,
      child: Column(
        children: [
          TextField(
            readOnly: read,
            controller: widget.controller,
            onTap: () async {
              // placeholder for our places search later
            },
            // with some styling
            decoration: InputDecoration(
              icon: Container(
                margin: const EdgeInsets.only(left: 20),
                width: 10,
                height: 10,
                /*child: const Icon(
                  Icons.edit_location,
                  color: Colors.black,
                ),*/
              ),
              hintText: "Check your shipping address",
              border: InputBorder.none,
              contentPadding: const EdgeInsets.only(left: 8.0, top: 16.0),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              FlatButton.icon(
                textColor: blue_button,
                icon: const Icon(
                  Icons.location_on,
                  size: 15,
                ),
                label: Text(
                  'Current location',
                  style: GoogleFonts.poppins(fontSize: 10),
                ),
                onPressed: _getCurrentUserLocation,
              ),
              FlatButton.icon(
                textColor: blue_button,
                icon: const Icon(Icons.map),
                label: Text(
                  'Select on Map',
                  style: GoogleFonts.poppins(fontSize: 10),
                ),
                onPressed: _selectOnMap,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
