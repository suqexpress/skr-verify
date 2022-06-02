import 'dart:async';
import 'dart:convert';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:provider/provider.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:salesmen_app/Auth/auth.dart';
import 'package:salesmen_app/model/user_model.dart';
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
  TextEditingController phoneNo =TextEditingController();
  TextEditingController password =TextEditingController();
  setLoading(bool value){
    setState(() {
      loading=value;
    });
  }
  getLogin(context)async{
    setLoading(true);
    print("+92"+password.text.substring(1));
    print(password.text);
    var response=await Auth.getLogin(phoneNo:"+92"+phoneNo.text.substring(1), password:password.text,onSuccess: (response)async{
      print("status ${response.statusCode}");
      if(response.statusCode==200){
        var data=jsonDecode(response.toString());
        print(data['success']);
        await Provider.of<UserModel>(context,listen: false).fetchData(data);
        FirebaseAuth _auth= FirebaseAuth.instance;
        _auth.verifyPhoneNumber(
            phoneNumber: "+92"+phoneNo.text.substring(1),
            timeout: Duration(seconds: 120),
            verificationCompleted: (AuthCredential credential){
            },
            verificationFailed: (FirebaseAuthException exception){
              print("OTP failed");
              setLoading(false);
              Fluttertoast.showToast(
                  msg: "OTP failed, Try again later",
                  toastLength: Toast.LENGTH_LONG,
                  gravity: ToastGravity.BOTTOM,
                  timeInSecForIosWeb: 3,
                  backgroundColor: Colors.black87,
                  textColor: Colors.white,
                  fontSize: 16.0);
              print(exception);
            },
            codeAutoRetrievalTimeout:(authException){
              Alert(
                context: context,
                type: AlertType.error,
                title: "Authentication Failed",
                desc: "Please check your number ",
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
              print(authException);
              setLoading(false);
            } ,
            codeSent: ( verificationId, [forceResendingToken]) async {
              setLoading(false);
              Navigator.push(context, MaterialPageRoute(builder: (context)=>VerificationScreen(code: verificationId,phoneNo:"+92"+password.text.substring(1) ,password: password.text,)));
            }
        );
        // Navigator.push(context, MaterialPageRoute(builder: (context)=>VerificationCodeScreen(verificationCode: "123",phoneNo: widget.phoneNumber,password: _passController.text,)));

      }
      else if(response.statusCode==401 ||response.statusCode==501){
        setLoading(false);
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
        setLoading(false);
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
      setLoading(false);
      Alert(
        context: context,
        type: AlertType.error,
        title: "Api`s not Responses",
        desc: "please try again after few Mints",
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
  Widget build(BuildContext context) {
    var width=MediaQuery.of(context).size.width;
    var height=MediaQuery.of(context).size.height;
    return Scaffold(
      body: SingleChildScrollView(
        child: Stack(
          alignment: Alignment.center,
          children:[
            Container(
            color: themeColor1.withOpacity(0.8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Container(
                  child: Image.asset('assets/illustration/login.png',width: width *0.8,height: width *0.8,),),
                Container(
                  child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(topLeft: Radius.circular(30),topRight:Radius.circular(30), )
                  ),
                  child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    SizedBox(height: 20,),
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
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
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
                          LoginTextField(width: width,label: "Enter your name",onchange: (value){},controller:phoneNo,obscureText: false,keyboardType: TextInputType.phone,),
                          LoginTextField(width: width,label: "Enter your password",onchange: (value){},controller:password ,obscureText: true,keyboardType: TextInputType.visiblePassword,),
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
                            onTap: ()=>getLogin(context),
                            child: Container(
                              margin: EdgeInsets.symmetric(vertical: 10),
                              alignment: Alignment.center,
                              padding: EdgeInsets.symmetric(vertical: 10),
                              decoration: BoxDecoration(
                                  color: themeColor1.withOpacity(0.8),
                                  borderRadius: BorderRadius.circular(7)
                              ),
                              child: Text("LOGIN NOW",style:GoogleFonts.archivo(fontSize: 20,color: Colors.white,fontWeight: FontWeight.w300, ) ),),
                          ),
                          SizedBox(height: 20,)
                        ],),
                    )
                  ],
                    ),
                    ),
                )
              ],
            ),
          ),
            loading?Container(
                color: Colors.white.withOpacity(0.5),
                width: width,
                height: height* 0.87,
                alignment: Alignment.center,
                child: Loading()):Container()
          ]
        ),
      ),
    );
  }
}

class Loading extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.only(topLeft: Radius.circular(30),topRight:Radius.circular(30), )
        ),
        child: LoadingAnimationWidget.threeArchedCircle(color: themeColor1, size:100 ));
  }
}


