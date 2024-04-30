
import 'dart:convert';

import 'package:corona_update/Services/Utilities/app_url.dart';
import 'package:http/http.dart' as http;

import '../Model/WorldStateModel.dart';

class StatesServices{

  Future<WorldStateModel> fecthWorldStateRecords () async {

    final response = await http.get(Uri.parse(AppUrl.worldStateApi));

    if(response.statusCode == 200){
      var data = jsonDecode(response.body);
      return WorldStateModel.fromJson(data);

    }else{
      throw Exception('Error');

    }

  }

  Future<List<dynamic>> countriesListApi() async {
    var data;
    final response = await http.get(Uri.parse(AppUrl.countriesList));
  print("respons $response");
    if(response.statusCode == 200){
      data = jsonDecode(response.body);
      print("data 1 is$data");
      return data;

    }else{
      throw Exception('Error');

    }

  }
}