import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';

class ConvertCoordinates extends StatefulWidget {
  const ConvertCoordinates({super.key});

  @override
  State<ConvertCoordinates> createState() => _ConvertCoordinatesState();
}

class _ConvertCoordinatesState extends State<ConvertCoordinates> {
  String convertedAddress = "";
  String getCoordinatesFromTheAddress = "";
  Future<String> getAddressFromCoordinates(
      double latitude, double longitude) async {
    List<Placemark> placemarks =
        await placemarkFromCoordinates(latitude, longitude);
    Placemark place = placemarks[0];
    convertedAddress =
        "${place.street},${place.locality},${place.administrativeArea}";

    return convertedAddress;
  }

  Future<List<Location>> getCoordinatesFromAddress(String adrress) async{
    List<Location> locations = await locationFromAddress(adrress);
    getCoordinatesFromTheAddress = locations.toString();

    return locations;

  }

  @override
  Widget build(BuildContext context) {
  return Scaffold(
    appBar: AppBar(
      title: const Text(
        'Convert',
        style: TextStyle(fontSize: 20),
      ),
    ),
    body: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            convertedAddress,
            style: const TextStyle(fontSize: 20),
          ),
          SelectableText(
            getCoordinatesFromTheAddress,
            style: const TextStyle(fontSize: 20),
          ),
          GestureDetector(
            onTap: () async {
              await getAddressFromCoordinates(30.1798398, 66.9749731);
              await getCoordinatesFromAddress("Quetta city");
              setState(() {
                // Update state variables here after async operations
                // For example:
                // convertedAddress = ...;
                // getCoordinatesFromTheAddress = ...;
              });
            },
            child: Container(
              height: 50,
              width: double.infinity,
              decoration: BoxDecoration(
                  color: Colors.deepPurple,
                  borderRadius: BorderRadius.circular(15)),
              child: const Center(
                child: Text(
                  "convert",
                  style: TextStyle(color: Colors.white, fontSize: 20),
                ),
              ),
            ),
          )
        ],
      ),
    ),
  );
}

}
