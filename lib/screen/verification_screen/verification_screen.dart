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

class VerificationScreen extends StatefulWidget {
  VerificationScreen({this.code,this.phoneNo,this.password});
  final code;
  final phoneNo;
  final password;

  @override
  State<VerificationScreen> createState() => _VerificationScreenState();
}

class _VerificationScreenState extends State<VerificationScreen> {
  goToMainPage()async{
    print("Completed");
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString("phoneNo", widget.phoneNo);
    prefs.setString("password", widget.password);
    print(prefs.getString("phoneNo"));
    Navigator.push(context, MaterialPageRoute(builder: (context)=>MainScreen()));
  }
  @override
  Widget build(BuildContext context) {
    var data= Provider.of<UserModel>(context).token;
    print("token $data");
    print(widget.code);
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
                Text("VERIFICATION",style: GoogleFonts.archivo(fontSize: 32,color: Colors.white),),
                SizedBox(height: 15,),
                Text("Please enter the verification code we send to your phone number and verify your phone number",style: GoogleFonts.archivo(fontSize: 16,color: Colors.white),textAlign: TextAlign.center,),
              ],),),
              SizedBox(height:20,),
              PinCodeTextField(
                textStyle: TextStyle(color: themeColor1.withOpacity(0.8)),
                autoDismissKeyboard: true,
                enableActiveFill: true,
                onCompleted: (value)async{
                  var _credential = PhoneAuthProvider.credential(verificationId: widget.code, smsCode: value);
                          FirebaseAuth _auth=FirebaseAuth.instance;
                            UserCredential result=await _auth.signInWithCredential(_credential).catchError((e)=>Alert(
                            context: context,
                            type: AlertType.error,
                            title: "Authentication Failed",
                            desc: "Please input valid pin",
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
                  ).show()).then((value)=>goToMainPage() );



                },
                cursorColor: themeColor1.withOpacity(0.8),
                onChanged: (String value) {  },length: 6, appContext: context,
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
              InkWell(
                onTap: ()=>Navigator.pop(context),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text("Resend Code?",style: GoogleFonts.archivo(fontSize: 18,color: Colors.white),),
                    ),
                  ],
                ),
              )
          ],),
        ),
      ),
    );
  }
}
