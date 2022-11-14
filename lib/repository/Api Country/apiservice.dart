import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:http/http.dart' as http;
import 'package:world_countries/models/country/country_model.dart';
import 'package:world_countries/repository/Api%20Country/error_handle.dart';
import 'package:world_countries/repository/Api%20Country/snack_bar.dart';

class ApiServices {
  getAllCountries() async {
    try {
      String url = 'https://restcountries.com/v3.1/all';
      http.Response response = await http.get(Uri.parse(url));
      var jsonResponse = json.decode(utf8.decode(response.bodyBytes));
      // print(jsonResponse);
      var list = [];
      jsonResponse.forEach((element) {
        list.add(Country.fromMap(element));
      });

      return {'data': list, 'length': list.length};

      // var val = list[10].currencies as Map;

      // print(val.values.toList()[0]['name']);
    } catch (e) {
      EasyLoading.showError('Something went wrong... ');
    }
  }

  getCountryByName(String name) async {
    try {
      String url = 'https://restcountries.com/v3.1/name/$name';
      http.Response response = await http.get(Uri.parse(url));
      var jsonResponse = json.decode(utf8.decode(response.bodyBytes));
      // print(jsonResponse);
      var list = [];
      jsonResponse.forEach((element) {
        list.add(Country.fromMap(element));
      });
      if (list.isEmpty) {
        EasyLoading.showError('No data found');
      } else {
        return {'data': list, 'length': list.length};
      }
    } catch (e) {
      EasyLoading.showError('Something went wrong...');
    }
  }

  getCountryByRegion(List region) async {
    try {
      var list = [];
      for (var i = 0; i < region.length; i++) {
        String url = 'https://restcountries.com/v3.1/region/${region[i]}';
        http.Response response = await http.get(Uri.parse(url));
        var jsonResponse = json.decode(utf8.decode(response.bodyBytes));
        // print(jsonResponse);
        jsonResponse.forEach((element) {
          list.add(Country.fromMap(element));
        });
      }

      return {'data': list, 'length': list.length};
    } catch (e) {
      EasyLoading.showError('Something went wrong...');
    }
  }

    Future getCountriesByContinent(List continent) async {
      try {
        var list = [];

        String url = 'https://restcountries.com/v3.1/all';
        http.Response response = await http.get(Uri.parse(url));
        var jsonResponse = json.decode(utf8.decode(response.bodyBytes));
        // print(jsonResponse);

        jsonResponse.forEach((element) {
          list.add(Country.fromMap(element));
        });

        var continentList = [];
        for (var i = 0; i < continent.length; i++) {
          continentList.add(list
              .where((element) => element.continent == continent[i])
              .toList());
        }
        if (continentList.isEmpty) {
          EasyLoading.showError('No data found');
        } else {
          return {'data': continentList, 'length': continentList.length};
        }
      } catch (e) {
        EasyLoading.showError('Something went wrong...');
      }
    }
}
