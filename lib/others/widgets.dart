import 'dart:io';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:salesmen_app/others/style.dart';
import 'package:salesmen_app/screen/edit_shop/edit_shop_screen.dart';

class LoginTextField extends StatelessWidget {
  LoginTextField(
      {required this.width,
      this.label,
      this.onchange,
      this.obscureText,
      this.keyboardType,
      this.controller});

  final double width;
  final onchange;
  final label;
  final keyboardType;
  final obscureText;
  final controller;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 0, vertical: 10),
      child: TextField(
        controller: controller,
        obscureText: obscureText,
        keyboardType: keyboardType,
        onChanged: onchange,
        decoration: InputDecoration(
          labelText: label,
          labelStyle: GoogleFonts.archivo(
            color: themeColor1.withOpacity(0.8),
          ),
          contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
          focusedBorder: OutlineInputBorder(
            borderSide:
                BorderSide(color: themeColor1.withOpacity(0.8), width: 0.0),
          ),
          enabledBorder: const OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.grey, width: 0.0),
          ),
          errorBorder: const OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.red, width: 0.0),
          ),
        ),
      ),
    );
  }
}

class CustomerCard extends StatefulWidget {
  CustomerCard({
    required this.height,
    required this.width,
    required this.f,
    required this.menuButton,
    this.code,
    this.category,
    this.shopName,
    this.address,
    this.name,
    this.phoneNo,
    this.lastVisit,
    this.dues,
    this.lastTrans,
    this.outstanding,
    this.lat,
    this.long,
    required this.showLoading,
    this.image,
    this.customerData,
  });

  final image;
  final double height;
  final double width;
  final NumberFormat f;
  final List<String> menuButton;
  final code;
  final category;
  final shopName;
  final address;
  final name;
  final phoneNo;
  final lastVisit;
  final dues;
  final lastTrans;
  final outstanding;
  final lat;
  final long;
  final customerData;
  Function showLoading;

  @override
  _CustomerCardState createState() => _CustomerCardState();
}

