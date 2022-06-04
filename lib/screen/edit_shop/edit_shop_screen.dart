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
      marketsController = TextEditingController();
  File? ownerImage, shopStreetImage, shopFrontImage, shopInternalImage,
      shopSignBoardImage, cincImage, cnicback, secondPersonImage,
      thirdPersonImage;
  bool loading = false,
      loading1 = false,
      loading2 = false,
      loading3 = false,
      loading4 = false,
      loading5 = false,
      loading6 = false,
      loading7 = false,
      loading8 = false;
  List<CountryModel> countries = [];
  List<ProvincesModel> sates = [];
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


  getCategory()async{
    setLoading(true);
    var dio = Dio();
    var response = await dio.get("https://erp.suqexpress.com/api/customercategory");
    for (var category in response.data['data']) {
      categories.add(CategoryModel.fromJson(category));
    }
    for( var category in categories){
      if(person.custcatId==category.id){
        categoryValue = category;
        setState(() {});
      }
    }
    setLoading(false);
  }
  postData() async {
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
      "cnic_front": cincImage == null
          ? person.imageModel!.cnicFront
          : cincImage,
      "cnic_back": cnicback == null
          ? person.imageModel!.cnicBack
          : cnicback,
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

  getImage(ImageSource source, String name) async {
    if (name == "Owner") {
      var camera = await Permission.camera.request();
      var gallery = await Permission.storage.request();
      final File pickedFile = await ImagePicker.pickImage(
        source: source,
        maxWidth: 512,
        maxHeight: 512,
        imageQuality: 100,
      );
      if (pickedFile != null) {
        setState(() {
          ownerImage = pickedFile;
          loading = true;
          print(ownerImage!.path);
        });
        // var img;
        //
        // img = await MultipartFile.fromFile(ownerImage!.path,
        //     filename: ownerImage!
        //         .path
        //         .split('/')
        //         .last
        // );
      }
    } else if (name == "street") {
      var camera = await Permission.camera.request();
      var gallery = await Permission.storage.request();
       File pickedFile = await ImagePicker.pickImage(
        source: source,
        maxWidth: 512,
        maxHeight: 512,
        imageQuality: 100,
      );
      if (pickedFile != null) {
        setState(() {
          shopStreetImage = pickedFile;
          loading1 = true;
          print(shopStreetImage!.path);
        });
      }
    } else if (name == "front") {
      var camera = await Permission.camera.request();
      var gallery = await Permission.storage.request();
       File pickedFile = await ImagePicker.pickImage(
        source: source,
      );
      if (pickedFile != null) {
        setState(() {
          shopFrontImage = pickedFile;
          loading2 = true;
          print(shopFrontImage!.path);
        });
      }
    } else if (name == "internal") {
      var camera = await Permission.camera.request();
      var gallery = await Permission.storage.request();
       File pickedFile = await ImagePicker.pickImage(
         imageQuality: 50,
        source: source,
      );
      if (pickedFile != null) {
        setState(() {
          shopInternalImage = pickedFile;
          loading3 = true;
          print(shopInternalImage!.path);
        });
      }
    } else if (name == "signboard") {
      var camera = await Permission.camera.request();
      var gallery = await Permission.storage.request();
       File pickedFile = await ImagePicker.pickImage(
        source: source,
      );
      if (pickedFile != null) {
        setState(() {
          shopSignBoardImage = pickedFile;
          loading4 = true;
          print(shopSignBoardImage!.path);
        });
      }
    } else if (name == "cinc_front") {
      var camera = await Permission.camera.request();
      var gallery = await Permission.storage.request();
       File pickedFile = await ImagePicker.pickImage(
        source: source,
      );
      if (pickedFile != null) {
        setState(() {
          cincImage = pickedFile;
          loading5 = true;
          print(cincImage!.path);
        });
      }
    } else if (name == "cnic_back") {
      var camera = await Permission.camera.request();
      var gallery = await Permission.storage.request();
       File pickedFile = await ImagePicker.pickImage(
        source: source,
      );
      if (pickedFile != null) {
        setState(() {
          cnicback = pickedFile;
          loading6 = true;
          print(cnicback!.path);
        });
      }
    } else if (name == "person_1") {
      var camera = await Permission.camera.request();
      var gallery = await Permission.storage.request();
       File pickedFile = await ImagePicker.pickImage(
        source: source,
      );
      if (pickedFile != null) {
        setState(() {
          secondPersonImage = pickedFile;
          loading7 = true;
          print(secondPersonImage!.path);
        });
      }
    } else if (name == "person_2") {
      var camera = await Permission.camera.request();
      var gallery = await Permission.storage.request();
       File pickedFile = await ImagePicker.pickImage(
        source: source,
      );
      if (pickedFile != null) {
        setState(() {
          thirdPersonImage = pickedFile;
          loading8 = true;
          print(thirdPersonImage!.path);
        });
      }
    }
  }

  getCountry() async {
    setLoading(true);
    var dio = Dio();
    var response = await dio.get("https://erp.suqexpress.com/api/country");
    for (var country in response.data['data']) {
      countries.add(CountryModel.fromJson(country));
    }
    for( var country in countries){
      if(country.id==person.countryId){
        countryValue = country;
        setState(() {});
        getState(countryValue.id.toString());
        break;
      }

    }
  }

  getState(String countryId) async {
    setLoading(true);
    sates.clear();
    var dio = Dio();
    var response1 =
    await dio.get("https://erp.suqexpress.com/api/state/$countryId}");
    for (var state in response1.data['data']) {
      sates.add(ProvincesModel.fromJson(state));
    }
    for( var province in sates){
      if(province.id==person.provId){
        stateValue = province;
        setState(() {});
        getCity(province.id.toString());
        break;
      }
    }
  }

  getCity(String id) async {
    setLoading(true);
    cities.clear();
    var dio = Dio();
    var response2 = await dio.get("https://erp.suqexpress.com/api/city/$id");
    for (var city in response2.data['data']) {
      cities.add(CityModel.fromJson(city));
    }
    for( var city in cities){
      if(city.id==person.cityId){
        cityValue = city;
        setState(() {});
        getArea(city.id.toString());
      break;
      }
    }
  }

  getArea(String id) async {
    setLoading(true);
    areas.clear();
    var dio = Dio();
    var response3 = await dio.get("https://erp.suqexpress.com/api/area/$id");
    for (var area in response3.data['data']) {
      areas.add(AreaModel.fromJson(area));
    }
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
    var dio = Dio();
    var response4 = await dio.get("https://erp.suqexpress.com/api/market/$id");
    if (response4.data != null) {
      for (var market in response4.data['data']) {
        markets.add(MarketModel.fromJson(market));
      }
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
    }
    setLoading(false);
  }

  setLoading(bool value) {
    setState(() {
      isLoading = value;
    });
  }

  getCustomer()async{
    setLoading(true);
    var dio=Dio();
    print(widget.customer.id);
    var response=await dio.get("http://erp.suqexpress.com/api/customer/${widget.customer.id}") .then((value) {
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

      }).catchError((e)=> Alert(
      context: context,
      type: AlertType.error,
      title: "Apis,Not response",
      desc: "error message: $e",
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
    setLoading(false);
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
        appBar: Appbar(context),
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
                      VerifiedButton(
                        onVerify: () {
                          postData();
                          Navigator.push(context, MaterialPageRoute(builder: (context)=>MainScreen()));
                        },
                        onUnVerify: () {
                          Navigator.push(context, MaterialPageRoute(builder: (context)=>MainScreen()));
                        },
                      ),
                      Container(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            DividerWithTextWidget(text: "Shop"),
                            UploadImages(
                              title: "Shop Street",
                              onCamera: () => getImage(ImageSource.camera, "street"),
                              onGallery: () => getImage(ImageSource.gallery, "street"),
                            ),
                            InkWell(
                                onLongPress: () {
                                  setState(() {
                                    loading1 = false;
                                    shopStreetImage = null;
                                  });
                                },
                                child: VisiableImage(loading: loading1, image: shopStreetImage)),
                            UploadImages(
                              title: "Shop Front",
                              onCamera: () => getImage(ImageSource.camera, "front"),
                              onGallery: () => getImage(ImageSource.gallery, "front"),
                            ),
                            InkWell(
                                onLongPress: () {
                                  setState(() {
                                    loading2 = false;
                                    shopFrontImage = null;
                                  });
                                },
                                child: VisiableImage(loading: loading2, image: shopFrontImage)),
                            UploadImages(
                              title: "Shop Internal",
                              onCamera: () => getImage(ImageSource.camera, "internal"),
                              onGallery: () => getImage(ImageSource.gallery, "internal"),
                            ),
                            InkWell(
                                onLongPress: () {
                                  setState(() {
                                    loading3 = false;
                                    shopInternalImage = null;
                                  });
                                },
                                child: VisiableImage(loading: loading3, image: shopInternalImage)),
                            UploadImages(
                              title: "Shop Sign Board",
                              onCamera: () => getImage(ImageSource.camera, "signboard"),
                              onGallery: () => getImage(ImageSource.gallery, "signboard"),
                            ),
                            InkWell(
                                onLongPress: () {
                                  setState(() {
                                    loading4 = false;
                                    shopSignBoardImage = null;
                                  });
                                },
                                child: VisiableImage(loading: loading4, image: shopSignBoardImage)),
                            DividerWithTextWidget(text: "Owner"),
                            UploadImages(
                              title: "Owner",
                              onCamera: () => getImage(ImageSource.camera, "owner"),
                              onGallery: () => getImage(ImageSource.gallery, "owner"),
                            ),
                            InkWell(
                                onLongPress: () {
                                  setState(() {
                                    loading = false;
                                    ownerImage = null;
                                  });
                                },
                                child: VisiableImage(loading: loading, image: ownerImage)),
                            UploadImages(
                              title: "CNIC Front",
                              onCamera: () => getImage(ImageSource.camera, "cinc_front"),
                              onGallery: () => getImage(ImageSource.gallery, "cinc_front"),
                            ),
                            InkWell(
                                onLongPress: () {
                                  setState(() {
                                    loading5 = false;
                                    cincImage = null;
                                  });
                                },
                                child: VisiableImage(loading: loading5, image: cincImage)),
                            UploadImages(
                              title: "CNIC Back",
                              onCamera: () => getImage(ImageSource.camera, "cnic_back"),
                              onGallery: () => getImage(ImageSource.gallery, "cnic_back"),
                            ),
                            InkWell(
                                onLongPress: () {
                                  setState(() {
                                    loading6 = false;
                                    cnicback = null;
                                  });
                                },
                                child: VisiableImage(loading: loading6, image: cnicback)),
                            DividerWithTextWidget(text: "Customer"),
                            EditTextField(
                              label: "Customer Code",
                              hintText: customerCode.text,
                              onChange: (value) {
                                customerCodeText = value;
                                setState(() {});

                              },
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
                          Container(
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
                                    child: DropdownButton<CategoryModel>(
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
                                        value: categoryValue,
                                        isExpanded: true,
                                        onTap: () {},
                                        onChanged: (category) async {
                                          setState(() {
                                            categoryValue = category!;
                                            //print("Selected area is: "+sel_areas.areaCode.toString());
                                          });
                                        },
                                        style: TextStyle(
                                            fontSize: 14,
                                            color: Color(
                                              0xffC5C5C5,
                                            )),
                                        items:
                                        categories.map<DropdownMenuItem<CategoryModel>>((CategoryModel item) {
                                          return DropdownMenuItem<CategoryModel>(
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
                          ),
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
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Container(
                                  width: width * 0.7,
                                  child: EditTextField(
                                    label: "Customer Address",
                                    hintText: customerAddress.text,
                                    onChange: (value) {


                                      setState(() {

                                      });
                                    },
                                    controller: customerAddress,
                                  ),
                                ),
                                Container(
                                  margin: EdgeInsets.symmetric(vertical: 5,horizontal: 0),
                                  decoration: BoxDecoration(
                                    color: themeColor1,
                                    borderRadius: BorderRadius.circular(5),
                                  ),
                                  child: IconButton(onPressed: (){
                                    customerAddress=TextEditingController(text: actualAddress);
                                  setState(() {});
                                },icon: Icon(Icons.location_searching,color: Colors.white,),),),
                              ],
                            ),
                            TextFieldLabel(
                              label: "Country",
                            ),
                            CountryDropDown(height),
                            TextFieldLabel(
                              label: "Provinces",
                            ),
                            ProvinceDropDown(height),
                            TextFieldLabel(
                              label: "City",
                            ),
                            CityDropDown(height),
                            TextFieldLabel(
                              label: "Area",
                            ),
                            AreaDropDown(height),
                            TextFieldLabel(
                              label: "Market",
                            ),
                            MarketDropDown(height),
                            AddMarket(),
                            DividerWithTextWidget(
                                text: "Second Contact person"),
                            UploadImages(
                              title: "Second Person",
                              onCamera: () =>
                                  getImage(ImageSource.camera, "person_1"),
                              onGallery: () =>
                                  getImage(ImageSource.gallery, "person_1"),
                            ),
                            InkWell(
                                onLongPress: () {
                                  setState(() {
                                    loading7 = false;
                                    secondPersonImage = null;
                                  });
                                },
                                child: VisiableImage(
                                    loading: loading7,
                                    image: secondPersonImage)),
                            EditTextField(
                              label: "Second Contact Person Name",
                              hintText: person2.text,
                              onChange: (value) {
                                person2Text=value;
                                setState(() {});

                              },
                              controller: person2,
                            ),
                            EditTextField(
                              label: "Second Contact person Number",
                              hintText: phoneNo2.text,
                              onChange: (value) {
                                phoneNo2Text=value;
                                setState(() {});

                              },
                              controller: phoneNo2,
                            ),
                            DividerWithTextWidget(
                                text: "Third Contact person"),
                            UploadImages(
                              title: "Thrid person",
                              onCamera: () =>
                                  getImage(ImageSource.camera, "person_2"),
                              onGallery: () =>
                                  getImage(ImageSource.gallery, "person_2"),
                            ),
                            InkWell(
                                onLongPress: () {
                                  setState(() {
                                    loading8 = false;
                                    thirdPersonImage = null;
                                  });
                                },
                                child: VisiableImage(
                                    loading: loading8,
                                    image: thirdPersonImage)),
                            EditTextField(
                              label: "Third Contact Person Name",
                              hintText:person3.text,
                              onChange: (value) {
                                person2Text=value;
                                setState(() {});

                              },
                              controller: person3,
                            ),
                            EditTextField(
                              label: "ThirdContact person Number",
                              hintText: phoneNo2.text,
                              onChange: (value) {
                                phoneNo3=value;
                                setState(() {});
                              },
                              controller: phoneNo3,
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            SaveButton(
                              onSave: () {
                                postData();
                                Navigator.push(context, MaterialPageRoute(builder: (context)=>MainScreen()));
                              },
                            )
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

  AppBar Appbar(BuildContext context) {
    return AppBar(
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
    );
  }

  Container AddMarket() {
    return Container(
      child: Visibility(
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
              onTap: () {
                getMarketList(marketsController.text, areaValue.id!.toInt());
                marketsController.clear();
              },
              child: Container(
                margin: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                decoration: BoxDecoration(
                    color: themeColor1, borderRadius: BorderRadius.circular(5)),
                padding: EdgeInsets.symmetric(vertical: 15, horizontal: 20),
                child: Center(
                    child: Text(
                      "ADD",
                      style: TextStyle(color: Colors.white, fontSize: 15),
                    )),
              ),
            )
          ],
        ),
      ),
    );
  }


  Container MarketDropDown(double height) {
    return Container(
      child: Row(
        children: [
          Flexible(
            child: Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  color: Color(0xffF4F4F4),
                  border: Border.all(color: themeColor1)),
              height: height * 0.065,
              child: InputDecorator(
                  decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Color(0xffEEEEEE))),
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.red)),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5.0)),
                    contentPadding:
                    EdgeInsets.only(top: 0, bottom: 0, left: 5, right: 10),
                  ),
                  child: DropdownButtonHideUnderline(
                      child: DropdownButton<MarketModel>(
                          icon: Icon(Icons.arrow_drop_down),
                          hint: Padding(
                            padding: const EdgeInsets.only(left: 8.0),
                            child: Text("Select your market",
                                style: TextStyle(
                                    fontSize: 13,
                                    fontWeight: FontWeight.w400,
                                    color: Color(
                                      0xffB2B2B2,
                                    ))),
                          ),
                          value: marketValue,
                          isExpanded: true,
                          onTap: () {},
                          onChanged: (market) async {
                            setState(() {
                              marketValue = market!;

                              //print("Selected area is: "+sel_areas.areaCode.toString());
                            });
                          },
                          style: TextStyle(
                              fontSize: 14,
                              color: Color(
                                0xffC5C5C5,
                              )),
                          items: markets.map<DropdownMenuItem<MarketModel>>(
                                  (MarketModel item) {
                                return DropdownMenuItem<MarketModel>(
                                  value: item,
                                  child: Padding(
                                    padding: const EdgeInsets.only(left: 8.0),
                                    child: VariableText(
                                      text: item.name ?? 'Not Found',
                                      fontsize: 13,
                                      weight: FontWeight.w400,
                                    ),
                                  ),
                                );
                              }).toList()))),
            ),
          ),
          InkWell(
            onTap: () {
              setState(() {
                visible = visible ? false : true;
              });
            },
            child: Container(
              margin: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
              decoration: BoxDecoration(
                  color: themeColor1, borderRadius: BorderRadius.circular(5)),
              padding: EdgeInsets.symmetric(vertical: 15, horizontal: 20),
              child: Center(
                  child: Text(
                    "Add Market",
                    style: TextStyle(color: Colors.white, fontSize: 15),
                  )),
            ),
          )
        ],
      ),
    );
  }

  Container AreaDropDown(double height) {
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
              child: DropdownButton<AreaModel>(
                  icon: Icon(Icons.arrow_drop_down),
                  hint: Padding(
                    padding: const EdgeInsets.only(left: 8.0),
                    child: Text("Select your Province",
                        style: TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w400,
                            color: Color(
                              0xffB2B2B2,
                            ))),
                  ),
                  value: areaValue,
                  isExpanded: true,
                  onTap: () {},
                  onChanged: (area) async {
                    setState(() {
                      areaValue = area!;
                      getMarket(areaValue.id.toString());

                      //print("Selected area is: "+sel_areas.areaCode.toString());
                    });
                  },
                  style: TextStyle(
                      fontSize: 14,
                      color: Color(
                        0xffC5C5C5,
                      )),
                  items:
                  areas.map<DropdownMenuItem<AreaModel>>((AreaModel item) {
                    return DropdownMenuItem<AreaModel>(
                      value: item,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 8.0),
                        child: VariableText(
                          text: item.name ?? 'Not Found',
                          fontsize: 13,
                          weight: FontWeight.w400,
                        ),
                      ),
                    );
                  }).toList()))),
    );
  }

  Container CityDropDown(double height) {
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
              child: DropdownButton<CityModel>(
                  icon: Icon(Icons.arrow_drop_down),
                  hint: Padding(
                    padding: const EdgeInsets.only(left: 8.0),
                    child: Text("Select your Province",
                        style: TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w400,
                            color: Color(
                              0xffB2B2B2,
                            ))),
                  ),
                  value: cityValue,
                  isExpanded: true,
                  onTap: () {},
                  onChanged: (city) async {
                    setState(() {
                      cityValue = city!;
                      getArea(cityValue.id.toString());

                      //print("Selected area is: "+sel_areas.areaCode.toString());
                    });
                  },
                  style: TextStyle(
                      fontSize: 14,
                      color: Color(
                        0xffC5C5C5,
                      )),
                  items:
                  cities.map<DropdownMenuItem<CityModel>>((CityModel item) {
                    return DropdownMenuItem<CityModel>(
                      value: item,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 8.0),
                        child: VariableText(
                          text: item.name ?? 'Not Found',
                          fontsize: 13,
                          weight: FontWeight.w400,
                        ),
                      ),
                    );
                  }).toList()))),
    );
  }

  Container ProvinceDropDown(double height) {
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
              child: DropdownButton<ProvincesModel>(
                  icon: Icon(Icons.arrow_drop_down),
                  hint: Padding(
                    padding: const EdgeInsets.only(left: 8.0),
                    child: Text("Select your Province",
                        style: TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w400,
                            color: Color(
                              0xffB2B2B2,
                            ))),
                  ),
                  value: stateValue,
                  isExpanded: true,
                  onTap: () {},
                  onChanged: (state) async {
                    setState(() {
                      stateValue = state!;

                      //print("Selected area is: "+sel_areas.areaCode.toString());
                    });
                    getCity(stateValue.id.toString());
                  },
                  style: TextStyle(
                      fontSize: 14,
                      color: Color(
                        0xffC5C5C5,
                      )),
                  items: sates.map<DropdownMenuItem<ProvincesModel>>(
                          (ProvincesModel item) {
                        return DropdownMenuItem<ProvincesModel>(
                          value: item,
                          child: Padding(
                            padding: const EdgeInsets.only(left: 8.0),
                            child: VariableText(
                              text: item.name ?? 'Not Found',
                              fontsize: 13,
                              weight: FontWeight.w400,
                            ),
                          ),
                        );
                      }).toList()))),
    );
  }

  Container CountryDropDown(double height) {
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
              child: DropdownButton<CountryModel>(
                  icon: Icon(Icons.arrow_drop_down),
                  hint: Padding(
                    padding: const EdgeInsets.only(left: 8.0),
                    child: Text("Select your Country",
                        style: TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w400,
                            color: Color(
                              0xffB2B2B2,
                            ))),
                  ),
                  value: countryValue,
                  isExpanded: true,
                  onTap: () {},
                  onChanged: (country) async {
                    setState(() {
                      countryValue = country!;

                      //print("Selected area is: "+sel_areas.areaCode.toString());
                    });
                    getCountry();
                    setState(() {});
                  },
                  style: TextStyle(
                      fontSize: 14,
                      color: Color(
                        0xffC5C5C5,
                      )),
                  items: countries
                      .map<DropdownMenuItem<CountryModel>>((CountryModel item) {
                    return DropdownMenuItem<CountryModel>(
                      value: item,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 8.0),
                        child: VariableText(
                          text: item.name ?? 'Not Found',
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

class VerifiedButton extends StatelessWidget {
  VerifiedButton({this.onVerify, this.onUnVerify});
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
