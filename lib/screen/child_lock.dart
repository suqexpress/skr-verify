import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:provider/provider.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:salesmen_app/model/user_model.dart';
import 'package:salesmen_app/others/style.dart';
import 'package:salesmen_app/screen/main_screeen/mainScreen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ChildLock extends StatefulWidget {


  @override
  State<ChildLock> createState() => _ChildLockState();
}

class _ChildLockState extends State<ChildLock> {
  late String todayDate;
  TextEditingController controller=TextEditingController();

   @override
  void initState() {
    var date=DateTime.now();
    var day=date.toString().substring(5,7);
    var month=date.toString().substring(8,10);
    todayDate=month.toString()+day.toString();
    setState(() {});
    super.initState();

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: themeColor1.withOpacity(0.8),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Image.asset("assets/illustration/verification.png",scale: 10,),
              Container(child: Column(children: [
                Text("Child Lock",style: GoogleFonts.archivo(fontSize: 32,color: Colors.white),),
                SizedBox(height: 15,),
                Text("Please enter the current date and month",style: GoogleFonts.archivo(fontSize: 16,color: Colors.white),textAlign: TextAlign.center,),
              ],),),
              SizedBox(height:20,),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: PinCodeTextField(
                  textStyle: TextStyle(color: themeColor1.withOpacity(0.8)),
                  autoDismissKeyboard: true,
                  enableActiveFill: true,
                  onCompleted: (value)async{
                    print(todayDate);
                    if(value==todayDate){
                      Navigator.push(context, MaterialPageRoute(builder: (context)=>MainScreen()));
                    }
                    else{
                      Alert(
                        context: context,
                        type: AlertType.error,
                        title: "Authentication Failed",
                        desc: "Please input valid date ",
                        buttons: [
                          DialogButton(
                            child: Text(
                              "Cancel",
                              style: TextStyle(color: Colors.white, fontSize: 20),
                            ),
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            width: 120,
                          )
                        ],
                      ).show();
                    }
                  },
                  cursorColor: themeColor1.withOpacity(0.8),
                  onChanged: (String value) {  },length: 4, appContext: context,
                  keyboardType: TextInputType.number,
                  pinTheme: PinTheme(
                      fieldHeight: 50,
                      fieldWidth: 50,
                      inactiveFillColor: Colors.white,
                      activeColor: Colors.white,
                      inactiveColor: Colors.white,
                      activeFillColor: Colors.white,
                      selectedFillColor: Colors.white
                  ),
                ),
              ),

            ],),
        ),
      ),
    );
  }
}
