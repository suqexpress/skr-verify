import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:salesmen_app/others/style.dart';
import 'package:salesmen_app/others/widgets.dart';

import '../../search_field.dart';
var f = NumberFormat("###,###.0#", "en_US");
class MainScreen extends StatefulWidget {

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  late List nearByCustomers=["0","0","0","0","0","0"];
  List<String> menuButton = ["DIRECTION",'EDIT SHOP'];
  bool isLoading=true;
  @override
  Widget build(BuildContext context) {
    var media = MediaQuery.of(context).size;
    double height = media.height;
    var width = media.width;
    return Scaffold(
      appBar: AppBar(
        backgroundColor:themeColor1,
        title: Center(child: Text("DashBoard",style: TextStyle(color: Colors.white),)),
        actions: [
          Center(child: Text("Landhi Korangi   ",style: TextStyle(color: Colors.white),))
        ],
      ),
      drawer: Drawer(child: DrawerHeader(
        child: Text("talha"),),),
    body: SingleChildScrollView(
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 15),
        child: Column(children: [
          SearchField(),
          Container(
            child: ListView.builder(
              physics: NeverScrollableScrollPhysics(),
              shrinkWrap: true,
                itemCount: 5,
                itemBuilder:(context,index){
              return CustomerCard(
                height: height,
                width: width,
                f: f,
                menuButton: menuButton,
                code: "00123",
                category: "Imran Autos Kashmir Colony",
                shopName: "HADI AUTOS",
                address:"karachi sindh pakistan ",
                name: "TALHA IQBAL",
                phoneNo: "+923012070920",
                lastVisit: "NEVER",
                dues: 3000,
                lastTrans:"NEVER",
                outstanding: 2000,
                shopAssigned: "Yes",
                lat: "123",
                long: "123",
                customerData: nearByCustomers[0],
                image:
                "https://www.google.com/imgres?imgurl=https%3A%2F%2Fimages.indianexpress.com%2F2021%2F12%2Fdoctor-strange-2-1200.jpg&imgrefurl=https%3A%2F%2Findianexpress.com%2Farticle%2Fentertainment%2Fhollywood%2Fdoctor-strange-2-suggest-benedict-cumberbatch-sorcerer-supreme-might-lead-avengers-7698058%2F&tbnid=GxuE_SM1fXrAqM&vet=12ahUKEwjr4bj575_3AhVMxqQKHSC5BRAQMygBegUIARDbAQ..i&docid=6gb_YRZyTk5MWM&w=1200&h=667&q=dr%20strange&ved=2ahUKEwjr4bj575_3AhVMxqQKHSC5BRAQMygBegUIARDbAQ",
                showLoading: (value) {
                  setState(() {
                    isLoading = value;
                  });
                },
              );
            }
            ),
          )
        ],),
      ),
    ),
    );
  }
}