class _CustomerCardState extends State<CustomerCard> {
  int selectedIndex = 0;
  _onSelected(int i) {
    setState(() {
      selectedIndex = i;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Colors.grey.withOpacity(0.5)),
      ),
      padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: widget.height * 0.0055,
          ),
          Container(
            //color: Colors.red,
            child: IntrinsicHeight(
              child: Row(
                children: [
                  VariableText(
                    text: widget.code.toString(),
                    fontsize: 11,
                    fontcolor: Colors.grey,
                    line_spacing: 1.4,
                    textAlign: TextAlign.start,
                    max_lines: 2,
                    weight: FontWeight.w500,
                  ),
                  VerticalDivider(
                    color: Color(0xff000000).withOpacity(0.25),
                    thickness: 1,
                  ),
                  VariableText(
                    text: widget.category.toString(),
                    fontsize: 11,
                    fontcolor: Colors.grey,
                    line_spacing: 1.4,
                    textAlign: TextAlign.start,
                    max_lines: 2,
                    weight: FontWeight.w500,
                  ),
                ],
              ),
            ),
          ),
          SizedBox(
            height: widget.height * 0.01,
          ),
          Padding(
            padding: EdgeInsets.only(right: 0.0),
            child: Container(
              height: 1,
              width: widget.width,
              color: Color(0xffE0E0E0),
            ),
          ),
          SizedBox(
            height: widget.height * 0.01,
          ),
          VariableText(
            text: widget.shopName.toString(),
            fontsize: widget.height / widget.width * 7,
            fontcolor: themeColor1,
            weight: FontWeight.w700,
            textAlign: TextAlign.start,
            max_lines: 2,
          ),
          SizedBox(
            height: widget.height * 0.0075,
          ),
          Padding(
            padding: EdgeInsets.only(right: 0.0),
            child: Container(
              height: 1,
              width: widget.width,
              color: Color(0xffE0E0E0),
            ),
          ),
          SizedBox(
            height: widget.height * 0.0075,
          ),
          SizedBox(
            height: widget.height * 0.0075,
          ),
          InkWell(
            // onTap: () {
            //   if (widget.customerData.customerinfo.isNotEmpty) {
            //     renderDeletePopup(context, widget.height,
            //         widget.width, widget.customerData);
            //   } else {
            //     Fluttertoast.showToast(
            //         msg: "No Information found..",
            //         toastLength: Toast.LENGTH_LONG);
            //   }
            // },
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Image.asset(
                  'assets/icons/home.png',
                  scale: 3.5,
                  color: Color(0xff2B2B2B),
                ),
                SizedBox(
                  width: widget.height * 0.01,
                ),
                Expanded(
                  child: VariableText(
                    text: widget.address.toString(),
                    // text:shopdetails[index].address.toString(),
                    fontsize: 11,
                    fontcolor: Colors.grey,
                    line_spacing: 1.4,
                    textAlign: TextAlign.start,
                    max_lines: 2,
                    weight: FontWeight.w500,
                  ),
                ),
                SizedBox(
                  width: widget.height * 0.01,
                ),
                Image.asset(
                  'assets/icons/more.png',
                  scale: 3,
                  color: themeColor1,
                ),
              ],
            ),
          ),
          SizedBox(
            height: widget.height * 0.008,
          ),
          Padding(
            padding: EdgeInsets.only(right: 0.0),
            child: Container(
              height: 1,
              width: widget.width,
              color: Color(0xffE0E0E0),
            ),
          ),
          SizedBox(
            height: widget.height * 0.008,
          ),
          Row(
            children: [
              Image.asset(
                'assets/icons/person.png',
                scale: 2.5,
                color: Color(0xff2B2B2B),
              ),
              SizedBox(
                width: widget.height * 0.01,
              ),
              Padding(
                padding: EdgeInsets.only(top: 4.0),
                child: VariableText(
                  text: widget.name.toString().length>14?widget.name.toString().substring(0,14):widget.name.toString(),
                  // text: widget
                  //     .customerData.customerContactPersonName
                  //     .toString(),
                  // text: shopdetails[index].ownerName,
                  fontsize: 11,
                  fontcolor: Colors.grey,
                  max_lines: 1,
                  weight: FontWeight.w500,
                  textAlign: TextAlign.start,
                ),
              ),
              Spacer(),
              Spacer(),
              Image.asset(
                'assets/icons/contact.png',
                scale: 2.5,
                color: Color(0xff2B2B2B),
              ),
              SizedBox(
                width: widget.height * 0.01,
              ),
              Padding(
                padding: EdgeInsets.only(top: 2.0),
                child: VariableText(
                  text: widget.phoneNo.toString(),
                  // text: widget.customerData.customerContactNumber
                  //     .toString(),
                  // text:shopdetails[index].ownerContact,
                  fontsize: 11,
                  fontcolor: Colors.grey,

                  max_lines: 3,
                  weight: FontWeight.w500,
                ),
              ),
              Spacer(),
            ],
          ),
          SizedBox(
            height: widget.height * 0.008,
          ),
          Padding(
            padding: EdgeInsets.only(right: 0.0),
            child: Container(
              height: 1,
              width: widget.width,
              color: Color(0xffE0E0E0),
            ),
          ),
          SizedBox(
            height: widget.height * 0.008,
          ),
          Row(
            children: [
              Expanded(
                flex: 12,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        VariableText(
                          //text: 'Muhammad Ali',
                          text: 'Last Visit: ',
                          // text: shopdetails[index].ownerName,
                          fontsize: 11,
                          fontcolor: Color(0xff333333),
                          max_lines: 1,
                          weight: FontWeight.w600,
                          textAlign: TextAlign.start,
                        ),
                        Spacer(),
                        VariableText(
                          //text: 'Muhammad Ali',
                          text:"--",
                          //widget.lastVisit.toString(),
                          // widget.customerData.lastVisitDay
                          //     .toString(),
                          // text: shopdetails[index].ownerName,
                          fontsize: 11,
                          fontcolor: Colors.grey,
                          max_lines: 1,
                          weight: FontWeight.w500,
                          textAlign: TextAlign.start,
                        ),
                      ],
                    ),
                    SizedBox(
                      height: widget.height * 0.01,
                    ),
                    Row(
                      children: [
                        VariableText(
                          //text: 'Muhammad Ali',
                          text: 'Last Trans: ',
                          // text: shopdetails[index].ownerName,
                          fontsize: 11,
                          fontcolor: Color(0xff333333),
                          max_lines: 1,
                          weight: FontWeight.w600,
                          textAlign: TextAlign.start,
                        ),
                        Spacer(),
                        VariableText(
                          //text: 'Muhammad Ali',
                          text:"--",
                          //widget.lastTrans.toString(),
                          // widget.customerData.lastTransDay
                          //     .toString(),
                          // text: shopdetails[index].ownerName,
                          fontsize: 11,
                          fontcolor: Colors.grey,
                          max_lines: 1,
                          weight: FontWeight.w500,
                          textAlign: TextAlign.start,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Spacer(),
              Spacer(),
              Expanded(
                flex: 12,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        VariableText(
                          //text: 'Muhammad Ali',
                          text: 'Dues: ',
                          // text: shopdetails[index].ownerName,
                          fontsize: 11,
                          fontcolor: Color(0xff333333),
                          max_lines: 1,
                          weight: FontWeight.w600,
                          textAlign: TextAlign.start,
                        ),
                        Spacer(),
                        VariableText(
                          //text: 'Muhammad Ali',
                          text: "--",
                          //widget.dues.toString() == '0'
                              // ? '0'
                              // : widget.f
                              //     .format(double.parse(widget.dues.toString())),
                          // text: shopdetails[index].ownerName,
                          fontsize: 11,
                          fontcolor: Colors.grey,
                          max_lines: 1,
                          weight: FontWeight.w500,
                          textAlign: TextAlign.start,
                        ),
                      ],
                    ),
                    SizedBox(
                      height: widget.height * 0.01,
                    ),
                    Row(
                      children: [
                        VariableText(
                          //text: 'Muhammad Ali',
                          text: 'Outstanding: ',
                          // text: shopdetails[index].ownerName,
                          fontsize: 11,
                          fontcolor: Color(0xff333333),
                          max_lines: 1,
                          weight: FontWeight.w600,
                          textAlign: TextAlign.start,
                        ),
                        Spacer(),
                        VariableText(
                          //text: 'Muhammad Ali',
                          text:"--",
                          // widget.outstanding.toString() == '0'
                          //     ? '0'
                          //     : widget.f.format(
                          //         double.parse(widget.outstanding.toString())),
                          // text: shopdetails[index].ownerName,
                          fontsize: 11,
                          fontcolor: Colors.grey,
                          max_lines: 1,
                          weight: FontWeight.w500,
                          textAlign: TextAlign.start,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Spacer(),
            ],
          ),
          SizedBox(
            height: widget.height * 0.008,
          ),
          Padding(
            padding: EdgeInsets.only(right: 0.0),
            child: Container(
              height: 1,
              width: widget.width,
              color: Color(0xffE0E0E0),
            ),
          ),
          SizedBox(
            height: widget.height * 0.008,
          ),
          Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(widget.menuButton.length, (index) {
                return InkWell(
                     onTap: () async {
                       _onSelected(index);
                        if(index==1){
                          Navigator.push(context, MaterialPageRoute(builder: (context)=>EditShopScreen(customer: widget.customerData,)));
                        }
                     },
                    //   // if (index == 1) {
                    //   //   if (templat == null) {
                    //   //     Fluttertoast.showToast(
                    //   //         msg: 'Please Enable Your Location',
                    //   //         toastLength: Toast.LENGTH_SHORT,
                    //   //         backgroundColor: Colors.black87,
                    //   //         textColor: Colors.white,
                    //   //         fontSize: 16.0);
                    //   //     //checkAndGetLocation();
                    //   //   } else {
                    //   //     if(widget.shopAssigned == 'Yes'){
                    //   //       // if (double.parse(userData.usercashReceive) >=
                    //   //       //     double.parse(userData.usercashLimit) ||
                    //   //       //     double.parse(userData.usercashReceive) < 0) {
                    //   //       //   limitReachedPopup(
                    //   //       //       context: context,
                    //   //       //       height: widget.height,
                    //   //       //       width: widget.width);
                    //   //
                    //   //         ///for testing
                    //   //         /*widget.showLoading(true);
                    //   //         await PostEmployeeVisit(
                    //   //             customerCode:
                    //   //                 widget.customerData.customerCode,
                    //   //             purpose: 'Check In',
                    //   //             lat: templat.toString(),
                    //   //             long: templong.toString(),
                    //   //             customerData: widget.customerData);
                    //   //         widget.showLoading(false);*/
                    //   //       } else
                    //   if (index == 1) {
                    //     widget.showLoading(true);
                    //     // await PostEmployeeVisit(
                    //     //     customerCode:
                    //     //     widget.customerData.customerCode,
                    //     //     purpose: 'Check In',
                    //     //     lat: templat.toString(),
                    //     //     long: templong.toString(),
                    //     //     customerData: widget.customerData);
                    //     if (widget.shopAssigned == "Yes") {
                    //       Provider.of<RetrunCartModel>(context, listen: false)
                    //           .retruncreateCart();
                    //       Navigator.push(
                    //           context,
                    //           MaterialPageRoute(
                    //               builder: (context) => CheckIn(
                    //                 code: widget.code,
                    //                 name: widget.shopName,
                    //                 image: widget.image,
                    //                 customerData: widget.customerData,
                    //               )));
                    //     } else {
                    //       Fluttertoast.showToast(
                    //           msg: 'Shop not Assigned',
                    //           toastLength: Toast.LENGTH_SHORT,
                    //           backgroundColor: Colors.black87,
                    //           textColor: Colors.white,
                    //           fontSize: 16.0);
                    //     }
                    //     widget.showLoading(false);
                    //   } else if (index == 0) {
                    //     ///Launch Map
                    //     if (widget.lat == null) {
                    //       Fluttertoast.showToast(
                    //           msg: "Shop location not found",
                    //           toastLength: Toast.LENGTH_SHORT,
                    //           gravity: ToastGravity.BOTTOM,
                    //           timeInSecForIosWeb: 3,
                    //           backgroundColor: Colors.black87,
                    //           textColor: Colors.white,
                    //           fontSize: 16.0);
                    //     } else {
                    //       if (await MapLauncher.isMapAvailable(MapType.google)) {
                    //         await MapLauncher.showMarker(
                    //           mapType: MapType.google,
                    //           coords: Coords(widget.lat, widget.long),
                    //           title: widget.shopName,
                    //           description: widget.address,
                    //         );
                    //       }
                    //       // }
                    //     }
                    //   }
                    // },
                    child: Row(
                  children: [
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 5),
                      width: widget.width * 0.4,
                      height: widget.height * 0.05,
                      decoration: BoxDecoration(
                          color: themeColor1,
                          borderRadius: BorderRadius.circular(5),
                          border: Border.all(color: themeColor1)),
                      child: Center(
                        child: VariableText(
                          text: widget.menuButton[index],
                          fontsize: 11,
                          fontcolor: Colors.white,
                          weight: FontWeight.w700,
                        ),
                      ),
                    ),
                    index==0?SizedBox(width: 15,):Container()
                  ],
                ));
              }))
        ],
      ),
    );
  }
}

