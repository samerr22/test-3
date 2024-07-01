import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:googlemapstutorials/convert_coordinates.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Future<Position> getUserCurrentLocation() async {
    await Geolocator.requestPermission().then((value) {}).onError(
      (error, stackTrace) {
        print(error.toString());
      },
    );
    return await Geolocator.getCurrentPosition();
  }

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
          getUserCurrentLocation().then((value) async {
            print("My Current Location $value");
            _marker.add(
              Marker(
                markerId: const MarkerId("3"),
                position: LatLng(value.latitude, value.longitude),
                infoWindow: const InfoWindow(title: "My Current Location"),
              ),
            );

            CameraPosition cameraPosition =
                CameraPosition(target: LatLng(value.latitude, value.longitude),zoom: 14);
            GoogleMapController controller = await _completer.future;
            controller.animateCamera(
              CameraUpdate.newCameraPosition(cameraPosition),
            );
          });

          setState(() {});
        },
        child: const Icon(Icons.location_city_outlined),
      ),
      drawer: Drawer(
        child: Padding(
          padding:  EdgeInsets.only(top: 150),
          child: ListTile(
            onTap: (){
             Navigator.push(context, MaterialPageRoute(builder: (context) => const ConvertCoordinates(),
             ));
            },


            title: const Text("Convert Coordinates"),
            leading: const Icon(Icons.change_circle),
          
          ),
        ),),
    );
  }
}
