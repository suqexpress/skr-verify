import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:page_indicator/page_indicator.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:salesmen_app/others/style.dart';
import 'package:salesmen_app/others/widgets.dart';
import 'package:salesmen_app/screen/edit_shop/edit_shop_details.dart';
import 'package:salesmen_app/screen/edit_shop/edit_shop_image.dart';

class EditShopScreen extends StatefulWidget {
  @override
  State<EditShopScreen> createState() => _EditShopScreenState();
}

class _EditShopScreenState extends State<EditShopScreen> {
  final ImagePicker _picker = ImagePicker();
  String firstCity = 'Karachi';
  String firstCountry = 'Pakistan';
  bool visible = false;
  var country = [
    "Afghanistan",
    "Albania",
    "Algeria",
    "Andorra",
    "Angola",
    "Antigua & Deps",
    "Argentina",
    "Armenia",
    "Australia",
    "Austria",
    "Azerbaijan",
    "Bahamas",
    "Bahrain",
    "Bangladesh",
    "Barbados",
    "Belarus",
    "Belgium",
    "Belize",
    "Benin",
    "Bhutan",
    "Bolivia",
    "Bosnia Herzegovina",
    "Botswana",
    "Brazil",
    "Brunei",
    "Bulgaria",
    "Burkina",
    "Burundi",
    "Cambodia",
    "Cameroon",
    "Canada",
    "Cape Verde",
    "Central African Rep",
    "Chad",
    "Chile",
    "China",
    "Colombia",
    "Comoros",
    "Congo",
    "Congo {Democratic Rep}",
    "Costa Rica",
    "Croatia",
    "Cuba",
    "Cyprus",
    "Czech Republic",
    "Denmark",
    "Djibouti",
    "Dominica",
    "Dominican Republic",
    "East Timor",
    "Ecuador",
    "Egypt",
    "El Salvador",
    "Equatorial Guinea",
    "Eritrea",
    "Estonia",
    "Ethiopia",
    "Fiji",
    "Finland",
    "France",
    "Gabon",
    "Gambia",
    "Georgia",
    "Germany",
    "Ghana",
    "Greece",
    "Grenada",
    "Guatemala",
    "Guinea",
    "Guinea-Bissau",
    "Guyana",
    "Haiti",
    "Honduras",
    "Hungary",
    "Iceland",
    "India",
    "Indonesia",
    "Iran",
    "Iraq",
    "Ireland {Republic}",
    "Israel",
    "Italy",
    "Ivory Coast",
    "Jamaica",
    "Japan",
    "Jordan",
    "Kazakhstan",
    "Kenya",
    "Kiribati",
    "Korea North",
    "Korea South",
    "Kosovo",
    "Kuwait",
    "Kyrgyzstan",
    "Laos",
    "Latvia",
    "Lebanon",
    "Lesotho",
    "Liberia",
    "Libya",
    "Liechtenstein",
    "Lithuania",
    "Luxembourg",
    "Macedonia",
    "Madagascar",
    "Malawi",
    "Malaysia",
    "Maldives",
    "Mali",
    "Malta",
    "Marshall Islands",
    "Mauritania",
    "Mauritius",
    "Mexico",
    "Micronesia",
    "Moldova",
    "Monaco",
    "Mongolia",
    "Montenegro",
    "Morocco",
    "Mozambique",
    "Myanmar, {Burma}",
    "Namibia",
    "Nauru",
    "Nepal",
    "Netherlands",
    "New Zealand",
    "Nicaragua",
    "Niger",
    "Nigeria",
    "Norway",
    "Oman",
    "Pakistan",
    "Palau",
    "Panama",
    "Papua New Guinea",
    "Paraguay",
    "Peru",
    "Philippines",
    "Poland",
    "Portugal",
    "Qatar",
    "Romania",
    "Russian Federation",
    "Rwanda",
    "St Kitts & Nevis",
    "St Lucia",
    "Saint Vincent & the Grenadines",
    "Samoa",
    "San Marino",
    "Sao Tome & Principe",
    "Saudi Arabia",
    "Senegal",
    "Serbia",
    "Seychelles",
    "Sierra Leone",
    "Singapore",
    "Slovakia",
    "Slovenia",
    "Solomon Islands",
    "Somalia",
    "South Africa",
    "South Sudan",
    "Spain",
    "Sri Lanka",
    "Sudan",
    "Suriname",
    "Swaziland",
    "Sweden",
    "Switzerland",
    "Syria",
    "Taiwan",
    "Tajikistan",
    "Tanzania",
    "Thailand",
    "Togo",
    "Tonga",
    "Trinidad & Tobago",
    "Tunisia",
    "Turkey",
    "Turkmenistan",
    "Tuvalu",
    "Uganda",
    "Ukraine",
    "United Arab Emirates",
    "United Kingdom",
    "United States",
    "Uruguay",
    "Uzbekistan",
    "Vanuatu",
    "Vatican City",
    "Venezuela",
    "Vietnam",
    "Yemen",
    "Zambia",
    "Zimbabwe"
  ];
  var city = [
    "Abbottabad",
    "Ahmadpur East",
    "Bahawalnagar",
    "Bahawalpur",
    "Burewala",
    "Chakwal",
    "Charsada",
    "Chichawatni",
    "Chiniot",
    "Chishtian",
    "Dadu",
    "Daska",
    "Dera Ghazi Khan",
    "Dera Ismail Khan",
    "Faisalabad",
    "Farooka",
    "Gojra",
    "Gujranwala",
    "Gujrat",
    "Hafizabad",
    "Hyderabad",
    "Islamabad",
    "Jacobabad",
    "Jaranwala",
    "Jhelum",
    "Kamalia",
    "Kamoke",
    "Kandhkot",
    "Karachi",
    "Kasur",
    "Khairpur",
    "Khanewal",
    "Khanpur",
    "Khushab",
    "Khuzdar",
    "Kohat",
    "Kot Adu",
    "Lahore",
    "Larkana",
    "Mandi Bahauddin",
    "Mansehra",
    "Mardan",
    "Mianwali",
    "Mingora",
    "Mirpur Khas",
    "Multan",
    "Muridke",
    "Muzaffargarh",
    "Nawabshah",
    "Nowshera",
    "Okara",
    "Pakpattan",
    "Peshawar",
    "Quetta",
    "Rahim Yar Khan",
    "Rawalpindi",
    "Sadiqabad",
    "Sahiwal",
    "Sargodha",
    "Sheikhupura",
    "Shikarpur",
    "Sialkot",
    "Sukkur",
    "Swabi",
    "Tando Adam",
    "Tando Allahyar",
    "Vehari",
    "Vehari",
    "Wah Cantonment",
    "Wazirabad",
    "Add Market"
  ];
  var controller,
      controller1,
      controller2,
      controller3,
      controller4,
      controller5,
      controller6,
      controller7,
      controller8,
      controller9,
      controller10,
      controller11,
      controller12,
      controller13 = TextEditingController();
  XFile? image,image1,image2,image3,image4,image5,image6,image7,image8;
  bool loading=false,loading1=false,loading2=false,loading3=false,loading4=false,loading5=false,loading6=false,loading7=false,loading8=false;
  getImage(ImageSource source,String name)async{
    if(name=="owner"){
      var camera=await Permission.camera.request();
      var gallery=await Permission.storage.request();
      final XFile? pickedFile = await _picker.pickImage(
        source: source,
        maxWidth: 512,
        maxHeight: 512,
        imageQuality: 100,
      );
      if(pickedFile!=null){
        setState(() {
          image=pickedFile;
          loading=true;
          print(image!.path);
        });
      }
    }
    else if(name=="street"){
      var camera=await Permission.camera.request();
      var gallery=await Permission.storage.request();
      final XFile? pickedFile = await _picker.pickImage(
        source: source,
        maxWidth: 512,
        maxHeight: 512,
        imageQuality: 100,
      );
      if(pickedFile!=null){
        setState(() {
          image1=pickedFile;
          loading1=true;
          print(image1!.path);
        });
      }
    }
    else if(name=="front"){

      var camera=await Permission.camera.request();
      var gallery=await Permission.storage.request();
      final XFile? pickedFile = await _picker.pickImage(
        source: source,
        maxWidth: 512,
        maxHeight: 512,
        imageQuality: 100,
      );
      if(pickedFile!=null){
        setState(() {
          image2=pickedFile;
          loading2=true;
          print(image2!.path);
        });
      }
    }
    else if(name=="internal"){

      var camera=await Permission.camera.request();
      var gallery=await Permission.storage.request();
      final XFile? pickedFile = await _picker.pickImage(
        source: source,
        maxWidth: 512,
        maxHeight: 512,
        imageQuality: 100,
      );
      if(pickedFile!=null){
        setState(() {
          image3=pickedFile;
          loading3=true;
          print(image3!.path);
        });
      }
    }
    else if(name=="SignBoard"){

      var camera=await Permission.camera.request();
      var gallery=await Permission.storage.request();
      final XFile? pickedFile = await _picker.pickImage(
        source: source,
        maxWidth: 512,
        maxHeight: 512,
        imageQuality: 100,
      );
      if(pickedFile!=null){
        setState(() {
          image4=pickedFile;
          loading4=true;
          print(image4!.path);
        });
      }
    }
    else if(name=="cnic_front"){

      var camera=await Permission.camera.request();
      var gallery=await Permission.storage.request();
      final XFile? pickedFile = await _picker.pickImage(
        source: source,
        maxWidth: 512,
        maxHeight: 512,
        imageQuality: 100,
      );
      if(pickedFile!=null){
        setState(() {
          image5=pickedFile;
          loading5=true;
          print(image5!.path);
        });
      }
    }
    else if(name=="cnic_back"){

      var camera=await Permission.camera.request();
      var gallery=await Permission.storage.request();
      final XFile? pickedFile = await _picker.pickImage(
        source: source,
        maxWidth: 512,
        maxHeight: 512,
        imageQuality: 100,
      );
      if(pickedFile!=null){
        setState(() {
          image6=pickedFile;
          loading6=true;
          print(image6!.path);
        });
      }
    }
    else if(name=="person_1"){

      var camera=await Permission.camera.request();
      var gallery=await Permission.storage.request();
      final XFile? pickedFile = await _picker.pickImage(
        source: source,
        maxWidth: 512,
        maxHeight: 512,
        imageQuality: 100,
      );
      if(pickedFile!=null){
        setState(() {
          image7=pickedFile;
          loading7=true;
          print(image7!.path);
        });
      }
    }
    else if(name=="person_2"){

      var camera=await Permission.camera.request();
      var gallery=await Permission.storage.request();
      final XFile? pickedFile = await _picker.pickImage(
        source: source,
        maxWidth: 512,
        maxHeight: 512,
        imageQuality: 100,
      );
      if(pickedFile!=null){
        setState(() {
          image8=pickedFile;
          loading8=true;
          print(image8!.path);
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: themeColor1,
          title: Text(
            "Edit Shop",
            style: TextStyle(color: Colors.white),
          ),
          leading: IconButton(
            onPressed: () => Navigator.pop(context),
            icon: Icon(
              Icons.arrow_back,
              color: Colors.white,
            ),
          ),
        ),
        body: SingleChildScrollView(
            child: Container(
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                    margin: EdgeInsets.symmetric(vertical: 10),
                    decoration: BoxDecoration(
                        color: themeColor1,
                        borderRadius: BorderRadius.circular(5)),
                    padding: EdgeInsets.symmetric(vertical: 10, horizontal: 40),
                    child: Center(
                        child: Text(
                      "Verified",
                      style: TextStyle(color: Colors.white, fontSize: 18),
                    )),
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(vertical: 10),
                    decoration: BoxDecoration(
                        color: themeColor1,
                        borderRadius: BorderRadius.circular(5)),
                    padding: EdgeInsets.symmetric(vertical: 10, horizontal: 40),
                    child: Center(
                        child: Text(
                      "Unverified",
                      style: TextStyle(color: Colors.white, fontSize: 18),
                    )),
                  )
                ],
              ),
              Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    DividerWithTextWidget(text: "Shop"),
                    UploadImages(
                      title: "Shop Street",
                      onCamera: () => getImage(ImageSource.camera,"street"),
                      onGallery: () => getImage(ImageSource.gallery,"street"),
                    ),
                    InkWell(
                        onLongPress: (){
                          setState(() {
                            loading1=false;
                            image1=null;
                          });
                        },
                        child: VisiableImage(loading: loading1, image: image1)),
                    UploadImages(
                      title: "Shop Front",
                      onCamera: () => getImage(ImageSource.camera,"front"),
                      onGallery: () => getImage(ImageSource.gallery,"front"),
                    ),
                    InkWell(
                        onLongPress: (){
                          setState(() {
                            loading2=false;
                            image2=null;
                          });
                        },
                        child: VisiableImage(loading: loading2, image: image2)),
                    UploadImages(
                      title: "Shop Internal",
                      onCamera: () => getImage(ImageSource.camera,"internal"),
                      onGallery: () => getImage(ImageSource.gallery,"internal"),
                    ),
                    InkWell(
                        onLongPress: (){
                          setState(() {
                            loading3=false;
                            image3=null;
                          });
                        },
                        child: VisiableImage(loading: loading3, image: image3)),
                    UploadImages(
                      title: "Shop Sign Board",
                      onCamera: () => getImage(ImageSource.camera,"signboard"),
                      onGallery: () => getImage(ImageSource.gallery,"signboard"),
                    ),
                    InkWell(
                        onLongPress: (){
                          setState(() {
                            loading4=false;
                            image4=null;
                          });
                        },
                        child: VisiableImage(loading: loading4, image: image4)),
                    DividerWithTextWidget(text: "Owner"),
                    UploadImages(
                      title: "Owner",
                      onCamera: () => getImage(ImageSource.camera,"owner"),
                      onGallery: () => getImage(ImageSource.gallery,"owner"),
                    ),
                    InkWell(
                        onLongPress: (){
                          setState(() {
                            loading=false;
                            image=null;
                          });
                        },
                        child: VisiableImage(loading: loading, image: image)),
                    UploadImages(
                      title: "CNIC Front",
                      onCamera: () => getImage(ImageSource.camera,"cinc_front"),
                      onGallery: () => getImage(ImageSource.gallery,"cinc_front"),
                    ),
                    InkWell(
                        onLongPress: (){
                          setState(() {
                            loading5=false;
                            image5=null;
                          });
                        },
                        child: VisiableImage(loading: loading5, image: image5)),
                    UploadImages(
                      title: "CNIC Back",
                      onCamera: () => getImage(ImageSource.camera,"cnic_back"),
                      onGallery: () => getImage(ImageSource.gallery,"cnic_back"),
                    ),
                    InkWell(
                        onLongPress: (){
                          setState(() {
                            loading6=false;
                            image6=null;
                          });
                        },
                        child: VisiableImage(loading: loading6, image: image6)),

                    // UploadImageCard(
                    //   title: "Owner",
                    //   onCamera:()=> getImage(ImageSource.camera),
                    //   onGallery: ()=> getImage(ImageSource.gallery),
                    // ),
                    /* UploadImageCard(
                      title: "Shop Street",
                      onCamera:()=> getImage(ImageSource.camera),
                      onGallery: ()=> getImage(ImageSource.gallery),
                    ),
                    UploadImageCard(
                      title: "Shop Front",
                      onCamera:()=> getImage(ImageSource.camera),
                      onGallery: ()=> getImage(ImageSource.gallery),
                    ),
                    UploadImageCard(
                      title: "Shop Internal",
                      onCamera:()=> getImage(ImageSource.camera),
                      onGallery: ()=> getImage(ImageSource.gallery),
                    ),
                    UploadImageCard(
                      title: "Shop Sign Board",
                      onCamera:()=> getImage(ImageSource.camera),
                      onGallery: ()=> getImage(ImageSource.gallery),
                    ),
                    UploadImageCard(
                      title: "CINC Front",
                      onCamera:()=> getImage(ImageSource.camera),
                      onGallery: ()=> getImage(ImageSource.gallery),
                    ),
                    UploadImageCard(
                      title: "CNIC Back",
                      onCamera:()=> getImage(ImageSource.camera),
                      onGallery: ()=> getImage(ImageSource.gallery),
                    ),
                    UploadImageCard(
                      title: "Person 2",
                      onCamera:()=> getImage(ImageSource.camera),
                      onGallery: ()=> getImage(ImageSource.gallery),
                    ),
                    UploadImageCard(
                      title: "Person 3",
                      onCamera:()=> getImage(ImageSource.camera),
                      onGallery: ()=> getImage(ImageSource.gallery),
                    ),
                  ],
                ),
              ),*/   DividerWithTextWidget(text: "Customer"),
                    EditTextField(
                      label: "Customer Code",
                      hintText: "00008",
                      onChange: (value) {},
                      controller: controller,
                    ),
                    EditTextField(
                      label: "Customer Shop",
                      hintText: "Hadi Autos",
                      onChange: (value) {},
                      controller: controller1,
                    ),
                    EditTextField(
                      label: "Category",
                      hintText: "1",
                      onChange: (value) {},
                      controller: controller2,
                    ),
              DividerWithTextWidget(text: "Owner"),

          EditTextField(
                      label: "Owner Name",
                      hintText: "Sami Fahim,",
                      onChange: (value) {},
                      controller: controller3,
                    ),
                    EditTextField(
                      label: "Owner Number",
                      hintText: "+921234567890",
                      onChange: (value) {},
                      controller: controller4,
                    ),
                    EditTextField(
                      label: "Owner CNIC",
                      hintText: "42000 456987412",
                      onChange: (value) {},
                      controller: controller5,
                    ),
                    EditTextField(
                      label: "CNIC EXPIRE DATE",
                      hintText: "12-04-1998",
                      onChange: (value) {},
                      controller: controller6,
                    ),
                    DividerWithTextWidget(text: "Address"),
                    EditTextField(
                      label: "Customer Address",
                      hintText: "Pakistan Sindh Karachi",
                      onChange: (value) {},
                      controller: controller7,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 5),
                      child: Text(
                        "Country",
                        style: TextStyle(color: themeColor1),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.symmetric(vertical: 0, horizontal: 0),
                      padding:
                          EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          border: Border.all(color: themeColor1)),
                      child: DropdownButton(
                        isDense: true,
                        underline: Container(),
                        isExpanded: true,
                        value: firstCountry,
                        icon: const Icon(Icons.keyboard_arrow_down),
                        items: country.map((String items) {
                          return DropdownMenuItem(
                            value: items,
                            child: Text(items),
                          );
                        }).toList(),
                        onChanged: (String? newValue) {
                          setState(() {
                            firstCountry = newValue!;
                          });
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 5),
                      child: Text(
                        "Province",
                        style: TextStyle(color: themeColor1),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.symmetric(vertical: 0, horizontal: 0),
                      padding:
                          EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          border: Border.all(color: themeColor1)),
                      child: DropdownButton(
                        isDense: true,
                        underline: Container(),
                        isExpanded: true,
                        value: firstCity,
                        icon: const Icon(Icons.keyboard_arrow_down),
                        items: city.map((String items) {
                          return DropdownMenuItem(
                            value: items,
                            child: Text(items),
                          );
                        }).toList(),
                        onChanged: (String? newValue) {
                          setState(() {
                            firstCity = newValue!;
                          });
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 5),
                      child: Text(
                        "City",
                        style: TextStyle(color: themeColor1),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.symmetric(vertical: 0, horizontal: 0),
                      padding:
                          EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          border: Border.all(color: themeColor1)),
                      child: DropdownButton(
                        isDense: true,
                        underline: Container(),
                        isExpanded: true,
                        value: firstCity,
                        icon: const Icon(Icons.keyboard_arrow_down),
                        items: city.map((String items) {
                          return DropdownMenuItem(
                            value: items,
                            child: Text(items),
                          );
                        }).toList(),
                        onChanged: (String? newValue) {
                          setState(() {
                            firstCity = newValue!;
                          });
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 5),
                      child: Text(
                        "Area",
                        style: TextStyle(color: themeColor1),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.symmetric(vertical: 0, horizontal: 0),
                      padding:
                          EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          border: Border.all(color: themeColor1)),
                      child: DropdownButton(
                        isDense: true,
                        underline: Container(),
                        isExpanded: true,
                        value: firstCity,
                        icon: const Icon(Icons.keyboard_arrow_down),
                        items: city.map((String items) {
                          return DropdownMenuItem(
                            value: items,
                            child: Text(items),
                          );
                        }).toList(),
                        onChanged: (String? newValue) {
                          setState(() {
                            firstCity = newValue!;
                          });
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 5),
                      child: Text(
                        "Market",
                        style: TextStyle(color: themeColor1),
                      ),
                    ),
                    Row(
                      children: [
                        Flexible(
                          child: Container(
                            margin: EdgeInsets.symmetric(
                                vertical: 0, horizontal: 0),
                            padding: EdgeInsets.symmetric(
                                vertical: 10, horizontal: 10),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5),
                                border: Border.all(color: themeColor1)),
                            child: DropdownButton(
                              isDense: true,
                              underline: Container(),
                              isExpanded: true,
                              value: firstCity,
                              icon: const Icon(Icons.keyboard_arrow_down),
                              items: city.map((String items) {
                                return DropdownMenuItem(
                                  value: items,
                                  child: Text(items),
                                );
                              }).toList(),
                              onChanged: (String? newValue) {
                                setState(() {
                                  firstCity = newValue!;
                                });
                              },
                            ),
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            setState(() {
                              visible = visible ? false : true;
                            });
                          },
                          child: Container(
                            margin: EdgeInsets.symmetric(
                                vertical: 10, horizontal: 10),
                            decoration: BoxDecoration(
                                color: themeColor1,
                                borderRadius: BorderRadius.circular(5)),
                            padding: EdgeInsets.symmetric(
                                vertical: 15, horizontal: 20),
                            child: Center(
                                child: Text(
                              "Add Market",
                              style:
                                  TextStyle(color: Colors.white, fontSize: 15),
                            )),
                          ),
                        )
                      ],
                    ),
                    Visibility(
                      visible: visible,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Flexible(
                              child: EditTextField(
                            label: "Type Market Name",
                            hintText: "Market Name",
                            onChange: (value) {},
                            controller: controller8,
                          )),
                          InkWell(
                            onTap: () {
                              setState(() {
                                visible = visible ? false : true;
                              });
                            },
                            child: Container(
                              margin: EdgeInsets.symmetric(
                                  vertical: 5, horizontal: 10),
                              decoration: BoxDecoration(
                                  color: themeColor1,
                                  borderRadius: BorderRadius.circular(5)),
                              padding: EdgeInsets.symmetric(
                                  vertical: 15, horizontal: 20),
                              child: Center(
                                  child: Text(
                                "ADD",
                                style: TextStyle(
                                    color: Colors.white, fontSize: 15),
                              )),
                            ),
                          )
                        ],
                      ),
                    ),
                    DividerWithTextWidget(text: "Second Contact person"),
                    UploadImages(
                      title: "Second Person",
                      onCamera: () => getImage(ImageSource.camera,"person_1"),
                      onGallery: () => getImage(ImageSource.gallery,"person_1"),
                    ),
                    InkWell(
                        onLongPress: (){
                          setState(() {
                            loading7=false;
                            image7=null;
                          });
                        },
                        child: VisiableImage(loading: loading7, image: image7)),
                    EditTextField(
                      label: "Second Contact Person Name",
                      hintText: "Altaf",
                      onChange: (value) {},
                      controller: controller9,
                    ),
                    EditTextField(
                      label: "Second Contact person Number",
                      hintText: "+92312345678",
                      onChange: (value) {},
                      controller: controller10,
                    ),
                    DividerWithTextWidget(text: "Third Contact person"),
                    UploadImages(
                      title: "Thrid person",
                      onCamera: () => getImage(ImageSource.camera,"person_2"),
                      onGallery: () => getImage(ImageSource.gallery,"person_2"),
                    ),
                    InkWell(
                        onLongPress: (){
                          setState(() {
                            loading8=false;
                            image8=null;
                          });
                        },
                        child: VisiableImage(loading: loading8, image: image8)),
                    EditTextField(
                      label: "Third Contact Person Name",
                      hintText: "Altaf",
                      onChange: (value) {},
                      controller: controller11,
                    ),
                    EditTextField(
                      label: "ThirdContact person Number",
                      hintText: "+92312345678",
                      onChange: (value) {},
                      controller: controller12,
                    ),
                    SizedBox(height: 10,),
                    Container(
                      margin: EdgeInsets.symmetric(vertical: 10),
                      decoration: BoxDecoration(
                          color: themeColor1,
                          borderRadius: BorderRadius.circular(5)),
                      padding:
                          EdgeInsets.symmetric(vertical: 10, horizontal: 30),
                      child: Center(
                          child: Text(
                        "Save",
                        style: TextStyle(color: Colors.white, fontSize: 20),
                      )),
                    )
                  ],
                ),
              )
            ],
          ),
        )));
  }
}

class VisiableImage extends StatefulWidget {
   VisiableImage({
    Key? key,
    required this.loading,
    required this.image,
  }) : super(key: key);

   var loading=false;
   XFile? image;

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
          child:widget.loading?Image.file(File(widget.image!.path),fit: BoxFit.fill,):Container(),
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
              padding:
                  const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
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
            margin: EdgeInsets.only(left: 10, right: 10,),
            child: Divider(height: 20, thickness: 1),
          ),
        ));

    return Row(children: [line, Text(this.text), line]);
  }
}