import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:salesmen_app/others/style.dart';
import 'package:salesmen_app/others/widgets.dart';

import 'edit_shop_image.dart';

class EditShopDetails extends StatefulWidget {
  const EditShopDetails({Key? key}) : super(key: key);

  @override
  State<EditShopDetails> createState() => _EditShopDetailsState();
}

class _EditShopDetailsState extends State<EditShopDetails> {
  final ImagePicker _picker = ImagePicker();
  String firstCity = 'Karachi';
  String firstCountry = 'Pakistan';
  var country=["Afghanistan","Albania","Algeria","Andorra","Angola","Antigua & Deps","Argentina","Armenia","Australia","Austria","Azerbaijan","Bahamas","Bahrain","Bangladesh","Barbados","Belarus","Belgium","Belize","Benin","Bhutan","Bolivia","Bosnia Herzegovina","Botswana","Brazil","Brunei","Bulgaria","Burkina","Burundi","Cambodia","Cameroon","Canada","Cape Verde","Central African Rep","Chad","Chile","China","Colombia","Comoros","Congo","Congo {Democratic Rep}","Costa Rica","Croatia","Cuba","Cyprus","Czech Republic","Denmark","Djibouti","Dominica","Dominican Republic","East Timor","Ecuador","Egypt","El Salvador","Equatorial Guinea","Eritrea","Estonia","Ethiopia","Fiji","Finland","France","Gabon","Gambia","Georgia","Germany","Ghana","Greece","Grenada","Guatemala","Guinea","Guinea-Bissau","Guyana","Haiti","Honduras","Hungary","Iceland","India","Indonesia","Iran","Iraq","Ireland {Republic}","Israel","Italy","Ivory Coast","Jamaica","Japan","Jordan","Kazakhstan","Kenya","Kiribati","Korea North","Korea South","Kosovo","Kuwait","Kyrgyzstan","Laos","Latvia","Lebanon","Lesotho","Liberia","Libya","Liechtenstein","Lithuania","Luxembourg","Macedonia","Madagascar","Malawi","Malaysia","Maldives","Mali","Malta","Marshall Islands","Mauritania","Mauritius","Mexico","Micronesia","Moldova","Monaco","Mongolia","Montenegro","Morocco","Mozambique","Myanmar, {Burma}","Namibia","Nauru","Nepal","Netherlands","New Zealand","Nicaragua","Niger","Nigeria","Norway","Oman","Pakistan","Palau","Panama","Papua New Guinea","Paraguay","Peru","Philippines","Poland","Portugal","Qatar","Romania","Russian Federation","Rwanda","St Kitts & Nevis","St Lucia","Saint Vincent & the Grenadines","Samoa","San Marino","Sao Tome & Principe","Saudi Arabia","Senegal","Serbia","Seychelles","Sierra Leone","Singapore","Slovakia","Slovenia","Solomon Islands","Somalia","South Africa","South Sudan","Spain","Sri Lanka","Sudan","Suriname","Swaziland","Sweden","Switzerland","Syria","Taiwan","Tajikistan","Tanzania","Thailand","Togo","Tonga","Trinidad & Tobago","Tunisia","Turkey","Turkmenistan","Tuvalu","Uganda","Ukraine","United Arab Emirates","United Kingdom","United States","Uruguay","Uzbekistan","Vanuatu","Vatican City","Venezuela","Vietnam","Yemen","Zambia","Zimbabwe"];
  var city = ["Abbottabad","Ahmadpur East","Bahawalnagar","Bahawalpur","Burewala","Chakwal","Charsada","Chichawatni","Chiniot","Chishtian","Dadu","Daska","Dera Ghazi Khan","Dera Ismail Khan","Faisalabad","Farooka","Gojra","Gujranwala","Gujrat","Hafizabad","Hyderabad","Islamabad","Jacobabad","Jaranwala","Jhelum","Kamalia","Kamoke","Kandhkot","Karachi","Kasur","Khairpur","Khanewal","Khanpur","Khushab","Khuzdar","Kohat","Kot Adu","Lahore","Larkana","Mandi Bahauddin","Mansehra","Mardan","Mianwali","Mingora","Mirpur Khas","Multan","Muridke","Muzaffargarh","Nawabshah","Nowshera","Okara","Pakpattan","Peshawar","Quetta","Rahim Yar Khan","Rawalpindi","Sadiqabad","Sahiwal","Sargodha","Sheikhupura","Shikarpur","Sialkot","Sukkur","Swabi","Tando Adam","Tando Allahyar","Vehari","Vehari","Wah Cantonment","Wazirabad","Add Market"];
  TextEditingController controller =TextEditingController();
  getImage(ImageSource source)async{
    Map<Permission, PermissionStatus> statuses = await [
      Permission.storage,
      Permission.camera,
    ].request();
    final XFile? pickedFile = await _picker.pickImage(
      source: source,
      maxWidth: 512,
      maxHeight: 512,
      imageQuality: 100,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 20,vertical: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
          Container(
          child: Column(
          children: [
            UploadImageCard(
            title: "Owner",
            onCamera:()=> getImage(ImageSource.camera),
            onGallery: ()=> getImage(ImageSource.gallery),
          ),
          UploadImageCard(
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
          Container(
            margin: EdgeInsets.symmetric(vertical: 10,horizontal: 20),
            decoration: BoxDecoration(
                color: themeColor1,
                borderRadius: BorderRadius.circular(5)
            ),
            padding: EdgeInsets.symmetric(vertical: 10,horizontal: 30),
            child: Center(child: Text("Verify",style: TextStyle(color: Colors.white,fontSize: 20),)),
          )
          ],
        ),
      ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                    margin: EdgeInsets.symmetric(vertical: 10),
                    decoration: BoxDecoration(
                        color: themeColor1,
                        borderRadius: BorderRadius.circular(5)
                    ),
                    padding: EdgeInsets.symmetric(vertical: 10,horizontal: 40),
                    child: Center(child: Text("Verified",style: TextStyle(color: Colors.white,fontSize: 18),)),
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(vertical: 10),
                    decoration: BoxDecoration(
                        color: themeColor1,
                        borderRadius: BorderRadius.circular(5)
                    ),
                    padding: EdgeInsets.symmetric(vertical: 10,horizontal: 40),
                    child: Center(child: Text("Unverified",style: TextStyle(color: Colors.white,fontSize: 18),)),
                  )
                ],
              ),
              EditTextField(label: "Customer Code",hintText: "00008",onChange: (value){},controller: controller,),
              EditTextField(label: "Customer Shop",hintText: "Hadi Autos",onChange: (value){},controller: controller,),
              EditTextField(label: "Category",hintText: "1",onChange: (value){},controller: controller,),
              EditTextField(label: "Owner Name",hintText: "Sami Fahim,",onChange: (value){},controller: controller,),
              EditTextField(label: "Owner Number",hintText: "+921234567890",onChange: (value){},controller: controller,),
              EditTextField(label: "Owner CNIC",hintText: "42000 456987412",onChange: (value){},controller: controller,),
              EditTextField(label: "CNIC EXPIRE DATE",hintText: "12-04-1998",onChange: (value){},controller: controller,),
              EditTextField(label: "Customer Address",hintText: "Pakistan Sindh Karachi",onChange: (value){},controller: controller,),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 5),
                child: Text("Country",style: TextStyle(color: themeColor1),),
              ),
              Container(
                margin: EdgeInsets.symmetric(vertical: 0,horizontal: 0  ),
                padding: EdgeInsets.symmetric(vertical: 10,horizontal: 10),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    border: Border.all(color: themeColor1)
                ),
                child: DropdownButton(
                  isDense: true,
                  underline: Container(),
                  isExpanded: true,
                  value: firstCountry, icon: const Icon(Icons.keyboard_arrow_down),
                  items: country.map((String items) {
                    return DropdownMenuItem(value: items, child: Text(items),);}).toList(),
                  onChanged: (String? newValue) {setState(() {firstCountry = newValue!;});},),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 5),
                child: Text("Province",style: TextStyle(color: themeColor1),),
              ),
              Container(
                margin: EdgeInsets.symmetric(vertical: 0,horizontal: 0  ),
                padding: EdgeInsets.symmetric(vertical: 10,horizontal: 10),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    border: Border.all(color: themeColor1)
                ),
                child: DropdownButton(
                  isDense: true,
                  underline: Container(),
                  isExpanded: true,
                  value: firstCity, icon: const Icon(Icons.keyboard_arrow_down),
                  items: city.map((String items) {
                    return DropdownMenuItem(value: items, child: Text(items),);}).toList(),
                  onChanged: (String? newValue) {setState(() {firstCity = newValue!;});},),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 5),
                child: Text("City",style: TextStyle(color: themeColor1),),
              ),
              Container(
                margin: EdgeInsets.symmetric(vertical: 0,horizontal: 0  ),
                padding: EdgeInsets.symmetric(vertical: 10,horizontal: 10),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    border: Border.all(color: themeColor1)
                ),
                child: DropdownButton(
                  isDense: true,
                  underline: Container(),
                  isExpanded: true,
                  value: firstCity, icon: const Icon(Icons.keyboard_arrow_down),
                  items: city.map((String items) {
                    return DropdownMenuItem(value: items, child: Text(items),);}).toList(),
                  onChanged: (String? newValue) {setState(() {firstCity = newValue!;});},),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 5),
                child: Text("Area",style: TextStyle(color: themeColor1),),
              ),
              Container(
                margin: EdgeInsets.symmetric(vertical: 0,horizontal: 0  ),
                padding: EdgeInsets.symmetric(vertical: 10,horizontal: 10),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    border: Border.all(color: themeColor1)
                ),
                child: DropdownButton(
                  isDense: true,
                  underline: Container(),
                  isExpanded: true,
                  value: firstCity, icon: const Icon(Icons.keyboard_arrow_down),
                  items: city.map((String items) {
                    return DropdownMenuItem(value: items, child: Text(items),);}).toList(),
                  onChanged: (String? newValue) {setState(() {firstCity = newValue!;});},),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 5),
                child: Text("Market",style: TextStyle(color: themeColor1),),
              ),
              Container(
                margin: EdgeInsets.symmetric(vertical: 0,horizontal: 0  ),
                padding: EdgeInsets.symmetric(vertical: 10,horizontal: 10),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    border: Border.all(color: themeColor1)
                ),
                child: DropdownButton(
                  isDense: true,
                  underline: Container(),
                  isExpanded: true,
                  value: firstCity, icon: const Icon(Icons.keyboard_arrow_down),
                  items: city.map((String items) {
                    return DropdownMenuItem(value: items, child: Text(items),);}).toList(),
                  onChanged: (String? newValue) {setState(() {firstCity = newValue!;});},),
              ),
              EditTextField(label: "Contact Person 1 Name",hintText: "Altaf",onChange: (value){},controller: controller,),
              EditTextField(label: "Contact person 1 Number",hintText: "+92312345678",onChange: (value){},controller: controller,),
              EditTextField(label: "Contact Person 2 Name",hintText: "Altaf",onChange: (value){},controller: controller,),
              EditTextField(label: "Contact person 2 Number",hintText: "+92312345678",onChange: (value){},controller: controller,),
              Container(
                margin: EdgeInsets.symmetric(vertical: 10),
                decoration: BoxDecoration(
                    color: themeColor1,
                    borderRadius: BorderRadius.circular(5)
                ),
                padding: EdgeInsets.symmetric(vertical: 10,horizontal: 30),
                child: Center(child: Text("Save",style: TextStyle(color: Colors.white,fontSize: 20),)),
              )
            ],
          ),
        ),
      ),
    );
  }
}
