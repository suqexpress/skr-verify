import 'dart:async';

import 'package:flutter/material.dart';
import 'package:salesmen_app/others/style.dart';
import 'package:salesmen_app/screen/login_screen/login_screen.dart';

class SplashScreen extends StatefulWidget {

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    Timer(Duration(seconds: 3), ()=>Navigator.push(context, MaterialPageRoute(builder: (context)=>LoginScreen())));
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