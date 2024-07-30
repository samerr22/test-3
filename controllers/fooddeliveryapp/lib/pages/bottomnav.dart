import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';  // Import Firebase Auth
import 'package:fooddeliveryapp/pages/home.dart';
import 'package:fooddeliveryapp/pages/order.dart';
import 'package:fooddeliveryapp/pages/profile.dart';
import 'package:fooddeliveryapp/pages/videoupload.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
  // Adjust the import path based on your file structure

class BottomNav extends StatefulWidget {
  const BottomNav({Key? key}) : super(key: key);

  @override
  State<BottomNav> createState() => _BottomNavState();
}

class _BottomNavState extends State<BottomNav> {
  late User _currentUser;  // Firebase User object
  late String _currentUserUid;  // User's UID

  int currentTabIndex = 0;

  late List<Widget> pages;
  late HomePage homepage;
  late LocationsScreen locationsScreen;  // LocationsScreen with required parameters
  late Order order;
  late Videoupload videoupload;

  @override
  void initState() {
    super.initState();
    _fetchCurrentUser();  // Fetch current user when widget initializes
  }

  Future<void> _fetchCurrentUser() async {
    FirebaseAuth auth = FirebaseAuth.instance;
    User? user = auth.currentUser;

    if (user != null) {
      setState(() {
        _currentUser = user;
        _currentUserUid = user.uid;
        
        // Initialize pages with the current user's UID
        homepage = HomePage();
        order = Order();
        locationsScreen = LocationsScreen(key: UniqueKey(), currentUserUid: _currentUserUid);
        videoupload = Videoupload(uid: '',);
        pages = [homepage, order, videoupload, locationsScreen];
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: CurvedNavigationBar(
        height: 65,
        backgroundColor: Colors.white,
        color: Color.fromARGB(255, 2, 65, 237),
        animationDuration: Duration(milliseconds: 500),
        onTap: (int index) {
          setState(() {
            currentTabIndex = index;
          });
        },
        items: [
          Icon(
            Icons.home_outlined,
            color: Colors.white,
          ),
          Icon(Icons.access_time, color: Colors.white),
          Icon(Icons.add_a_photo_outlined, color: Colors.white),
          Icon(Icons.person_outline, color: Colors.white),
        ],
      ),
      body: pages[currentTabIndex],
    );
  }
}
