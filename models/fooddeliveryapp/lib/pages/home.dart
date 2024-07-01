import 'package:flutter/material.dart';
import 'package:fooddeliveryapp/pages/details.dart';
import '../widget/widget_support.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  bool icecrem = false, pizza = false, salad = false, burger = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        margin: EdgeInsets.only(top: 50.0, left: 20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Hello sameera,",
                  style: AppWidget.blodTextFeildStyle(),
                ),
                Container(
                  margin: EdgeInsets.only(right: 20.0),
                  padding: EdgeInsets.all(3),
                  decoration: BoxDecoration(
                      color: Colors.black,
                      borderRadius: BorderRadius.circular(10)),
                  child: Icon(
                    Icons.shopping_cart,
                    color: Colors.white,
                  ),
                )
              ],
            ),
            SizedBox(
              height: 20.0,
            ),
            Text(
              "Delicious Food",
              style: AppWidget.HeadlineTextFeildStyle(),
            ),
            Text(
              "Discover adn Get Grat Food",
              style: AppWidget.LightTextFeildStyle(),
            ),
            SizedBox(
              height: 20.0,
            ),
            showItem(),
            SizedBox(height: 30.0,),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(children: [
                GestureDetector(
                  onTap: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context)=> Details()));
                  },
                  child: Container(
                    margin: EdgeInsets.all(6),
                    child: Material(
                      elevation: 5.0,
                      borderRadius: BorderRadius.circular(20),
                      child: Container(
                        padding: EdgeInsets.all(14),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                          Image.asset("images/salad2.png", height: 150, width: 150, fit: BoxFit.cover,),
                          Text("Veggie Taco Hash", style: AppWidget.styleTextFeildStyle(),),
                          SizedBox(height: 5.0,),
                          Text("Fresh and Healthy", style: AppWidget.LightTextFeildStyle(),),
                           SizedBox(height: 5.0,),
                          Text("\$25", style: AppWidget.styleTextFeildStyle(),),
                        ],),
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 10.0,),
                Container(
                  margin: EdgeInsets.all(4),
                  child: Material(
                    elevation: 5.0,
                    borderRadius: BorderRadius.circular(20),
                    child: Container(
                      padding: EdgeInsets.all(14),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                        Image.asset("images/salad2.png", height: 150, width: 150, fit: BoxFit.cover,),
                        Text("Veggie Taco Hash", style: AppWidget.styleTextFeildStyle(),),
                        SizedBox(height: 5.0,),
                        Text("Fresh and Healthy", style: AppWidget.LightTextFeildStyle(),),
                         SizedBox(height: 5.0,),
                        Text("\$25", style: AppWidget.styleTextFeildStyle(),),
                      ],),
                    ),
                  ),
                ),
              ],),
            ),
            SizedBox(height: 30.0,),
            Container(
              margin: EdgeInsets.only(right: 20.0 ),
              child: Material(
                elevation: 5.0,
                borderRadius: BorderRadius.circular(20),
                child: Container(
                  padding: EdgeInsets.all(5),
                  child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Image.asset("images/salad2.png", height: 120, width: 120, fit: BoxFit.cover,),
                    SizedBox(width: 20.0,),
                    Column(children: [
                      Container(
                        width: MediaQuery.of(context).size.width/2,
                        child: Text("Mediterranean Chckpea Salad", style: AppWidget.styleTextFeildStyle(),)),
                        SizedBox(height: 5.0,),
                         Container(
                        width: MediaQuery.of(context).size.width/2,
                        child: Text("Honey goot cheese", style: AppWidget.LightTextFeildStyle(),)),
                          Container(
                        width: MediaQuery.of(context).size.width/2,
                        child: Text("\$28", style: AppWidget.styleTextFeildStyle(),))
                    ],),
                     
                
                  ],),
                ),
              ),
            ),

           
          ],
        ),
      ),
    );
  }
  Widget showItem(){
    return  Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  onTap: () {
                    icecrem = true;
                    pizza = false;
                    salad = false;
                    burger = false;
                    setState(() {});
                  },
                  child: Material(
                    elevation: 5.0,
                    borderRadius: BorderRadius.circular(10),
                    child: Container(
                      decoration: BoxDecoration(
                          color: icecrem ? Colors.black : Colors.white,
                          borderRadius: BorderRadius.circular(8)),
                      padding: EdgeInsets.all(10),
                      child: Image.asset(
                        "images/ice-cream.png",
                        height: 40,
                        width: 40,
                        fit: BoxFit.cover,
                        color: icecrem ? Colors.white : Colors.black,
                      ),
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    icecrem = false;
                    pizza = true;
                    salad = false;
                    burger = false;
                    setState(() {});
                  },
                  child: Material(
                    elevation: 5.0,
                    borderRadius: BorderRadius.circular(10),
                    child: Container(
                      decoration: BoxDecoration(
                          color: pizza ? Colors.black : Colors.white,
                          borderRadius: BorderRadius.circular(8)),
                      padding: EdgeInsets.all(10),
                      child: Image.asset(
                        "images/pizza.png",
                        height: 40,
                        width: 40,
                        fit: BoxFit.cover,
                        color: pizza ? Colors.white : Colors.black,
                      ),
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    icecrem = false;
                    pizza = false;
                    salad = true;
                    burger = false;
                    setState(() {});
                  },
                  child: Material(
                    elevation: 5.0,
                    borderRadius: BorderRadius.circular(10),
                    child: Container(
                      decoration: BoxDecoration(
                          color: salad ? Colors.black : Colors.white,
                          borderRadius: BorderRadius.circular(8)),
                      padding: EdgeInsets.all(10),
                      child: Image.asset(
                        "images/salad.png",
                        height: 40,
                        width: 40,
                        fit: BoxFit.cover,
                        color: salad ? Colors.white : Colors.black,
                      ),
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    icecrem = false;
                    pizza = false;
                    salad = false;
                    burger = true;
                    setState(() {});
                  },
                  child: Material(
                    elevation: 5.0,
                    borderRadius: BorderRadius.circular(10),
                    child: Container(
                      decoration: BoxDecoration(
                          color: burger? Colors.black : Colors.white,
                          borderRadius: BorderRadius.circular(8)),
                      padding: EdgeInsets.all(10),
                      child: Image.asset(
                        "images/burger.png",
                        height: 40,
                        width: 40,
                        fit: BoxFit.cover,
                        color: burger? Colors.white : Colors.black,
                      ),
                    ),
                  ),
                ),
              ],
            );
  }
}