class VariableText extends StatelessWidget {
  final String text;
  final Color fontcolor;
  final TextAlign textAlign;
  final FontWeight weight;
  final bool underlined, linethrough;
  final double fontsize, line_spacing, letter_spacing;
  final int max_lines;
  VariableText({
    this.text = "A",
    this.fontcolor = Colors.black,
    this.fontsize = 15,
    this.textAlign = TextAlign.center,
    this.weight = FontWeight.normal,
    this.underlined = false,
    this.line_spacing = 1,
    this.letter_spacing = 0,
    this.max_lines = 1,
    this.linethrough = false,
  });
  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      maxLines: max_lines,
      textAlign: textAlign,
      style: TextStyle(
        color: fontcolor,
        fontWeight: weight,
        height: line_spacing,
        letterSpacing: letter_spacing,
        fontSize: fontsize,
        decorationThickness: 4.0,
        decoration: underlined
            ? TextDecoration.underline
            : (linethrough ? TextDecoration.lineThrough : TextDecoration.none),
      ),
    );
  }
}
class EditTextField extends StatelessWidget {
  EditTextField({this.label,this.hintText,this.controller,this.onChange});
  final label;
  final hintText;
  final controller;
  final onChange;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 10,),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Text(label,style: TextStyle(color: themeColor1),),
          ),
          Container(
              margin: EdgeInsets.symmetric(vertical: 5),
              child: TextField(
                controller: controller,
                onChanged: onChange,
                decoration:InputDecoration(
                  contentPadding: EdgeInsets.symmetric(vertical: 7,horizontal: 15),
                  hintText: hintText,
                  border: new OutlineInputBorder(
                      borderSide: new BorderSide(color: Colors.grey)),
                  enabledBorder: new OutlineInputBorder(
                      borderSide: new BorderSide(color: themeColor1)),
                ),
              )),
        ],
      ),
    );
  }
}
class ShowDropDown extends StatelessWidget {
  const ShowDropDown({
    Key? key,
    required this.height,
    required this.value,
    required this.list,
    required this.onChange,
  }) : super(key: key);

