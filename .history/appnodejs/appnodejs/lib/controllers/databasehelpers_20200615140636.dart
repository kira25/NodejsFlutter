import 'dart:convert';

import 'package:http/http.dart' as http;

import 'package:shared_preferences/shared_preferences.dart';

class DataBaseHelper {
  var status;
  var token;
  String serverUrlproducts = "http://192.168.1.9:3000/products";

//function to register a new product
  void addDataProduct(String _nameController, String _stockController) async {
    final prefs = await SharedPreferences.getInstance();
    final key = 'token';
    final value = prefs.get(key) ?? 0;

    String myUrl = "$serverUrlproducts";
    final response = await http.post(myUrl,
        headers: {'Accept': 'application/json'},
        body: {'name': "$_nameController", 'stock': "$_stockController"});

    status = response.body.contains('error');

    var data = json.decode(response.body);

    if (status) {
      print('data : ${data['error']}');
    } else {
      print('data : ${data['token']}');
      _save(data['token']);
    }
  }

  _save(String token) async {
    final prefs = await SharedPreferences.getInstance();
    final key = 'token';
    final value = token;
    prefs.setString(key, value);
  }

  read() async {
    final prefs = await SharedPreferences.getInstance();
    final key = 'token';
    final value = prefs.get(key) ?? 0;
    print('read : $value');
  }
}
