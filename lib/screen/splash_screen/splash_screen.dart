import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:salesmen_app/Auth/auth.dart';
import 'package:salesmen_app/model/user_model.dart';
import 'package:salesmen_app/others/style.dart';
import 'package:salesmen_app/screen/child_lock.dart';
import 'package:salesmen_app/screen/login_screen/login_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatefulWidget {

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  getUserStatus()async{
    SharedPreferences prefs=await SharedPreferences.getInstance();
    var phone=prefs.getString("phoneNo");
    var password=prefs.getString("password");
    print("phone: $phone");
    print("password: $password");
    if(phone==null||password==null){
      Timer(Duration(seconds: 3), ()=>Navigator.push(context, MaterialPageRoute(builder: (context)=>LoginScreen())));
    }
    else{
      getLogin(phone.toString(),password.toString());
    }
  }
  getLogin(String phone,String password)async{
    print(phone);
    print(password);
    var response=await Auth.getLogin(phoneNo:phone, password:password,onSuccess: (response)async{
      if(response.statusCode==200){
        var data=jsonDecode(response.toString());
        print(data['success']);
        await Provider.of<UserModel>(context,listen: false).fetchData(data);
        Navigator.push(context, MaterialPageRoute(builder: (context)=>ChildLock()));
      }
      else if(response.statusCode==401 ||response.statusCode==501){
        Alert(
          context: context,
          type: AlertType.error,
          title: "Authentication Failed",
          desc: "please check your phone number and password",
          buttons: [
            DialogButton(
              color:themeColor1 ,
              child: Text(
                "CANCEL",
                style: TextStyle(color: Colors.white  ,fontSize: 20),
              ),
              onPressed: () => Navigator.pop(context),
              width: 120,
            )
          ],
        ).show();
      }
      else{
        Alert(
          context: context,
          type: AlertType.error,
          title: "Somethings wants wrongs",
          desc: "please try again after few Mints",
          buttons: [
            DialogButton(
              color:themeColor1 ,
              child: Text(
                "CANCEL",
                style: TextStyle(color:Colors.white , fontSize: 20),
              ),
              onPressed: () => Navigator.pop(context),
              width: 120,
            )
          ],
        ).show();
      }
    },onError: (e){
      Alert(
        context: context,
        type: AlertType.error,
        title: "Authentication Failed",
        desc: "check phone and password",
        buttons: [
          DialogButton(
            color:themeColor1 ,
            child: Text(
              "CANCEL",
              style: TextStyle(color: Colors.white ,fontSize: 20),
            ),
            onPressed: () => Navigator.pop(context),
            width: 120,
          )
        ],
      ).show();
      print("Login Error: $e");});
  }
  @override
  void initState() {
    getUserStatus();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(image: AssetImage("assets/images/splash_background.jpg",),fit: BoxFit.cover),
        ),
        child: Container(decoration: BoxDecoration(color: themeColor1.withOpacity(0.8)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Spacer(),
              Center(child: Image.asset("assets/images/logo.png", scale: 2)),
              Spacer(),
              Container(
                  width: 100,
                  child: LinearProgressIndicator(color: Colors.white,)),
              Spacer(),
              Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Text("SKR Service 2021. All Right Reserved.",style: TextStyle(color: Colors.white,fontSize: 14),)
              ),
            ],
          ),
        ),
      ),
    );
  }
}