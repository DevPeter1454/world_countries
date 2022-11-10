import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:world_countries/models/country/country_model.dart';

class ApiServices {
  getAllCountries() async {
    try{
      String url = 'https://restcountries.com/v3.1/all';
    http.Response response = await http.get(Uri.parse(url));
    var jsonResponse = json.decode(utf8.decode(response.bodyBytes));
    // print(jsonResponse);
    var list = [];
    jsonResponse.forEach((element) {
      list.add(Country.fromMap(element));
    });
    return list;
    // var val = list[10].currencies as Map;

    // print(val.values.toList()[0]['name']);
    }catch(e){
      print(e);
    }
  }

  getCountryByName(name)async{
    try{
      String url = 'https://restcountries.com/v3.1/name/$name';
    http.Response response = await http.get(Uri.parse(url));
    var jsonResponse = json.decode(utf8.decode(response.bodyBytes));
    // print(jsonResponse);
    var list = [];
    jsonResponse.forEach((element) {
      list.add(Country.fromMap(element));
    });
    return list;
    }catch(e){
      print(e);
    }
  }
}
