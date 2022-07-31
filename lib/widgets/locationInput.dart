import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lilicourse/main.dart';

class LocationInput extends StatefulWidget {
  final TextEditingController controller;
  String? text;

  LocationInput({required this.controller, required this.text});
  @override
  State<LocationInput> createState() => _LocationInputState();
}

class _LocationInputState extends State<LocationInput> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.zero,
      child: Column(
        children: [
          TextField(
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
                child: const Icon(
                  Icons.edit_location,
                  color: Colors.black,
                ),
              ),
              hintText: "Enter your shipping address",
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
                onPressed: () {},
              ),
              FlatButton.icon(
                textColor: blue_button,
                icon: const Icon(Icons.map),
                label: Text(
                  'Select on Map',
                  style: GoogleFonts.poppins(fontSize: 10),
                ),
                onPressed: () {},
              ),
            ],
          ),
        ],
      ),
    );
  }
}
