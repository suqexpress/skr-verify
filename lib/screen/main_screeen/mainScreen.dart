import 'dart:convert';
import 'dart:math' show acos, sin,cos,pi;
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:geocoder/geocoder.dart';
import 'package:geolocator/geolocator.dart';
import 'package:intl/intl.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';
import 'package:salesmen_app/model/customerListModel.dart';
import 'package:salesmen_app/model/customerModel.dart';
import 'package:salesmen_app/model/user_model.dart';
import 'package:salesmen_app/others/style.dart';
import 'package:salesmen_app/others/widgets.dart';
import 'package:location/location.dart' as loc;
import 'package:salesmen_app/screen/login_screen/login_screen.dart';
import 'package:salesmen_app/screen/main_screeen/search_screen.dart';
import 'package:salesmen_app/screen/notFoundScreen/notFoundScreen.dart';
import 'package:salesmen_app/screen/unVerifiedScreen/unVerfiedScreen.dart';
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
    _serviceEnabled = await Permission.location.isGranted;
    loc.Location location= await loc.Location();
    print("location permission: " + _serviceEnabled.toString());
    if (!_serviceEnabled) {
      var locationPermission = await Permission.location.request();
      print("permission ${locationPermission}");
      if (locationPermission.isGranted) {
        bool temp = await location.serviceEnabled();
        if (!temp) {
          var resquest = await location.requestPermission();
          bool _locationService=await location.serviceEnabled();
          var _location = await location.getLocation();
          userLatLng = await Coordinates(_location.latitude, _location.longitude);
// location.hasPermission(locationPermission.);
          if (!_locationService) {
            print('denied');
            Fluttertoast.showToast(
                msg: "Please turn on location",
                toastLength: Toast.LENGTH_SHORT,
                gravity: ToastGravity.BOTTOM,
                timeInSecForIosWeb: 3,
                backgroundColor: Colors.black87,
                textColor: Colors.white,
                fontSize: 16.0);
            return;
          }
        } else {
          print("already enabled");
        }
      } else {
        print('denied');
        Fluttertoast.showToast(
            msg: "Please give location permission",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 3,
            backgroundColor: Colors.black87,
            textColor: Colors.white,
            fontSize: 16.0);
        return;
      }
    }
    var _location = await location.getLocation();
    _serviceEnabled = true;
    actualAddress = "Searching....";
    userLatLng = await Coordinates(_location.latitude, _location.longitude);
    setState(() {});
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
    var response= await dio.get("https://erp.suqexpress.com/api/listcustomers").catchError((e)=>print("error: $e"));
    if (response.statusCode==200){
      // var data=jsonDecode(response.toString());
      debugPrint("get customer success");
      int i=0;
      for (var shop in response.data["data"]){
        double dist= Geolocator.distanceBetween(userLatLng.latitude, userLatLng.longitude, double.parse(shop['lat'].toString()=="null"?1.toString():shop['lat'].toString()),double.parse(shop['long'].toString()=="null"?1.toString():shop['long'].toString()));
        //calculateDistance(userLatLng.latitude, userLatLng.longitude, double.parse(shop['lat']), double.parse(shop['long'].toString()));
        if(shop["verified"].toInt()==1) {
          customer.add(CustomerListModel.fromJson(shop, dist.toDouble()));
          debugPrint("distsnce: ${dist.toString()} $i ${customer[i].id}");
        }
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
    final userData = Provider.of<UserModel>(context, listen: true);
    bool _isSearching=false;
    var media = MediaQuery.of(context).size;
    double height = media.height;
    var width = media.width;
    //TODO: set provider variable here and update the hard coded information with your details
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
              decoration: BoxDecoration(
                color: themeColor1,
              ),
              accountName: Text(userData.firstName.toString()),
              accountEmail: Text(userData.phone.toString()),
              currentAccountPicture: CircleAvatar(
                backgroundColor: Colors.orange,
                child: Text(userData.firstName.toString().substring(0,1),
                 // userData.firstName.toString().substring(0,1),
                  style: TextStyle(fontSize: 40.0,color: Colors.white),
                ),
              ),
            ),
            ListTile(
              leading: Icon(Icons.home), title: Text("Verified Shops"),
              onTap: () {
              },
            ),
            ListTile(
              leading: Icon(Icons.settings), title: Text("Unverified Shops"),
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context)=>UnVerifiedScreen()));
                },
            ),
            ListTile(
              leading: Icon(Icons.contacts), title: Text("Not Found"),
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context)=>ShopNotFound()));
              },
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
      child:Container(
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
          Stack(
            alignment: Alignment.center,
            children: [
              loading?Container(
                  color: Colors.white.withOpacity(0.5),
                  width: width,
                  height: height* 0.87,
                  alignment: Alignment.center,
                  child: Loading()):Container(
                width: width,
                height: height* 0.87,
                child: customer.length<1?Center(child:Text("No Shop Found")):
                SingleChildScrollView(
                  child: Container(
                    padding: EdgeInsets.only(bottom: 60),
                    child: ListView.builder(
                        physics: NeverScrollableScrollPhysics(),
                        shrinkWrap: true,

                        itemCount: customer.length>10?10:customer.length,
                        itemBuilder:(context,index){
                          return
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
                  ),
                ),
              )

            ],
          )

        ],),
      ),
    ),
    );
  }
}
