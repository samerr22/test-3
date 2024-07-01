import 'package:flutter/material.dart';
import 'package:fooddeliveryapp/widget/widget_support.dart';

class Details extends StatefulWidget {
  const Details({super.key});

  @override
  State<Details> createState() => _DetailsState();
}

class _DetailsState extends State<Details> {
  
  int a=1;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        margin: EdgeInsets.only(top: 50.0, left: 20.0, right: 20.0),
        
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
        GestureDetector(
          onTap: (){
            Navigator.pop(context);
          },
          child: Icon(Icons.arrow_back_ios_new_outlined, color: Colors.black,)),
          Image.asset("images/salad2.png", width: MediaQuery.of(context).size.width, height: MediaQuery.of(context).size.height/2.5, fit: BoxFit.fill,),
          SizedBox(height: 50.0,),
         
         Row(
          
          children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Mediterranean", style: AppWidget.styleTextFeildStyle(),),
              Text("Chickpea Salad", style: AppWidget.HeadlineTextFeildStyle(),),
            ],
          ),
          Spacer(),
          GestureDetector(
            onTap: () {
              if(a>1){
              --a;
              }
            
              setState(() {
                
              });
            },
            child: Container(
              decoration: BoxDecoration(color: Colors.black, borderRadius: BorderRadius.circular(8)),
              child: Icon(Icons.remove, color: Colors.white,),
            ),
          ),
          SizedBox(width: 20.0,),
          Text(a.toString(), style: AppWidget.styleTextFeildStyle(),),
          SizedBox(width: 20.0,),
          GestureDetector(
            onTap: (){
              ++a;
              setState(() {
                
              });
            },
            child: Container(
              decoration: BoxDecoration(color: Colors.black, borderRadius: BorderRadius.circular(8)),
              child: Icon(Icons.add, color: Colors.white,),
            ),
          )
         ],),
         SizedBox(height: 20.0,),
         Text("In academic terms, a text is anything that conveys a set of meanings to the person who examines it. You might have thought that texts were limited to writte.", style: AppWidget.LightTextFeildStyle(),),
         SizedBox(height: 25.0,),
         Row(children: [
          Text("Delivery Time", style: AppWidget.styleTextFeildStyle(),),
          Icon(Icons.alarm, color: Colors.black54,),
          SizedBox(width: 5.0,),
          Text("30 min", style: AppWidget.styleTextFeildStyle(),)
         ],),
         Spacer(),
         Padding(
           padding: const EdgeInsets.only(bottom: 40.0),
           child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Total Price", style: AppWidget.styleTextFeildStyle(),),
                Text("\$28", style: AppWidget.blodTextFeildStyle(),),
              ],
            ),
            Container(
              width: MediaQuery.of(context).size.width/2,
              padding: EdgeInsets.all(8),
              decoration: BoxDecoration(color: Colors.black, borderRadius: BorderRadius.circular(10)),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                Text(
                  "Add to cart", style: TextStyle(color: Colors.white, fontSize: 16.0),
                
                ),
                SizedBox(width: 30.0,),
                Container(
                  
                  padding: EdgeInsets.all(3),
                  decoration: BoxDecoration(
                    color: Colors.grey, borderRadius: BorderRadius.circular(8)
                  ),

                  
                  child: Icon(Icons.shopping_bag_outlined, color: Colors.white,),
                ),
                SizedBox(width: 20.0,),
              ],),
            )
             
           ],),
         )
      ],),),

    );
  }
}