  final double height;
  final  value;
  final List list;
  final void Function(dynamic)? onChange;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          color: Color(0xffF4F4F4),
          border: Border.all(color: themeColor1)),
      height: height * 0.065,
      child: InputDecorator(
          decoration: InputDecoration(
            enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Color(0xffEEEEEE))),
            focusedBorder:
            OutlineInputBorder(borderSide: BorderSide(color: Colors.red)),
            border:
            OutlineInputBorder(borderRadius: BorderRadius.circular(5.0)),
            contentPadding:
            EdgeInsets.only(top: 0, bottom: 0, left: 5, right: 10),
          ),
          child: DropdownButtonHideUnderline(
              child: DropdownButton<dynamic>(
                  icon: Icon(Icons.arrow_drop_down),
                  hint: Padding(
                    padding: const EdgeInsets.only(left: 8.0),
                    child: Text("Select your Category",
                        style: TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w400,
                            color: Color(
                              0xffB2B2B2,
                            ))),
                  ),
                  value: value,
                  isExpanded: true,
                  onChanged: onChange,
                  // onTap: () {},
                  // onChanged: (category) async {
                  //   setState(() {
                  //     categoryValue = category!;
                  //     //print("Selected area is: "+sel_areas.areaCode.toString());
                  //   });
                  // },
                  style: TextStyle(
                      fontSize: 14,
                      color: Color(
                        0xffC5C5C5,
                      )),
                  items:
                  list.map<DropdownMenuItem<dynamic>>((dynamic item) {
                    return DropdownMenuItem<dynamic>(
                      value: item,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 8.0),
                        child: VariableText(
                          text: item.catName ?? 'Not Found',
                          fontsize: 13,
                          weight: FontWeight.w400,
                        ),
                      ),
                    );
                  }).toList()))),
    );
  }
}


