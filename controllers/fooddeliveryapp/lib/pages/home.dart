import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'package:google_maps_flutter/google_maps_flutter.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  

  final Completer<GoogleMapController> _completer = Completer();
  final List<Marker> _marker = [];
  final List<Marker> _markerList = [
    const Marker(
        markerId: MarkerId("1"),
        position: LatLng(7.2906, 80.6337),
        infoWindow: InfoWindow(title: "Kandy city")),
    const Marker(
        markerId: MarkerId("1"),
        position: LatLng(6.9271, 79.8612),
        infoWindow: InfoWindow(title: "Colombo city "))
  ];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _marker.addAll(_markerList);
  }

  final CameraPosition _cameraPosition =
      const CameraPosition(target: LatLng(7.2906, 80.6337), zoom: 14.0);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Google Maps"),
      ),
      body: GoogleMap(
        initialCameraPosition: _cameraPosition,
        onMapCreated: (controller) {
          _completer.complete(controller);
        },
        markers: Set<Marker>.of(_marker),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          
          GoogleMapController controller  = await _completer.future;
          controller.animateCamera(
            CameraUpdate.newCameraPosition(
              const CameraPosition(target: LatLng(6.9271, 79.8612),
              zoom: 14.0,
              )
            )
          );

          setState(() {});
        },
        child: const Icon(Icons.location_city_outlined),
      ),
      drawer: Drawer(
        child: Padding(
          padding:  EdgeInsets.only(top: 150),
          child: ListTile(
            onTap: (){
             
            },


            title: const Text("Convert Coordinates"),
            leading: const Icon(Icons.change_circle),
          
          ),
        ),),
    );
  }
}
