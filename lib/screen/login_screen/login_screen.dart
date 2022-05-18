import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:salesmen_app/others/style.dart';
import 'package:salesmen_app/others/widgets.dart';
import 'package:salesmen_app/screen/verification_screen/verification_screen.dart';

class LoginScreen extends StatefulWidget {

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool value=true;
  bool loading=false;
  @override
  Widget build(BuildContext context) {
    var width=MediaQuery.of(context).size.width;
    var height=MediaQuery.of(context).size.height;
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          color: themeColor1.withOpacity(0.8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Container(
                height: width*0.6,
                child: Image.asset('assets/illustration/login.png',scale: 2,),),
              Stack(
                children:[ 
                  Container(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(topLeft: Radius.circular(30),topRight:Radius.circular(30), )
                  ),
                  height: width *1.2,
                  child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    SizedBox(height: 35,),
                    Container(
                        margin: EdgeInsets.symmetric(horizontal: 20),
                        padding: EdgeInsets.only(bottom: 5),
                        decoration: BoxDecoration(
                            border:Border(bottom: BorderSide(color: themeColor1.withOpacity(0.8),width: 2))
                        ),
                        child: Text("LOGIN",style: GoogleFonts.archivo(fontSize: 34,color: themeColor1.withOpacity(0.8)),)),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 15),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(top: 20,bottom: 30),
                                child: Text("Enter Your phone no and password for login",style: GoogleFonts.archivo(fontSize: 14,color: themeColor1.withOpacity(0.8),fontWeight: FontWeight.w300, ),textAlign: TextAlign.center, ),
                              ),
                            ],
                          ),
                          LoginTextField(width: width,label: "Enter your name",onchange: (value){},obscureText: false,keyboardType: TextInputType.phone,),
                          LoginTextField(width: width,label: "Enter your password",onchange: (value){},obscureText: true,keyboardType: TextInputType.visiblePassword,),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  Checkbox(
                                    activeColor: themeColor1.withOpacity(0.8),
                                    checkColor: Colors.white,
                                    value: this.value,
                                    onChanged: (bool? value) {
                                      setState(() {
                                        this.value = value!;
                                      });
                                    },
                                  ),
                                  Text("Keep me Logging",style: GoogleFonts.archivo(fontSize: 12,color: themeColor1.withOpacity(0.8),fontWeight: FontWeight.w300, ),textAlign: TextAlign.center, ),

                                ],),
                              Text("Forget password?",style: GoogleFonts.archivo(fontSize: 12,color: themeColor1.withOpacity(0.8),fontWeight: FontWeight.w300, ),textAlign: TextAlign.center, ),

                            ],),
                          InkWell(
                            onTap: (){
                              setState(() {
                                loading=true;
                              });
                              Timer(Duration(seconds: 5), (){
                                setState(() {
                                  loading=false;
                                });
                                Navigator.push(context, MaterialPageRoute(builder: (context)=>VerificationScreen()));});

                            },
                            child: Container(
                              margin: EdgeInsets.symmetric(vertical: 10),
                              alignment: Alignment.center,
                              padding: EdgeInsets.symmetric(vertical: 10),
                              decoration: BoxDecoration(
                                  color: themeColor1.withOpacity(0.8),
                                  borderRadius: BorderRadius.circular(7)
                              ),
                              child: Text("LOGIN NOW",style:GoogleFonts.archivo(fontSize: 20,color: Colors.white,fontWeight: FontWeight.w300, ) ),),
                          )
                        ],),
                    )
                  ],
                    ),
                ),
                  loading?Loading():Container()
                ]
              )
            ],
          ),
        )
      ),
    );
  }
}

class Loading extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    var width=MediaQuery.of(context).size.width;
    var height=MediaQuery.of(context).size.height;
    return Container(
      alignment: Alignment.center,
      color: themeColor1.withOpacity(0.6),
        width: width,
        height: width*1.3,
        child: LoadingAnimationWidget.threeArchedCircle(color: Colors.white.withOpacity(0.8), size:100 ));
  }
}


