import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:salesmen_app/model/user_model.dart';
import 'package:salesmen_app/screen/edit_shop/edit_shop_screen.dart';
import 'package:salesmen_app/screen/login_screen/login_screen.dart';
import 'package:salesmen_app/screen/main_screeen/mainScreen.dart';
import 'package:salesmen_app/screen/splash_screen/splash_screen.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized(); // Add this
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<UserModel>(
          create: (_) => UserModel(),
        ),
      ],
      child: MaterialApp(
        theme: ThemeData(
          appBarTheme: AppBarTheme(
            color: Colors.blue
          )
        ),
        home: MainScreen(),
      ),
    );
  }
}



