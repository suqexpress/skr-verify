import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class OnlineDatabase{

  static Future<dynamic> uploadImage({String? type, var image}) async {
    Dio dio = new Dio();

    var url = 'https://suqexpress.com/api/uploadimage';
    print("Url is: "+url.toString());
    try{
      FormData postData= new FormData.fromMap({
        "type": type,
      });
      postData.files.add(MapEntry("image", image));

      var response = await dio.post(url, data: postData, options:
      Options(contentType: 'multipart/form-data; boundary=1000')
      );
      if(response.statusCode == 200)
        return true;
      else
        return false;

    }catch(e){
      e.toString();
      return false;
    }
  }


}