class TextFieldLabel extends StatelessWidget {
  TextFieldLabel({this.label});
  final label;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      child: Text(
        label,
        style: TextStyle(color: themeColor1),
      ),
    );
  }
}

class SaveButton extends StatelessWidget {
  SaveButton({this.onSave});
  final onSave;
  @override
  Widget build(BuildContext context) {
    return Container(
      child: InkWell(
        onTap: onSave,
        child: Container(
          margin: EdgeInsets.symmetric(vertical: 10),
          decoration: BoxDecoration(
              color: themeColor1, borderRadius: BorderRadius.circular(5)),
          padding: EdgeInsets.symmetric(vertical: 10, horizontal: 30),
          child: Center(
              child: Text(
                "Save",
                style: TextStyle(color: Colors.white, fontSize: 20),
              )),
        ),
      ),
    );
  }
}

class VerifiedButtons extends StatelessWidget {
  VerifiedButtons({this.onVerify, this.onUnVerify});
  final onVerify;
  final onUnVerify;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          InkWell(
            onTap: onVerify,
            child: Container(
              margin: EdgeInsets.symmetric(vertical: 10),
              decoration: BoxDecoration(
                  color: themeColor1, borderRadius: BorderRadius.circular(5)),
              padding: EdgeInsets.symmetric(vertical: 10, horizontal: 40),
              child: Center(
                  child: Text(
                    "Verified",
                    style: TextStyle(color: Colors.white, fontSize: 18),
                  )),
            ),
          ),
          InkWell(
            onTap: onUnVerify,
            child: Container(
              margin: EdgeInsets.symmetric(vertical: 10),
              decoration: BoxDecoration(
                  color: themeColor1, borderRadius: BorderRadius.circular(5)),
              padding: EdgeInsets.symmetric(vertical: 10, horizontal: 40),
              child: Center(
                  child: Text(
                    "Unverified",
                    style: TextStyle(color: Colors.white, fontSize: 18),
                  )),
            ),
          )
        ],
      ),
    );
  }
}

