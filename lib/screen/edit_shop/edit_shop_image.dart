import 'dart:io';

import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:salesmen_app/others/style.dart';

class EditShopImage extends StatefulWidget {
  @override
  State<EditShopImage> createState() => _EditShopImageState();
}

class _EditShopImageState extends State<EditShopImage> {
  XFile? image;
  final ImagePicker _picker = ImagePicker();
  bool loading=false;
  getImage(ImageSource source)async{
    setState(() {
      loading=true;
    });
    var camera=await Permission.camera.request();
    var gallery=await Permission.storage.request();
    final XFile? pickedFile = await _picker.pickImage(
      source: source,
      maxWidth: 512,
      maxHeight: 512,
      imageQuality: 100,
    );
    setState(() {
      image=pickedFile;
      print(image!.path);
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
          child: Container(
        child: Column(
          children: [
            UploadImageCard(
              title: "Owner",
              onCamera:()=> getImage(ImageSource.camera),
              onGallery: ()=> getImage(ImageSource.gallery),
            ),
            Container(
              width: 100,
              height: 100,
              color: Colors.red,
              child:loading?Image.file(File(image!.path)):Container() ,
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
      )),
    );
  }
}







class UploadImageCard extends StatefulWidget {
  UploadImageCard({this.title, this.onCamera, this.onGallery,});
  final title;
  final onCamera;
  final onGallery;


  @override
  _UploadImageCardState createState() => _UploadImageCardState();
}

class _UploadImageCardState extends State<UploadImageCard> {
  bool camera=false;

  bool gallery=false;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (){
        setState(() {
          camera=camera?false:true;
          gallery=false;
        });
      },
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 15, horizontal: 0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              child: Text(
                widget.title,
                style: TextStyle(color: themeColor1, fontSize: 18),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Flexible(
                  child: Container(
                    margin: EdgeInsets.symmetric(horizontal: 10),
                    child: InkWell(
                      onTap: widget.onCamera,
                      child: Container(
                        child: DottedBorder(
                          color: camera?themeColor1:Colors.grey,
                          radius: Radius.circular(10),
                          child: Container(
                            padding:
                                EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Column(
                              children: [
                                Image.asset(
                                  "assets/icons/camera.png",
                                  scale: 8,
                                  color: camera?themeColor1:Colors.grey,
                                ),
                                Text(
                                  "Upload Image From camera",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      color: Colors.black.withOpacity(0.7)),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                Flexible(
                  child: Container(
                    margin: EdgeInsets.symmetric(horizontal: 10),
                    child: InkWell(
                      onTap: widget.onGallery,
                      child: Container(
                        child: DottedBorder(
                          color: gallery?themeColor1:Colors.grey,
                          radius: Radius.circular(10),
                          child: Container(
                            padding:
                                EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Column(
                              children: [
                                Image.asset(
                                  "assets/icons/gallery.png",
                                  scale: 8,
                                  color: gallery?themeColor1:Colors.grey,
                                ),
                                Text(
                                  "Upload Image From gallery",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      color: Colors.black.withOpacity(0.7)),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}


