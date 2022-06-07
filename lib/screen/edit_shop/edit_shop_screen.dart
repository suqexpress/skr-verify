import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:geocoder/geocoder.dart';
import 'package:geocoder/model.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:salesmen_app/model/AreaModel.dart';
import 'package:salesmen_app/model/categoryModel.dart';
import 'package:salesmen_app/model/cityModel.dart';
import 'package:salesmen_app/model/countryModel.dart';
import 'package:salesmen_app/model/customerListModel.dart';
import 'package:salesmen_app/model/customerModel.dart';
import 'package:salesmen_app/model/marketModel.dart';
import 'package:salesmen_app/model/provincesModel.dart';
import 'package:salesmen_app/onlineDatabase/onlineDatabase.dart';
import 'package:salesmen_app/others/style.dart';
import 'package:salesmen_app/others/widgets.dart';
import 'package:salesmen_app/screen/login_screen/login_screen.dart';
import 'package:location/location.dart' as loc;
import 'package:salesmen_app/screen/main_screeen/mainScreen.dart';

class EditShopScreen extends StatefulWidget {
  EditShopScreen({required this.customer});
  CustomerListModel customer;
  @override
  State<EditShopScreen> createState() => _EditShopScreenState();
}

class _EditShopScreenState extends State<EditShopScreen> {

  final ImagePicker _picker = ImagePicker();
  String firstCity = 'Karachi';
  String firstCountry = 'Pakistan';
  bool isLoading = false;
  bool visible = false;
  String? customerCodeText,
      shopNameText,
      categoryText,
      ownerNameText,
      ownerNoText,
      ownerCNICText,
      expireDateCNICText,
      customerAddressText,
      person2Text,
      phoneNo2Text,
      person3Text,
      phoneNo3Text,
      marketsControllerText;

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
      marketsController,
      remarks,
      assignAmmount= TextEditingController();

  File? ownerImage, shopStreetImage, shopFrontImage, shopInternalImage,
      shopSignBoardImage, cincFrontImage, cnicBackImage, secondPersonImage,
      thirdPersonImage;

  bool ownerVisible = false,
      shopStreetVisible = false,
      shopFrontVisible = false,
      shopInternalVisible = false,
      shopSignBoardVisible = false,
      cnicFrontVisible = false,
      cnicbackVisible = false,
      personTwoVisiable = false,
      personThreeVisible = false;

  List<CountryModel> countries = [];
  List<ProvincesModel> states = [];
  List<CityModel> cities = [];
  List<AreaModel> areas = [];
  List<MarketModel> markets = [];
  List<CategoryModel> categories = [];

  CountryModel countryValue = CountryModel();
  ProvincesModel stateValue = ProvincesModel();
  CityModel cityValue = CityModel();
  AreaModel areaValue = AreaModel();
  CategoryModel categoryValue = CategoryModel();
  MarketModel marketValue = MarketModel();
  CustomerModel person =CustomerModel(distance: 0);

  bool _serviceEnabled = false;
  var actualAddress = "Searching....";
  late Coordinates userLatLng;
  void onStart()async{
    loc.Location location = new loc.Location();
    var _location = await location.getLocation();
    _serviceEnabled = true;
    actualAddress = "Searching....";
    userLatLng =Coordinates(_location.latitude, _location.longitude);
    print("userLatLng: " + userLatLng.toString());
    var addresses = await Geocoder.google("AIzaSyDhBNajNSwNA-38zP7HLAChc-E0TCq7jFI").findAddressesFromCoordinates(userLatLng);
    actualAddress = addresses.first.addressLine;
    print(actualAddress);
    setState(() {});
  }

