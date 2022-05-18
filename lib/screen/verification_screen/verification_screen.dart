import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:salesmen_app/others/style.dart';
import 'package:salesmen_app/screen/main_screeen/mainScreen.dart';

class VerificationScreen extends StatefulWidget {
  const VerificationScreen({Key? key}) : super(key: key);

  @override
  State<VerificationScreen> createState() => _VerificationScreenState();
}

class _VerificationScreenState extends State<VerificationScreen> {
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
                Text("VERIFICATION",style: GoogleFonts.archivo(fontSize: 32,color: Colors.white),),
                SizedBox(height: 15,),
                Text("Please enter the verification code we send to your phone number and verify your phone number",style: GoogleFonts.archivo(fontSize: 16,color: Colors.white),textAlign: TextAlign.center,),
              ],),),
              SizedBox(height:20,),
              PinCodeTextField(
                textStyle: TextStyle(color: themeColor1.withOpacity(0.8)),
                autoDismissKeyboard: true,
                enableActiveFill: true,
                onCompleted: (value){
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>MainScreen()));
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
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text("Resend Code?",style: GoogleFonts.archivo(fontSize: 18,color: Colors.white),),
                  ),
                ],
              )
          ],),
        ),
      ),
    );
  }
}
