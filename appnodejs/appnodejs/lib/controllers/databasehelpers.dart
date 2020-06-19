import 'dart:convert';

import 'package:http/http.dart' as http;

import 'package:shared_preferences/shared_preferences.dart';

class DataBaseHelper {
  var status;
  var token;
  String serverUrlproducts = "http://192.168.1.9:3000/products";



   Future<List> getData() async {
    final response = await http.get("http://192.168.1.9:3000/products");
    var data = json.decode(response.body);
    print(data);

    return json.decode(response.body);
  }

//function to register a new product
  void addDataProduct(String _nameController, String _stockController,
      String _priceController) async {
    final prefs = await SharedPreferences.getInstance();
    final key = 'token';
    final value = prefs.get(key) ?? 0;

    String myUrl = "$serverUrlproducts";
    final response = await http.post(myUrl, headers: {
      'Accept': 'application/json'
    }, body: {
      'name': "$_nameController",
      'stock': "$_stockController",
      'price': "$_priceController"
    });

    status = response.body.contains('error');

    var data = json.decode(response.body);

    if (status) {
      print('data : ${data['error']}');
    } else {
      print('data : ${data['data']['name']}');
      _save(data['token']);
    }
  }

  //function for update or put
  void editarProduct(
      String _id, String name, String price, String stock) async {
    final prefs = await SharedPreferences.getInstance();
    final key = 'token';
    final value = prefs.get(key) ?? 0;

    String myUrl = "http://192.168.1.9:3000/product/$_id";
    http.put(myUrl, body: {
      "name": "$name",
      "price": "$price",
      "stock": "$stock"
    }).then((response) {
      print('Response status : ${response.statusCode}');
      print('Response body : ${response.body}');
    });
  }

  //function for delete
  Future<void> removeRegister(String _id) async {
    String myUrl = "http://192.168.1.9:3000/product/$_id";

    http.Response res = await http.delete("$myUrl");

    if (res.statusCode == 200) {
      print("DELETED");
    } else {
      throw "Can't delete post.";
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
