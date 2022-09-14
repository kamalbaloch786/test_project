

import 'dart:convert';

import 'package:http/http.dart' as http;

import 'Language_model.dart';
class Dataservices{
  Map<String, String> getHeaders() {
    return <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
      'accept': 'application/json; charset=UTF-8',
    };
  }
  static var client = http.Client();
  static Future<List<LanguageModel>> getdata() async {
    var response =
    await client.get(Uri.parse('https://631f0e8d58a1c0fe9f5eea32.mockapi.io/language/temp'),headers: {
      'Content-Type': 'application/json; charset=UTF-8',
      'accept': 'application/json; charset=UTF-8',
    });

    if (response.statusCode == 200) {
      var data =  utf8.decode(response.bodyBytes);
      print('cool data ${data}');
      return LangFromJson(data);
    } else {
      var data = response.body;
      return LangFromJson(data);
    }
  }
}