  getImage(ImageSource source,String image) async {
    var camera = await Permission.camera.request();
    var gallery = await Permission.storage.request();
    final File pickedFile = await ImagePicker.pickImage(
      source: source,
      maxWidth: 512,
      maxHeight: 512,
    );
    switch(image) {
      case "owner":
        if (pickedFile != null) {
          ownerImage = pickedFile;
          ownerVisible = true;
          print(ownerImage!.path);
          setState(() {
          });
        }
        break;
      case  "cnic_front":
        if (pickedFile != null) {
          cincFrontImage = pickedFile;
          cnicFrontVisible = true;
          print(cincFrontImage!.path);
          setState(() {
          });
        }
        break;
      case "cnic_back":
        if (pickedFile != null) {
          cnicBackImage = pickedFile;
          cnicbackVisible = true;
          print(cnicBackImage!.path);
          setState(() {});
        }
        break;
      case "shop_street":
        if (pickedFile != null) {
          shopStreetImage = pickedFile;
          shopStreetVisible = true;
          print(shopStreetImage!.path);
          setState(() {});
        }
        break;
      case "shop_internal":
        if (pickedFile != null) {
          shopInternalImage = pickedFile;
          shopInternalVisible = true;
          print(shopInternalImage!.path);
          setState(() {});
        }
        break;
      case "shop_front":
        if (pickedFile != null) {
          shopFrontImage = pickedFile;
          shopFrontVisible = true;
          print(shopFrontImage!.path);
          setState(() {});
        }
        break;
      case "shop_signboard":
        if (pickedFile != null) {
          shopSignBoardImage = pickedFile;
          shopSignBoardVisible = true;
          print(shopSignBoardImage!.path);
          setState(() {});
        }
        break;
      case "person2":
        if (pickedFile != null) {
          secondPersonImage = pickedFile;
          personTwoVisiable = true;
          print(secondPersonImage!.path);
          setState(() {});
        }
        break;
      case "person3":
        if (pickedFile != null) {
          thirdPersonImage = pickedFile;
          personThreeVisible = true;
          print(thirdPersonImage!.path);
          setState(() {});
        }
        break;
    }
  }

  getCountry() async {
    setLoading(true);
    countries=await OnlineDatabase().getCountries();
    if(person.countryId!=null){
      for( var country in countries){
        if(country.id==person.countryId){
          countryValue = country;
          setState(() {});
          getState(countryValue.id.toString());
          break;
        }

      }
    }else{
      countries.add(CountryModel(id: 1,name:"please select the country",updatedAt: "",deletedAt: "",createdAt: ""));
      countryValue=countries.last;
      setState(() {});
      getState(1.toString());
    }
  }

  getState(String countryId) async {
    setLoading(true);
    states.clear();
    states=await OnlineDatabase().getStates(countryId.toString()=="null"?1.toString():countryId.toString());
    if(person.provId!=null){
      for( var province in states){
        if(province.id==person.provId){
          stateValue = province;
          setState(() {});
          getCity(province.id.toString());
          break;
        }
      }
    }else{
      states.add(ProvincesModel(id: 1,name: "please select the province",updatedAt: "",createdAt: "",deletedAt: ""));
      stateValue=states.last;
      setState(() {});
      getCity(1.toString());
    }
  }

  getCity(String id) async {
    setLoading(true);
    cities.clear();
    cities= await OnlineDatabase().getCity(id==null?1.toString():id.toString());
    if(person.cityId!=null){
      for( var city in cities){
        if(city.id==person.cityId){
          cityValue = city;
          setState(() {});
          getArea(city.id.toString());
          break;
        }
      }
    }else{
      cities.add(CityModel(id: 1,name: "please select the city",updatedAt: "",createdAt: "",deletedAt: ""));
      cityValue=cities.last;
      setState(() {});
      getArea(1.toString());
    }
  }

  getArea(String id) async {
    setLoading(true);
    areas.clear();
    areas= await OnlineDatabase().getArea(id==null?1.toString():id.toString());
    if(person.areaId!=null){
      for (var area in areas) {
        if (area.id==person.areaId) {
          areaValue = area;
          setState(() {});
          getMarket(area.id.toString());
          break;
        }
      }
    }else{
      areas.add(AreaModel(id:1 ,name:"Please select the Area", cityId:2 ,createdAt:"211212" ,updatedAt:"121212" ,deletedAt: "212"),);
      setState(() {
        areaValue=areas.last;
      });
      getMarket(1.toString());
    }
    setLoading(false);
  }