class VisiableImage extends StatefulWidget {
  VisiableImage({
    Key? key,
    required this.loading,
    required this.image,
  }) : super(key: key);

  var loading = false;
  File? image;

  @override
  _VisiableImageState createState() => _VisiableImageState();
}

class _VisiableImageState extends State<VisiableImage> {
  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: widget.loading,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(5),
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: 10),
          width: 50,
          height: 50,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
          ),
          child: widget.loading
              ? Image.file(
            File(widget.image!.path),
            fit: BoxFit.fill,
          )
              : Container(),
        ),
      ),
    );
  }
}

class UploadImages extends StatelessWidget {
  UploadImages({this.title, this.onCamera, this.onGallery});
  final title;
  final onCamera;
  final onGallery;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              child: Text(
                title,
                style: TextStyle(color: themeColor1, fontSize: 18),
              ),
            ),
          ),
          Row(
            children: [
              InkWell(
                onTap: onCamera,
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Icon(
                    Icons.camera,
                    color: Colors.grey,
                  ),
                ),
              ),
              SizedBox(
                width: 10,
              ),
              InkWell(
                onTap: onGallery,
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Icon(
                    Icons.photo,
                    color: Colors.grey,
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}

class DividerWithTextWidget extends StatelessWidget {
  final String text;
  DividerWithTextWidget({required this.text});

  @override
  Widget build(BuildContext context) {
    final line = Expanded(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            margin: EdgeInsets.only(
              left: 10,
              right: 10,
            ),
            child: Divider(height: 20, thickness: 1),
          ),
        ));

    return Row(children: [line, Text(this.text), line]);
  }
}

class LocationButton extends StatelessWidget {
  const LocationButton({
    Key? key,
    required this.width,
    required this.customerAddress,
    required this.onPressed,
  }) : super(key: key);

  final double width;
  final TextEditingController customerAddress;
  final void Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Container(
            width: width * 0.7,
            child: EditTextField(
              label: "Customer Address",
              hintText: customerAddress.text,
              // onChange: (value) {},
              controller: customerAddress,
            ),
          ),
          Container(
            margin: EdgeInsets.symmetric(vertical: 5,horizontal: 0),
            decoration: BoxDecoration(
              color: themeColor1,
              borderRadius: BorderRadius.circular(5),
            ),
            child: IconButton(onPressed: onPressed
              //   customerAddress=TextEditingController(text: actualAddress);
              // setState(() {});
              ,icon: Icon(Icons.location_searching,color: Colors.white,),),),
        ],
      ),
    );
  }
}

class ImageContainer extends StatelessWidget {
  const ImageContainer({
    Key? key,
    required this.loading1,
    required this.shopStreetImage,
    required this.onLongPress,
    required this.onGallery,
    required this.onCamera,
    required this.title,
  }) : super(key: key);

  final bool loading1;
  final File? shopStreetImage;
  final void Function()? onLongPress;
  final  Function onCamera;
  final  Function onGallery;
  final  String title;

  @override
  Widget build(BuildContext context) {
    return Container(child: Column(
      children: [
        UploadImages(
          title: title,
          onCamera: onCamera,
          onGallery: onGallery,
        ),
        InkWell(
            onLongPress:onLongPress ,
            child: VisiableImage(loading: loading1, image: shopStreetImage)),
      ],
    ),);
  }
}

