import 'package:flutter/material.dart';
import '../widget/widget_support.dart';



class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        margin: EdgeInsets.only(top: 50.0, left: 10.0, right: 10.0),
        child: Column(
          children: [
            Row(
              children: [
                Text(
                  "Hello sameera,",
                 style:AppWidget.blodTextFeildStyle(),
                ),
                 Container(
              decoration: BoxDecoration(color: Colors.black),
              child: Icon(Icons.shopping_cart, color: Colors.white,),
            )
              ],
            ),
           

          ],
        ),
      ),
    );
  }
}
