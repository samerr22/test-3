import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class IconSelectionDialog extends StatelessWidget {
  final LatLng location;
  final Function(String) onIconSelected;

  IconSelectionDialog({required this.location, required this.onIconSelected});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text("Select an Icon"),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          GestureDetector(
            onTap: () => onIconSelected('yellow'),
            child: CircleAvatar(
              backgroundColor: Colors.yellow,
              radius: 30,
              child: Text('Y', style: TextStyle(color: Colors.black)),
            ),
          ),
          SizedBox(height: 10),
          GestureDetector(
            onTap: () => onIconSelected('red'),
            child: CircleAvatar(
              backgroundColor: Colors.red,
              radius: 30,
              child: Text('R', style: TextStyle(color: Colors.white)),
            ),
          ),
          SizedBox(height: 10),
          GestureDetector(
            onTap: () => onIconSelected('green'),
            child: CircleAvatar(
              backgroundColor: Colors.green,
              radius: 30,
              child: Text('G', style: TextStyle(color: Colors.white)),
            ),
          ),
        ],
      ),
    );
  }
}
