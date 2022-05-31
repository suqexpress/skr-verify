import 'package:flutter/material.dart';
import 'package:salesmen_app/screen/edit_shop/edit_shop_image.dart';
import 'package:salesmen_app/screen/edit_shop/edit_shop_screen.dart';
import 'package:salesmen_app/screen/login_screen/login_screen.dart';
import 'package:salesmen_app/screen/main_screeen/mainScreen.dart';
import 'package:salesmen_app/screen/splash_screen/splash_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        appBarTheme: AppBarTheme(
          color: Colors.blue
        )
      ),
      home: SplashScreen(),
    );
  }
}



