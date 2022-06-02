import 'dart:io';
import 'package:dio/dio.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:page_indicator/page_indicator.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:salesmen_app/model/AreaModel.dart';
import 'package:salesmen_app/model/cityModel.dart';
import 'package:salesmen_app/model/countryModel.dart';
import 'package:salesmen_app/model/customerModel.dart';
import 'package:salesmen_app/model/marketModel.dart';
import 'package:salesmen_app/model/provincesModel.dart';
import 'package:salesmen_app/others/style.dart';
import 'package:salesmen_app/others/widgets.dart';
import 'package:salesmen_app/screen/edit_shop/edit_shop_details.dart';
import 'package:salesmen_app/screen/edit_shop/edit_shop_image.dart';
import 'package:salesmen_app/screen/login_screen/login_screen.dart';

class EditShopScreen extends StatefulWidget {
  EditShopScreen({required this.customer});
  CustomerModel customer;
  @override
  State<EditShopScreen> createState() => _EditShopScreenState();
}

class _EditShopScreenState extends State<EditShopScreen> {
  final ImagePicker _picker = ImagePicker();
  String firstCity = 'Karachi';
  String firstCountry = 'Pakistan';
  bool isLoading=false;
  bool visible = false;
  var customerCode,
      shopName,
      category,
      ownerName,
      ownerNo,
      ownerCNIC,
      expireDateCNIC,
      customerAddress,
      person2,
      phoneNo2,
      person3,
      phoneNo3,
      marketsController = TextEditingController();
  XFile? image,image1,image2,image3,image4,image5,image6,image7,image8;
  bool loading=false,loading1=false,loading2=false,loading3=false,loading4=false,loading5=false,loading6=false,loading7=false,loading8=false;
  List<CountryModel> countries=[];
  List<ProvincesModel> sates=[];
  List<CityModel> cities=[];
  List<AreaModel>areas=[];
  List<MarketModel>markets=[];
  CountryModel countryValue=CountryModel();
   ProvincesModel stateValue=ProvincesModel();
   CityModel cityValue=CityModel();
   AreaModel areaValue=AreaModel();
   MarketModel marketValue=MarketModel();
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
    else if(name=="signboard"){

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
    else if(name=="cinc_front"){

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
  getCountry()async{
    setLoading(true);
    var dio=Dio();
    var response=await dio.get("https://erp.suqexpress.com/api/country");
    for(var country in response.data['data']){
      countries.add(CountryModel.fromJson(country));
    }
    countryValue=countries[0];
    getState(countries[0].id.toString());
  }
  getState(String countryId)async{
    setLoading(true);
    sates.clear();
    var dio=Dio();
    var response1=await dio.get("https://erp.suqexpress.com/api/state/$countryId}");
    for (var state in response1.data['data']){
      sates.add(ProvincesModel.fromJson(state));
    }
    stateValue=sates[0];
    getCity(sates[0].id.toString());
  }
  getCity(String id)async{
    setLoading(true);
    cities.clear();
    var dio=Dio();
    var response2=await dio.get("https://erp.suqexpress.com/api/city/$id");
    for (var city in response2.data['data']){
      cities.add(CityModel.fromJson(city));
    }
    cityValue=cities[0];
    getArea(cities[0].id.toString());
  }
  getArea(String id)async{
    setLoading(true);
    areas.clear();
    var dio=Dio();
    var response3=await dio.get("https://erp.suqexpress.com/api/area/$id");
    for(var area in response3.data['data']){
      areas.add(AreaModel.fromJson(area));
    }
    areaValue=areas[0];
    getMarket(areas[0].id.toString());
  }
  getMarket(String id)async{
    setLoading(true);
    markets.clear();
    var dio=Dio();
    var response4=await dio.get("https://erp.suqexpress.com/api/market/$id");
    if(response4.data!=null) {
      for (var market in response4.data['data']) {
        markets.add(MarketModel.fromJson(market));
      }
      marketValue = markets[0];
    }
      setLoading(false);
  }
  setLoading(bool value){
    setState(() {
      isLoading=value;
    });
  }
  @override
  void initState() {
    getCountry();
    super.initState();
  }
  getMarketList(String name,int areaId)async{
    markets.clear();
    setLoading(true);
    var dio=Dio();
    FormData formData = new FormData.fromMap({
      'name': name,
      'area_id': areaId
    });
    var response = await dio.post("https://erp.suqexpress.com/api/market", data: formData,
      options: Options(
        contentType: "application/json",
      ),
    ).then((value) =>   Alert(
      context: context,
      type: AlertType.success,
      title: "Market Successfully Added",
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
    ).show()).onError((error, stackTrace) =>   Alert(
      context: context,
      type: AlertType.error,
      title: "Edit Fail",
      desc: "Please check internet ",
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
    ).show());
    visible = visible ? false : true;
    var response4=await dio.get("https://erp.suqexpress.com/api/market/$areaId");
    for(var market in response4.data['data']){
      markets.add(MarketModel.fromJson(market));
    }
    marketValue=markets[0];
    setLoading(false);
  }
  @override
  Widget build(BuildContext context) {
    var media=MediaQuery.of(context);
    var width=media.size.width;
    var height=media.size.height;
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
            child: Stack(
              children: [
                isLoading?Container(
                    color: Colors.white.withOpacity(0.5),
                    width: width,
                    height: height* 0.87,
                    alignment: Alignment.center,
                    child: Loading()):Container(
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      VerifiedButton(onVerify: (){},onUnVerify: (){},),
                      Container(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              child: Column(children: [
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
                                    child: VisiableImage(loading: loading6, image: image6))
                              ],),
                            ),
                            DividerWithTextWidget(text: "Customer"),
                            EditTextField(
                              label: "Customer Code",
                              hintText: widget.customer.custOldCode.toString(),
                              onChange: (value) {
                              print(customerCode.text);
                                },
                              controller: customerCode,
                            ),
                            EditTextField(
                              label: "Customer Shop",
                              hintText: widget.customer.userData!.firstName,
                              onChange: (value) {},
                              controller: shopName,
                            ),
                            EditTextField(
                              label: "Category",
                              hintText: widget.customer.custOldCode,
                              onChange: (value) {},
                              controller: category,
                            ),
                            DividerWithTextWidget(text: "Owner"),

                            EditTextField(
                              label: "Owner Name",
                              hintText: widget.customer.custPrimName,
                              onChange: (value) {},
                              controller: ownerName,
                            ),
                            EditTextField(
                              label: "Owner Number",
                              hintText: widget.customer.custPrimNb,
                              onChange: (value) {},
                              controller: ownerNo,
                            ),
                            EditTextField(
                              label: "Owner CNIC",
                              hintText: widget.customer.cnic,
                              onChange: (value) {

                              },
                              controller: ownerCNIC,
                            ),
                            EditTextField(
                              label: "CNIC EXPIRE DATE",
                              hintText: widget.customer.cnicExp,
                              onChange: (value) {},
                              controller: expireDateCNIC,
                            ),
                            DividerWithTextWidget(text: "Address"),
                            EditTextField(
                              label: "Customer Address",
                              hintText: widget.customer.custAddress,
                              onChange: (value) {},
                              controller: customerAddress,
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
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5),
                                  color: Color(0xffF4F4F4),
                                  border: Border.all(color: themeColor1)
                              ),
                              height: height * 0.065,
                              child: InputDecorator(
                                  decoration: InputDecoration(
                                    enabledBorder: OutlineInputBorder(
                                        borderSide: BorderSide(color:Color(0xffEEEEEE))
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                        borderSide: BorderSide(color: Colors.red)),
                                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(5.0)),

                                    contentPadding: EdgeInsets.only(top: 0, bottom: 0, left: 5,right: 10),
                                  ),

                                  child:
                                  DropdownButtonHideUnderline(
                                      child: DropdownButton<CountryModel>(
                                          icon:Icon(Icons.arrow_drop_down),
                                          hint: Padding(

                                            padding: const EdgeInsets.only(left:8.0),
                                            child:
                                            Text("Select your Country", style: TextStyle(
                                                fontSize: 13,
                                                fontWeight: FontWeight.w400,
                                                color: Color(
                                                  0xffB2B2B2,
                                                ))),
                                          ),
                                          value: countryValue,
                                          isExpanded: true,
                                          onTap: (){

                                          },
                                          onChanged: (country) async {
                                            setState(() {
                                              countryValue=country!;

                                              //print("Selected area is: "+sel_areas.areaCode.toString());
                                            });
                                            getCountry();
                                            setState(() {

                                            });


                                          },
                                          style: TextStyle(fontSize: 14,
                                              color: Color(0xffC5C5C5, )),
                                          items:
                                          countries.map<DropdownMenuItem<CountryModel>>((CountryModel item) {
                                            return DropdownMenuItem<CountryModel>(
                                              value: item,
                                              child: Padding(
                                                padding: const EdgeInsets.only(left:8.0),
                                                child: VariableText(
                                                  text: item.name??'Not Found',
                                                  fontsize: 13,
                                                  weight: FontWeight.w400,
                                                ),
                                              ),
                                            );
                                          }).toList()
                                      ))),
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
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5),
                                  color: Color(0xffF4F4F4),
                                  border: Border.all(color: themeColor1)
                              ),
                              height: height * 0.065,
                              child: InputDecorator(
                                  decoration: InputDecoration(
                                    enabledBorder: OutlineInputBorder(
                                        borderSide: BorderSide(color:Color(0xffEEEEEE))
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                        borderSide: BorderSide(color: Colors.red)),
                                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(5.0)),

                                    contentPadding: EdgeInsets.only(top: 0, bottom: 0, left: 5,right: 10),
                                  ),

                                  child:
                                  DropdownButtonHideUnderline(
                                      child: DropdownButton<ProvincesModel>(
                                          icon:Icon(Icons.arrow_drop_down),
                                          hint: Padding(

                                            padding: const EdgeInsets.only(left:8.0),
                                            child:
                                            Text("Select your Province", style: TextStyle(
                                                fontSize: 13,
                                                fontWeight: FontWeight.w400,
                                                color: Color(
                                                  0xffB2B2B2,
                                                ))),
                                          ),
                                          value: stateValue,
                                          isExpanded: true,
                                          onTap: (){

                                          },
                                          onChanged: (state) async {
                                            setState(() {
                                              stateValue=state!;

                                              //print("Selected area is: "+sel_areas.areaCode.toString());
                                            });
                                            getCity(stateValue.id.toString());


                                          },
                                          style: TextStyle(fontSize: 14,
                                              color: Color(0xffC5C5C5, )),
                                          items:
                                          sates.map<DropdownMenuItem<ProvincesModel>>((ProvincesModel item) {
                                            return DropdownMenuItem<ProvincesModel>(
                                              value: item,
                                              child: Padding(
                                                padding: const EdgeInsets.only(left:8.0),
                                                child: VariableText(
                                                  text: item.name??'Not Found',
                                                  fontsize: 13,
                                                  weight: FontWeight.w400,
                                                ),
                                              ),
                                            );
                                          }).toList()
                                      ))),
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
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5),
                                  color: Color(0xffF4F4F4),
                                  border: Border.all(color: themeColor1)
                              ),
                              height: height * 0.065,
                              child: InputDecorator(
                                  decoration: InputDecoration(
                                    enabledBorder: OutlineInputBorder(
                                        borderSide: BorderSide(color:Color(0xffEEEEEE))
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                        borderSide: BorderSide(color: Colors.red)),
                                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(5.0)),

                                    contentPadding: EdgeInsets.only(top: 0, bottom: 0, left: 5,right: 10),
                                  ),

                                  child:
                                  DropdownButtonHideUnderline(
                                      child: DropdownButton<CityModel>(
                                          icon:Icon(Icons.arrow_drop_down),
                                          hint: Padding(

                                            padding: const EdgeInsets.only(left:8.0),
                                            child:
                                            Text("Select your Province", style: TextStyle(
                                                fontSize: 13,
                                                fontWeight: FontWeight.w400,
                                                color: Color(
                                                  0xffB2B2B2,
                                                ))),
                                          ),
                                          value: cityValue,
                                          isExpanded: true,
                                          onTap: (){

                                          },
                                          onChanged: (city) async {
                                            setState(() {
                                              cityValue=city!;
                                              getArea(cityValue.id.toString());

                                              //print("Selected area is: "+sel_areas.areaCode.toString());
                                            });


                                          },
                                          style: TextStyle(fontSize: 14,
                                              color: Color(0xffC5C5C5, )),
                                          items:
                                          cities.map<DropdownMenuItem<CityModel>>((CityModel item) {
                                            return DropdownMenuItem<CityModel>(
                                              value: item,
                                              child: Padding(
                                                padding: const EdgeInsets.only(left:8.0),
                                                child: VariableText(
                                                  text: item.name??'Not Found',
                                                  fontsize: 13,
                                                  weight: FontWeight.w400,
                                                ),
                                              ),
                                            );
                                          }).toList()
                                      ))),
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
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5),
                                  color: Color(0xffF4F4F4),
                                  border: Border.all(color: themeColor1)
                              ),
                              height: height * 0.065,
                              child: InputDecorator(
                                  decoration: InputDecoration(
                                    enabledBorder: OutlineInputBorder(
                                        borderSide: BorderSide(color:Color(0xffEEEEEE))
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                        borderSide: BorderSide(color: Colors.red)),
                                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(5.0)),

                                    contentPadding: EdgeInsets.only(top: 0, bottom: 0, left: 5,right: 10),
                                  ),

                                  child:
                                  DropdownButtonHideUnderline(
                                      child: DropdownButton<AreaModel>(
                                          icon:Icon(Icons.arrow_drop_down),
                                          hint: Padding(

                                            padding: const EdgeInsets.only(left:8.0),
                                            child:
                                            Text("Select your Province", style: TextStyle(
                                                fontSize: 13,
                                                fontWeight: FontWeight.w400,
                                                color: Color(
                                                  0xffB2B2B2,
                                                ))),
                                          ),
                                          value: areaValue,
                                          isExpanded: true,
                                          onTap: (){

                                          },
                                          onChanged: (area) async {
                                            setState(() {
                                              areaValue=area!;
                                              getMarket(areaValue.id.toString());

                                              //print("Selected area is: "+sel_areas.areaCode.toString());
                                            });


                                          },
                                          style: TextStyle(fontSize: 14,
                                              color: Color(0xffC5C5C5, )),
                                          items:
                                          areas.map<DropdownMenuItem<AreaModel>>((AreaModel item) {
                                            return DropdownMenuItem<AreaModel>(
                                              value: item,
                                              child: Padding(
                                                padding: const EdgeInsets.only(left:8.0),
                                                child: VariableText(
                                                  text: item.name??'Not Found',
                                                  fontsize: 13,
                                                  weight: FontWeight.w400,
                                                ),
                                              ),
                                            );
                                          }).toList()
                                      ))),
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
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(5),
                                        color: Color(0xffF4F4F4),
                                        border: Border.all(color: themeColor1)
                                    ),
                                    height: height * 0.065,
                                    child: InputDecorator(
                                        decoration: InputDecoration(
                                          enabledBorder: OutlineInputBorder(
                                              borderSide: BorderSide(color:Color(0xffEEEEEE))
                                          ),
                                          focusedBorder: OutlineInputBorder(
                                              borderSide: BorderSide(color: Colors.red)),
                                          border: OutlineInputBorder(borderRadius: BorderRadius.circular(5.0)),

                                          contentPadding: EdgeInsets.only(top: 0, bottom: 0, left: 5,right: 10),
                                        ),

                                        child:
                                        DropdownButtonHideUnderline(
                                            child: DropdownButton<MarketModel>(
                                                icon:Icon(Icons.arrow_drop_down),
                                                hint: Padding(

                                                  padding: const EdgeInsets.only(left:8.0),
                                                  child:
                                                  Text("Select your market", style: TextStyle(
                                                      fontSize: 13,
                                                      fontWeight: FontWeight.w400,
                                                      color: Color(
                                                        0xffB2B2B2,
                                                      ))),
                                                ),
                                                value: marketValue,
                                                isExpanded: true,
                                                onTap: (){

                                                },
                                                onChanged: (market) async {
                                                  setState(() {
                                                    marketValue=market!;

                                                    //print("Selected area is: "+sel_areas.areaCode.toString());
                                                  });


                                                },
                                                style: TextStyle(fontSize: 14,
                                                    color: Color(0xffC5C5C5, )),
                                                items:
                                                markets.map<DropdownMenuItem<MarketModel>>((MarketModel item) {
                                                  return DropdownMenuItem<MarketModel>(
                                                    value: item,
                                                    child: Padding(
                                                      padding: const EdgeInsets.only(left:8.0),
                                                      child: VariableText(
                                                        text: item.name??'Not Found',
                                                        fontsize: 13,
                                                        weight: FontWeight.w400,
                                                      ),
                                                    ),
                                                  );
                                                }).toList()
                                            ))),
                                  ),
                                ),
                                InkWell(
                                  onTap: (){
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
                                        controller: marketsController,
                                      )),
                                  InkWell(
                                    onTap: (){

                                      getMarketList(marketsController.text, areaValue.id!.toInt());
                                      marketsController.clear();
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
                              hintText: widget.customer.contactPerson2,
                              onChange: (value) {},
                              controller: person2,
                            ),
                            EditTextField(
                              label: "Second Contact person Number",
                              hintText:widget.customer.phone2,
                              onChange: (value) {},
                              controller: phoneNo2,
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
                              hintText: widget.customer.contactPerson3,
                              onChange: (value) {},
                              controller: person3,
                            ),
                            EditTextField(
                              label: "ThirdContact person Number",
                              hintText: widget.customer.phone3,
                              onChange: (value) {},
                              controller: phoneNo3,
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
                )
              ],
            )));
  }
}

class VerifiedButton extends StatelessWidget {
  VerifiedButton({this.onVerify,this.onUnVerify});
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
                  color: themeColor1,
                  borderRadius: BorderRadius.circular(5)),
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
                  color: themeColor1,
                  borderRadius: BorderRadius.circular(5)),
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