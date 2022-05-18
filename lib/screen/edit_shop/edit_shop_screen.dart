import 'package:flutter/material.dart';
import 'package:salesmen_app/others/style.dart';

class EditShopScreen extends StatefulWidget {

  @override
  State<EditShopScreen> createState() => _EditShopScreenState();
}

class _EditShopScreenState extends State<EditShopScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: themeColor1,
        title: Text("Edit Shop",style: TextStyle(color: Colors.white),),
        leading: IconButton(onPressed: ()=>Navigator.pop(context),icon: Icon(Icons.arrow_back,color: Colors.white,),),
      ),
      body: Container(
        child: Text("verify"),
      ),
    );
  }
}
