import 'package:flutter/material.dart';
import 'package:fooddeliveryapp/pages/database.dart';
import 'package:fooddeliveryapp/pages/markersee.dart'; // Import the MapScreen

class LocationsScreen extends StatefulWidget {
  final String currentUserUid;

  LocationsScreen({required Key key, required this.currentUserUid}) : super(key: key);

  @override
  _LocationsScreenState createState() => _LocationsScreenState();
}

class _LocationsScreenState extends State<LocationsScreen> {
  List<Map<String, dynamic>> _locations = [];

  @override
  void initState() {
    super.initState();
    // Fetch locations for current user UID
    DatabaseService().getLocationsForUid(widget.currentUserUid).listen((locations) {
      setState(() {
        _locations = locations;
      });
    });
  }

  void _deleteLocation(String documentId) {
    DatabaseService().deleteLocation(documentId);
    // Optionally update state to refresh UI after deletion
  }

  void _viewOnMap(double latitude, double longitude, String iconColor) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => MapScreen(latitude: latitude, longitude: longitude, iconColor: iconColor),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('My Mark Locations'),
        automaticallyImplyLeading: false,
      ),
      body: ListView.builder(
        itemCount: _locations.length,
        itemBuilder: (context, index) {
          Color iconColor;
          switch (_locations[index]['iconColor']) {
            case 'yellow':
              iconColor = Colors.yellow;
              break;
            case 'red':
              iconColor = Colors.red;
              break;
            case 'green':
              iconColor = Colors.green;
              break;
            default:
              iconColor = Colors.blue; // Default color if not specified
          }

          return Card(
            child: ListTile(
              title: Text('Location ${index + 1}'),
              subtitle: Text('Latitude: ${_locations[index]['latitude']}, Longitude: ${_locations[index]['longitude']}'),
              trailing: IconButton(
                icon: Icon(Icons.delete),
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: Text('Delete Location?'),
                        content: Text('Are you sure you want to delete this location?'),
                        actions: <Widget>[
                          TextButton(
                            child: Text('Cancel'),
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                          ),
                          TextButton(
                            child: Text('Delete'),
                            onPressed: () {
                              _deleteLocation(_locations[index]['id']);
                              Navigator.of(context).pop();
                            },
                          ),
                        ],
                      );
                    },
                  );
                },
              ),
              leading: IconButton(
                icon: Icon(Icons.location_on, color: iconColor),
                onPressed: () {
                  _viewOnMap(_locations[index]['latitude'], _locations[index]['longitude'], _locations[index]['iconColor']);
                },
              ),
            ),
          );
        },
      ),
    );
  }
}
