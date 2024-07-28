import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:fooddeliveryapp/pages/database.dart';
import 'package:fooddeliveryapp/pages/icon_selection_dialog.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:location/location.dart';
import 'package:audioplayers/audioplayers.dart';



class HomePage extends StatefulWidget {
  const HomePage({ Key? key }) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Completer<GoogleMapController> _googleMapController = Completer();
  CameraPosition? _cameraPosition;
  Location? _location;
  LocationData? _currentLocation;
  Set<Marker> _markers = {};
  final DatabaseService _databaseService = DatabaseService();
  final AudioPlayer audioPlayer = AudioPlayer();

  //voice selectted accroding to the color
  static const Map<String, String> situationMessages = {
  'yellow': 'this_is_an_accident_area',
  'red': 'this_is_a_flood_area',
  'green': 'this_is_a_mountain_falls',
};

FirebaseAuth auth = FirebaseAuth.instance;

//voice speech near the 200m meters 
double haversineDistance(LatLng point1, LatLng point2) {
  const double R = 6371000; // Radius of the Earth in meters
  double lat1 = point1.latitude * (pi / 180);
  double lat2 = point2.latitude * (pi / 180);
  double deltaLat = (point2.latitude - point1.latitude) * (pi / 180);
  double deltaLon = (point2.longitude - point1.longitude) * (pi / 180);

  double a = sin(deltaLat / 2) * sin(deltaLat / 2) +
             cos(lat1) * cos(lat2) *
             sin(deltaLon / 2) * sin(deltaLon / 2);
  double c = 2 * atan2(sqrt(a), sqrt(1 - a));

  return R * c; // Distance in meters
}

//check the mark and near the 200 meter and speech voice 
void _checkProximity() {
  if (_currentLocation != null) {
    LatLng currentLatLng = LatLng(_currentLocation!.latitude!, _currentLocation!.longitude!);
    for (var marker in _markers) {
      debugPrint('Marker title: ${marker.infoWindow.title}');
      double distance = haversineDistance(currentLatLng, marker.position);
      debugPrint('Distance to marker ${marker.markerId}: $distance meters');
      
      if (distance < 200) { // Within 200 meters
        String? situation = marker.infoWindow.title?.toLowerCase(); 
        debugPrint('Near marker with situation: $situation');
        
        if (situationMessages.keys.contains(situation)) {
           debugPrint('Found valid situation: $situation');
          

          _playVoiceAlert(situation!);
        } else{
          debugPrint('Situation not found in messages: $situation');
        }
      }
    }
  }
}









  @override
  void initState() {
    _init();
    super.initState();
  }

  _init() async {
    _location = Location();
    _cameraPosition = CameraPosition(
      target: LatLng(0, 0), // Initialize with a placeholder
      zoom: 13,
    );
    await _initLocation();
    await _loadSavedLocations(); // Load saved locations
  }


  _initLocation() async {
    _currentLocation = await _location?.getLocation();
    if (_currentLocation != null) {
      moveToPosition(LatLng(_currentLocation!.latitude ?? 0, _currentLocation!.longitude ?? 0));
    }
    _location?.onLocationChanged.listen((newLocation) {
      _currentLocation = newLocation;
      moveToPosition(LatLng(_currentLocation?.latitude ?? 0, _currentLocation?.longitude ?? 0));
      _checkProximity();
    });
  }

  moveToPosition(LatLng latLng) async {
    GoogleMapController mapController = await _googleMapController.future;
    mapController.animateCamera(
      CameraUpdate.newCameraPosition(
        CameraPosition(
          target: latLng,
          zoom: 13,
        ),
      ),
    );
  }

//play voice function 
Future<void> _playVoiceAlert(String situation) async {
  String? audioFileName = situationMessages[situation];
  if (audioFileName != null) {
    String audioPath = "audio/$audioFileName.mp3";// Construct the path
    debugPrint('Attempting to play audio from: $audioPath');
    try {
      debugPrint('Setting audio source...');
      await audioPlayer.setSource(AssetSource(audioPath));
      debugPrint('Audio source set successfully.');
      await audioPlayer.resume(); // Start playing the audio
      debugPrint('Audio playback started.');
    } catch (e) {
    debugPrint('Error playing audio: $e');
    }
  } else {
    debugPrint('No audio file for situation: $situation');
  }
}



