import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:salesmen_app/model/AreaModel.dart';
import 'package:salesmen_app/model/categoryModel.dart';
import 'package:salesmen_app/model/cityModel.dart';
import 'package:salesmen_app/model/countryModel.dart';
import 'package:salesmen_app/model/marketModel.dart';
import 'package:salesmen_app/model/provincesModel.dart';

class OnlineDatabase{

  Future<List<CategoryModel>> getCategory()async{
        var dio = Dio();
    List<CategoryModel>categories=[];
    var response = await dio.get("https://erp.suqexpress.com/api/customercategory");
    for (var category in response.data['data']) {
      categories.add(CategoryModel.fromJson(category));
    }
    return categories;
     }

  Future<List<CountryModel>> getCountries()async{
    List<CountryModel>countries=[];
    var dio = Dio();
    var response = await dio.get("https://erp.suqexpress.com/api/country");
    for (var country in response.data['data']) {
      countries.add(CountryModel.fromJson(country));
    }
    return countries;
  }

  Future<List<ProvincesModel>> getStates(String id)async{
    List<ProvincesModel>states=[];
    var dio = Dio();
    var response =
        await dio.get("https://erp.suqexpress.com/api/state/$id}");
    for (var state in response.data['data']) {
      states.add(ProvincesModel.fromJson(state));
    }
    return states;
  }

  Future<List<CityModel>> getCity(String id)async{
    List<CityModel>cities=[];
    var dio = Dio();
    var response2 = await dio.get("https://erp.suqexpress.com/api/city/$id");
    for (var city in response2.data['data']) {
      cities.add(CityModel.fromJson(city));
    }
    return cities;
  }

  Future<List<AreaModel>> getArea(String id)async{
    List<AreaModel>areas=[];
    var dio = Dio();
    var response3 = await dio.get("https://erp.suqexpress.com/api/area/$id");
    for (var area in response3.data['data']) {
      areas.add(AreaModel.fromJson(area));
    }
    return areas;
  }

  Future<List<MarketModel>> getMarket(String id)async {
    List<MarketModel>markets = [];
    var dio = Dio();
    var response4 = await dio.get("https://erp.suqexpress.com/api/market/$id");
    if (response4.data != null) {
      for (var market in response4.data['data']) {
        markets.add(MarketModel.fromJson(market));
      }
    }
    return markets;
  }
  void getCustomer(String id,onSuccess,onError)async{
    var dio = Dio();
    var response=await dio.get("http://erp.suqexpress.com/api/customer/$id").then(onSuccess).catchError(onError);
  }

}