  getMarket(String id) async {
    setLoading(true);
    markets.clear();
    markets=await OnlineDatabase().getMarket(id==null?1.toString():id.toString());
      if(person.marketId!=null){
        for (var market in markets) {
          if (market.id == person.marketId) {
            marketValue = market;
            setState(() {});
          }
        }
      }
      else{
        markets.add(MarketModel(id: 1,name: "select market",createdAt: "  ",updatedAt: " ",deletedAt: ""));
        marketValue = markets.last;
        setState(() {
        });
      }
    setLoading(false);
  }

  getCustomer()async{
    setLoading(true);
    var dio=Dio();
    print(widget.customer.id);
    var response=  OnlineDatabase().getCustomer(widget.customer.id.toString(), (value)=>saveInfo(value), (error)=>
      Alert(
        context: context,
        type: AlertType.error,
        title: "Apis,Not response",
        desc: "error message: $error",
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
      ).show()) ;
    setLoading(false);
  }

  getCategory()async{
    setLoading(true);
    categories=await OnlineDatabase().getCategory();
    for( var category in categories){
      if(category.id==person.custcatId){
        categoryValue=category;
      }
    }
    setLoading(false);
  }

  postData(String verifiedId) async {
    setLoading(true);
    var dio = Dio();
    String url = "https://erp.suqexpress.com/api/customer/edit/${widget.customer
        .id}";
    FormData formData = new FormData.fromMap({
      "cust_old_code": customerCodeText==null?customerCode.text:customerCodeText,
      "first_name": shopNameText==null? shopName.text:shopNameText,
      "custcat_id": person.custcatId==categoryValue.id?category.text:categoryText,
      "cust_prim_name" :ownerNameText==null?ownerName.text:ownerNameText,
      "cust_prim_name":  ownerNameText==null? ownerNo.text:ownerNameText,
      "cnic":ownerCNICText==null? ownerCNIC.text:ownerCNICText,
      "cnic_exp": expireDateCNICText==null? expireDateCNIC.text:expireDateCNICText,
      "cust_address": customerAddressText==null?customerAddress.text:customerAddressText,
      "country_id":person.countryId == countryValue.id ? person.countryId : countryValue.id,
      "prov_id":person.provId == stateValue.id ? person
          .provId : stateValue.id,
      "city_id": person.cityId == cityValue.id
          ?person.cityId
          : cityValue.id,
      "area_id": person.areaId == areaValue.id
          ? person.areaId
          : areaValue.id,
      "market_id": person.marketId == marketValue.id ?person
          .marketId : marketValue.id,
      "contact_person2": person2Text==null? person2.text:person2Text,
      "phone2": phoneNo2Text==null?phoneNo2.text:person2Text,
      "contact_person3": person3Text==null? person3.text:person3Text,
      "phone3":phoneNo3Text==null? phoneNo3.text:phoneNo3Text,
      //images
      "owner": ownerImage == null
          ? person.imageModel!.owner
          : ownerImage,
      "shop_front": shopFrontImage == null ? person.imageModel!
          .shopFront : shopFrontImage,
      "shop_internal": shopInternalImage == null ? person.imageModel!
          .shopInternal : shopInternalImage,
      "shop_sign_board": shopSignBoardImage == null ? person
          .imageModel!.shopSignBoard : shopSignBoardImage,
      "shop_street": shopStreetImage == null ? person.imageModel!
          .shopStreet : shopStreetImage,
      "person_1": secondPersonImage == null ?person.imageModel!
          .person1 : secondPersonImage,
      "person_2": thirdPersonImage == null
          ?person.imageModel!.person2
          : thirdPersonImage,
      "cnic_front": cincFrontImage == null
          ? person.imageModel!.cnicFront
          : cincFrontImage,
      "cnic_back": cnicBackImage == null
          ? person.imageModel!.cnicBack
          : cnicBackImage,
      "verified":verifiedId,
      //TODO : Add remarks fields here
    });
    print(widget.customer.id);
    var response = await dio.post(url, data: formData).then((value) => Alert(
      context: context,
      type: AlertType.success,
      title: "Edit Successful",
      desc: "Shop successfully edit",
      buttons: [
        DialogButton(
          child: Text(
            "OK",
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
          onPressed: () {
            Navigator.pop(context);
          },
          width: 120,
        )
      ],
    ).show()).catchError((e)=>Alert(
      context: context,
      type: AlertType.error,
      title: "Edit Fail",
      desc: "Error message: $e",
      buttons: [
        DialogButton(
          child: Text(
            "OK",
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
          onPressed: () {
            Navigator.pop(context);
          },
          width: 120,
        )
      ],
    ).show());
    setLoading(false);
  }

  saveInfo(value){
    print(value);
    person=CustomerModel.fromJson(value.data["data"], widget.customer.distance);
    customerCode=TextEditingController(text: person.custOldCode.toString());
    shopName=TextEditingController(text: person.userData!.firstName);
    category=TextEditingController(text:person.custcatId.toString());
    ownerName=TextEditingController(text: person.custPrimName.toString());
    ownerNo=TextEditingController(text: person.custPrimNb.toString());
    ownerCNIC=TextEditingController(text: person.cnic.toString());
    expireDateCNIC=TextEditingController(text: person.cnicExp.toString());
    customerAddress=TextEditingController(text: person.custAddress.toString());
    person2=TextEditingController(text: person.contactPerson2.toString());
    person3=TextEditingController(text: person.contactPerson3.toString());
    phoneNo2=TextEditingController(text: person.phone2.toString());
    phoneNo3=TextEditingController(text: person.phone3.toString());
    marketsController=TextEditingController(text: person.marketId.toString());
    remarks=TextEditingController(text: "Not Good");
    assignAmmount=TextEditingController(text: "10000");
  }

  @override
  void initState() {
    onStart();
    getCustomer();
    getCategory();
    getCountry();  
    super.initState();
  }

  getMarketList(String name, int areaId) async {
    markets.clear();
    setLoading(true);
    var dio = Dio();
    FormData formData = new FormData.fromMap({'name': name, 'area_id': areaId});
    var response = await dio
        .post(
      "https://erp.suqexpress.com/api/market",
      data: formData,
      options: Options(
        contentType: "application/json",
      ),
    )
        .then((value) =>
        Alert(
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
        ).show())
        .onError((error, stackTrace) =>
        Alert(
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
    var response4 =
    await dio.get("https://erp.suqexpress.com/api/market/$areaId");
    for (var market in response4.data['data']) {
      markets.add(MarketModel.fromJson(market));
    }
    marketValue = markets[0];
    setLoading(false);
  }

  @override
  Widget build(BuildContext context) {
    var media = MediaQuery.of(context);
    var width = media.size.width;
    var height = media.size.height;
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
            child:
            Stack(
              children: [
                isLoading
                    ? Container(
                    color: Colors.white.withOpacity(0.5),
                    width: width,
                    height: height * 0.87,
                    alignment: Alignment.center,
                    child: Loading())
                    : Container(
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Container(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            DividerWithTextWidget(text: "Shop"),

                            ImageContainer(loading1: shopStreetVisible, shopStreetImage: shopStreetImage,title: "Shop Street",
                              onCamera: () => getImage(ImageSource.camera,"shop_street"),
                               onGallery: () => getImage(ImageSource.gallery,"shop_street"),
                              onLongPress:() {setState(() {shopStreetVisible = false;shopStreetImage = null;});},),

                            ImageContainer(loading1: shopFrontVisible, shopStreetImage: shopFrontImage,title: "Shop front",
                              onCamera: () => getImage(ImageSource.camera, "shop_front"),
                              onGallery: () => getImage(ImageSource.gallery, "shop_front"),
                              onLongPress:() {setState(() {shopFrontVisible = false;shopFrontImage = null;});},),

                            ImageContainer(loading1: shopInternalVisible, shopStreetImage: shopInternalImage,title: "Shop Internal",
                              onCamera: () => getImage(ImageSource.camera,"shop_internal"),
                              onGallery: () => getImage(ImageSource.gallery,"shop_internal"  ),
                              onLongPress:() {setState(() {shopInternalVisible = false;shopInternalImage = null;});},),

                            ImageContainer(loading1: shopSignBoardVisible, shopStreetImage: shopSignBoardImage,title: "Shop Sign Board",
                              onCamera: () => getImage(ImageSource.camera,"shop_signboard"),
                              onGallery: () => getImage(ImageSource.gallery,"shop_signboard"),
                              onLongPress:() {setState(() {shopSignBoardVisible = false;shopSignBoardImage = null;});},),

                            DividerWithTextWidget(text: "Owner"),

                            ImageContainer(loading1: ownerVisible, shopStreetImage: ownerImage,title: "Owner",
                              onCamera: () => getImage(ImageSource.camera, "owner"),
                              onGallery: () => getImage(ImageSource.gallery,"owner"),
                              onLongPress:() {setState(() {ownerVisible = false;ownerImage = null;});},),

                            ImageContainer(loading1: cnicFrontVisible, shopStreetImage: cincFrontImage,title: "CNIC Front",
                              onCamera: () => getImage(ImageSource.camera,"cnic_front"),
                              onGallery: () => getImage(ImageSource.gallery,"cnic_front"),
                              onLongPress:() {setState(() {cnicFrontVisible = false;cincFrontImage = null;});},),

                            ImageContainer(loading1: cnicbackVisible, shopStreetImage: cnicBackImage,title: "CNIC Back",
                              onCamera: () => getImage(ImageSource.camera, "cnic_back"),
                              onGallery: () => getImage(ImageSource.gallery, "cnic_back"),
                              onLongPress:() {setState(() {cnicbackVisible = false;cnicBackImage = null;});},),


                            DividerWithTextWidget(text: "Customer"),
                            EditTextField(
                              label: "Customer Code",
                              hintText: customerCode.text,
                              onChange: (value) {
                                customerCodeText = value;setState(() {});},
                              controller: customerCode,
                            ),
                            EditTextField(
                              label: "Customer Shop",
                              hintText: shopName.text,
                              onChange: (value) {
                                shopNameText = value;
                                setState(() {});

                              },
                              controller: shopName,
                            ),
                            TextFieldLabel(
                              label: "Category",
                            ),
                          ShowDropDown(height: height,list: categories,value: categoryValue,text:"catName",onChange:(category) async {
                                    setState(() {categoryValue = category!;  });}, ),
        //print("Selected area is: "+sel_areas.areaCode.toString());

                            DividerWithTextWidget(text: "Owner"),
                            EditTextField(
                              label: "Owner Name",
                              hintText: ownerName.text,
                              onChange: (value) {
                                ownerNameText = value;
                                setState(() {});

                              },
                              controller: ownerName,
                            ),
                            EditTextField(
                              label: "Owner Number",
                              hintText: ownerNo.text,
                              onChange: (value) {
                                ownerNoText =  value;
                                setState(() {});

                              },
                              controller: ownerNo,
                            ),
                            EditTextField(
                              label: "Owner CNIC",
                              hintText: ownerCNIC.text,
                              onChange: (value) {
                                ownerCNICText =  value;
                                setState(() {});

                              },
                              controller: ownerCNIC,
                            ),
                            EditTextField(
                              label: "CNIC EXPIRE DATE",
                              hintText: expireDateCNIC.text,
                              onChange: (value) {
                                expireDateCNICText =  value;
                                setState(() {});

                              },
                              controller: expireDateCNIC,
                            ),
                            DividerWithTextWidget(text: "Address"),
                            LocationButton(width: width, customerAddress: customerAddress ,onPressed: (){
                              customerAddress=TextEditingController(text: actualAddress);
                               setState(() {});
                            },),

                            TextFieldLabel(label: "Country",),

                            ShowDropDown(height: height,list: countries,text:"countryNick",value: countryValue,onChange:(country) async {
                              setState(() {countryValue = country!;  },);}, ),
                            //CountryDropDown(height),
                            TextFieldLabel(label: "Provinces",),

                            ShowDropDown(height: height,list: states,text:"name",value: stateValue,onChange:(state) async {
                              setState(() {stateValue = state!;  });
                              getCity(stateValue.id.toString());},),

                            TextFieldLabel(label: "City",),

                            ShowDropDown(height: height,list: cities,text:"name",value: cityValue,onChange:(city) async {
                              setState(() {cityValue = city!;  });
                              getArea(cityValue.id.toString());},),

                            TextFieldLabel(label: "Area",),

                            ShowDropDown(height: height,list: areas,value: areaValue,text:"name",onChange:(area) async {
                              setState(() {areaValue = area!;  });
                              getMarket(areaValue.id.toString());},),

                            TextFieldLabel(label: "Market",),

                            Row(
                              children: [
                                Container(
                                  width: width *0.5,
                                  child: ShowDropDown(height: height,text:"name",list: markets,value: marketValue,onChange:(marketValue) async {
                                    setState(() {marketValue = marketValue!;  });},),
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
                                            )))),
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
                          )),

                            DividerWithTextWidget(text: "Second Contact person"),

                            ImageContainer(loading1: personTwoVisiable, shopStreetImage: secondPersonImage,title: "Second Person",
                              onCamera: () => getImage(ImageSource.camera, "person2"),
                              onGallery: () => getImage(ImageSource.gallery,"person2"),
                              onLongPress:() {setState(() {personTwoVisiable = false;secondPersonImage = null;});},),

                            EditTextField(
                              label: "Second Contact Person Name",
                              hintText: person2.text,
                              onChange: (value) {
                                person2Text=value;setState(() {});},
                              controller: person2,),

                            EditTextField(
                              label: "Second Contact person Number",
                              hintText: phoneNo2.text,
                              onChange: (value) {phoneNo2Text=value;setState(() {});}, controller: phoneNo2,),

                            DividerWithTextWidget(text: "Third Contact person"),

                            ImageContainer(loading1: personThreeVisible, shopStreetImage: thirdPersonImage,title: "Thrid person",
                              onCamera: () => getImage(ImageSource.camera,"person3"),
                              onGallery: () => getImage(ImageSource.gallery,"person3"),
                              onLongPress:() {setState(() {personThreeVisible = false;thirdPersonImage = null;});},),


                            EditTextField(
                              label: "Third Contact Person Name",
                              hintText:person3.text,
                              onChange: (value) {person2Text=value;setState(() {});}, controller: person3,),

                            EditTextField(
                              label: "ThirdContact person Number",
                              hintText: phoneNo2.text,
                              onChange: (value) {
                                phoneNo3=value;setState(() {});}, controller: phoneNo3,),

                            DividerWithTextWidget(text: "Remarks"),
                            EditTextField(
                              label: "Remarks",
                              hintText: remarks.text,
                              onChange: (value) {
                                remarks = value;setState(() {});},
                              controller: remarks,
                            ),
                            EditTextField(
                              label: "Assgin Amount",
                              hintText: assignAmmount.text,
                              onChange: (value) {
                                assignAmmount = value;setState(() {});},
                              controller: assignAmmount,
                            ),
                            SizedBox(height: 10,),
                            VerifiedButtons(
                              onVerify: () {
                                postData(1.toString());
                                Navigator.push(context, MaterialPageRoute(builder: (context)=>MainScreen()));
                              },
                              onUnVerify: () {
                                postData(2.toString());
                                Navigator.push(context, MaterialPageRoute(builder: (context)=>MainScreen()));
                              },
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                )
              ],
            )
        ));
  }
  setLoading(bool value) {
    setState(() {
      isLoading = value;
    });
  }


}