 //mark location with icons
  Future<void> _markCurrentLocation(String iconColor) async {
    if (_currentLocation != null) {
      // Get current user UID
      String? uid = auth.currentUser?.uid;
      if (uid != null) {
        // Save the current location and icon color to Firebase
        await _databaseService.saveLocationWithIcon(_currentLocation!.latitude!, _currentLocation!.longitude!, iconColor, uid);

        // Add a marker on the map with the selected icon color
        BitmapDescriptor markerIcon;

        switch (iconColor) {
          case 'yellow':
            markerIcon = BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueYellow);
            break;
          case 'red':
            markerIcon = BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed);
            break;
          case 'green':
            markerIcon = BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueGreen);
            break;
          default:
            markerIcon = BitmapDescriptor.defaultMarker; // Fallback
        }

        setState(() {
          _markers.add(Marker(
            markerId: MarkerId(_currentLocation!.latitude.toString() + _currentLocation!.longitude.toString()),
            position: LatLng(_currentLocation!.latitude!, _currentLocation!.longitude!),
            infoWindow: InfoWindow(title: iconColor),
            icon: markerIcon,
          ));
        });
      }
    }
  }

//save location display in the google
Future<void> _loadSavedLocations() async {
  List<Map<String, dynamic>> savedLocations = await _databaseService.getAllLocations();
  for (var location in savedLocations) {
    LatLng latLng = LatLng(location['latitude'], location['longitude']);
    String iconColor = location['iconColor'];

    BitmapDescriptor markerIcon;

    switch (iconColor) {
      case 'yellow':
        markerIcon = BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueYellow);
        break;
      case 'red':
        markerIcon = BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed);
        break;
      case 'green':
        markerIcon = BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueGreen);
        break;
      default:
        markerIcon = BitmapDescriptor.defaultMarker; // Fallback
    }

    setState(() {
      _markers.add(Marker(
        markerId: MarkerId(latLng.latitude.toString() + latLng.longitude.toString()),
        position: latLng,
        infoWindow: InfoWindow(title: iconColor),
        icon: markerIcon,
      ));
    });
  }
}



  
//current location display button 
  @override
Widget build(BuildContext context) {
  return Scaffold(
    body: _buildBody(),
    floatingActionButton: FloatingActionButton(
      onPressed: () async {
        if (_currentLocation != null) {
          // Show the icon selection dialog
          showDialog(
            context: context,
            builder: (context) {
              return IconSelectionDialog(
                location: LatLng(_currentLocation!.latitude!, _currentLocation!.longitude!),
                onIconSelected: (iconColor) async {
                  // Save the current location with the selected icon color
                  await _markCurrentLocation(iconColor);
                  Navigator.of(context).pop(); // Close the dialog
                },
              );
            },
          );
        }
      },
      child: Icon(Icons.save),
    ),
  );
}

  Widget _buildBody() {
    return _getMap();
  }

//live location dipslay marker
  Widget _getMarker() {
    return Container(
      width: 40,
      height: 40,
      padding: EdgeInsets.all(2),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(100),
        boxShadow: [
          BoxShadow(
            color: Colors.grey,
            offset: Offset(0, 3),
            spreadRadius: 4,
            blurRadius: 6,
          ),
        ],
      ),
      child: ClipOval(child: Image.asset("assets/profile.jpeg")),
    );
  }


//get google map 
  Widget _getMap() {
    return Stack(
      children: [
        GoogleMap(
          initialCameraPosition: _cameraPosition!,
          mapType: MapType.normal,
          onMapCreated: (GoogleMapController controller) {
            if (!_googleMapController.isCompleted) {
              _googleMapController.complete(controller);
            }
          },
          markers: _markers, // Display markers on the map
        ),
        Positioned.fill(
          child: Align(
            alignment: Alignment.center,
            child: _getMarker(),
          ),
        ),
      ],
    );
  }
}
