import 'dart:convert';
import 'dart:math' show cos, sqrt, asin;
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:geocoder/geocoder.dart';
import 'package:geolocator/geolocator.dart';
import 'package:intl/intl.dart';
import 'package:salesmen_app/model/customerModel.dart';
import 'package:salesmen_app/others/style.dart';
import 'package:salesmen_app/others/widgets.dart';
import 'package:location/location.dart' as loc;
import 'package:salesmen_app/screen/login_screen/login_screen.dart';
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
  bool _serviceEnabled = false;
  var actualAddress = "Searching....";
  late Coordinates userLatLng;
  List<CustomerModel> customer=[];
  bool loading=false;
  void onStart()async{
    loc.Location location = new loc.Location();
    var _location = await location.getLocation();
    _serviceEnabled = true;
    actualAddress = "Searching....";
    userLatLng =Coordinates(_location.latitude, _location.longitude);
    print("userLatLng: " + userLatLng.toString());
    var addresses = await Geocoder.google("AIzaSyDhBNajNSwNA-38zP7HLAChc-E0TCq7jFI").findAddressesFromCoordinates(userLatLng);
    actualAddress = addresses.first.subLocality.toString();
    print(actualAddress);
    setState(() {});
  }
  setLoading(bool value){
    setState(() {
      loading=value;
    });
  }
  getCustomer()async{
    setLoading(true);
    var dio = Dio();
    var response= await dio.get("https://erp.suqexpress.com/api/customer").catchError((e)=>print("error: $e"));
    if (response.statusCode==200){
      // var data=jsonDecode(response.toString());
      debugPrint("get customer success");
      int i=0;
      for (var shop in response.data){
        double dist= Geolocator.distanceBetween(userLatLng.latitude, userLatLng.longitude, double.parse(shop['lat'].toString()=="null"?1.toString():shop['lat'].toString()),double.parse(shop['long'].toString()=="null"?1.toString():shop['long'].toString()));
        //calculateDistance(userLatLng.latitude, userLatLng.longitude, double.parse(shop['lat']), double.parse(shop['long'].toString()));
        customer.add(CustomerModel.fromJson(shop,dist));
        debugPrint("distsnce: ${dist.toString()} $i ${customer[i].id}");
        i++;
      }
      setState(() {
         customer.sort((a, b) => a.distance.compareTo(b.distance));
       });
    }else{
      setLoading(false);
    }
    setLoading(false);
  }
  @override
  void initState() {
    onStart();
    getCustomer();
    super.initState();
  }

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
          Center(child: Text(actualAddress,style: TextStyle(color: Colors.white),))
        ],
      ),
      drawer: Drawer(
        child: ListView(
          // Important: Remove any padding from the ListView.
          padding: EdgeInsets.zero,
          children: <Widget>[
            UserAccountsDrawerHeader(
              accountName: Text("Talha Iqbal"),
              accountEmail: Text("talhaiqbal246@gmail.com"),
              currentAccountPicture: CircleAvatar(
                backgroundColor: Colors.orange,
                child: Text(
                  "A",
                  style: TextStyle(fontSize: 40.0,color: Colors.white),
                ),
              ),
            ),
            ListTile(
              leading: Icon(Icons.home), title: Text("Home"),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: Icon(Icons.settings), title: Text("Settings"),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: Icon(Icons.contacts), title: Text("Contact Us"),
              onTap: () {
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
      child: Stack(
        children: [
          loading?Container(
              color: Colors.white.withOpacity(0.5),
              width: width,
              height: height* 0.87,
              alignment: Alignment.center,
              child: Loading()):Container(
            padding: EdgeInsets.symmetric(horizontal: 15),
            child: Column(children: [
              SearchField(),
              Container(
                child: customer.length<1?Center(child:Text("No Shop Found")):ListView.builder(
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: customer.length>10?10:customer.length,
                    itemBuilder:(context,index){
                      return CustomerCard(
                        height: height,
                        width: width,
                        f: f,
                        menuButton: menuButton,
                        code: customer[index].custOldCode,
                        category: customer[index].custOldCode,
                        shopName: customer[index].userData!.firstName,
                        address:customer[index].custAddress,
                        name: customer[index].custPrimName,
                        phoneNo: customer[index].custPrimNb,
                        lastVisit: "--",
                        dues: "--",
                        lastTrans:"--",
                        outstanding: "--",
                        lat: customer[index].lat,
                        long: customer[index].long,
                        customerData: customer[index],
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
        ],
      )
    ),
    );
  }
}
