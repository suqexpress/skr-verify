import 'dart:convert';
import 'dart:math' show acos, sin,cos,pi;
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:geocoder/geocoder.dart';
import 'package:geolocator/geolocator.dart';
import 'package:intl/intl.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:salesmen_app/model/customerListModel.dart';
import 'package:salesmen_app/model/customerModel.dart';
import 'package:salesmen_app/others/style.dart';
import 'package:salesmen_app/others/widgets.dart';
import 'package:location/location.dart' as loc;
import 'package:salesmen_app/screen/login_screen/login_screen.dart';
import 'package:salesmen_app/screen/main_screeen/search_screen.dart';
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
  List<CustomerListModel> customer=[];
  bool loading=false;
  TextEditingController search=TextEditingController();
  void onStart()async{
    var locationPermission = await Permission.locationAlways.request();
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
  String distance(
      double lat1, double lon1, double lat2, double lon2, String unit) {
    double theta = lon1 - lon2;
    double dist = sin(deg2rad(lat1)) * sin(deg2rad(lat2)) +
        cos(deg2rad(lat1)) * cos(deg2rad(lat2)) * cos(deg2rad(theta));
    dist = acos(dist);
    dist = rad2deg(dist);
    dist = dist * 60 * 1.1515;
    if (unit == 'K') {
      dist = dist * 1.609344;
    } else if (unit == 'N') {
      dist = dist * 0.8684;
    }
    return dist.toStringAsFixed(2);
  }

  double deg2rad(double deg) {
    return (deg * pi / 180.0);
  }

  double rad2deg(double rad) {
    return (rad * 180.0 / pi);
  }
  getCustomer()async{
    setLoading(true);
    var dio = Dio();
    var response= await dio.get("https://erp.suqexpress.com/api/listcustomers").catchError((e)=>print("error: $e"));
    if (response.statusCode==200){
      // var data=jsonDecode(response.toString());
      debugPrint("get customer success");
      int i=0;
      for (var shop in response.data["data"]){
        double dist= Geolocator.distanceBetween(userLatLng.latitude, userLatLng.longitude, double.parse(shop['lat'].toString()=="null"?1.toString():shop['lat'].toString()),double.parse(shop['long'].toString()=="null"?1.toString():shop['long'].toString()));
        //calculateDistance(userLatLng.latitude, userLatLng.longitude, double.parse(shop['lat']), double.parse(shop['long'].toString()));
        customer.add(CustomerListModel.fromJson(shop,dist.toDouble()));
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
    bool _isSearching=false;
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
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  InkWell(
                      onTap:()=>Navigator.push(context, MaterialPageRoute(builder: (context)=>SearchScreen(customerModel: customer, lat: 1.0, long: 1.0))),
                      child: Container(
                          width: width * 0.7,
                          child: SearchField(enable: false,onTap: (){}))),
                  Container(
                    padding: EdgeInsets.symmetric(vertical: 1,horizontal: 5),
                    decoration: BoxDecoration(
                      color: themeColor1,
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: IconButton(onPressed: (){
                      onStart();
                      getCustomer();
                    },icon: Icon(Icons.refresh,color: Colors.white,),),),

                ],
              ),
              Container(
                child: customer.length<1?Center(child:Text("No Shop Found")):
                ListView.builder(
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,

                    itemCount: customer.length>10?10:customer.length,
                    itemBuilder:(context,index){
                      return
                        /*ListTile(
                        title: Text(customer[index].custName.toString(),style: TextStyle(fontSize: 14),),
                        subtitle: Text(customer[index].custPrimNb.toString()),
                        trailing: Text(customer[index].distance.toStringAsFixed(2)),
                        leading: CircleAvatar(
                          radius: 30,
                          backgroundColor: customer[index].verified==0?Colors.grey:themeColor1,
                          child: Text("V",style: TextStyle(fontSize: 20,color: Colors.white,fontWeight: FontWeight.bold),),
                        ),
                      );*/

                        CustomerCard(
                        height: height,
                        width: width,
                        f: f,
                        menuButton: menuButton,
                        code: customer[index].id,
                        category: customer[index].id,
                        shopName: customer[index].custName,
                        address:customer[index].custAddress,
                        name: customer[index].custName,
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
