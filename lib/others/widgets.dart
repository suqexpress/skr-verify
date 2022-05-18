import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:salesmen_app/others/style.dart';

class LoginTextField extends StatelessWidget {
  LoginTextField(
      {required this.width,
      this.label,
      this.onchange,
      this.obscureText,
      this.keyboardType});

  final double width;
  final onchange;
  final label;
  final keyboardType;
  final obscureText;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 0, vertical: 10),
      child: TextField(
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
    this.shopAssigned,
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
  final shopAssigned;
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
                  text: widget.name,
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
                          text: widget.lastVisit.toString(),
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
                          text: widget.lastTrans.toString(),
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
                          text: widget.dues.toString() == '0'
                              ? '0'
                              : widget.f
                                  .format(double.parse(widget.dues.toString())),
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
                          text: widget.outstanding.toString() == '0'
                              ? '0'
                              : widget.f.format(
                                  double.parse(widget.outstanding.toString())),
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
                    // onTap: () async {
                    //   _onSelected(index);
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
