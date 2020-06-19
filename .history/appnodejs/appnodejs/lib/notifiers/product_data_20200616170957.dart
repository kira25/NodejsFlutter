import 'dart:convert';

import 'package:appnodejs/models/product.dart';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;

class ProductData extends ChangeNotifier {

  String myurl = "http://192.168.1.9:3000/products";
  List<Product> _product = [];
  String _jsonResponse = "";
  bool _isFetching = false;

  Future<void> getData() async {
    _isFetching = true;
    final response = await http.get(myurl);
    if (response.statusCode == 200) {
      _jsonResponse = response.body;
    }
    _isFetching = false;
    notifyListeners();
  }

  String get getResponseText => _jsonResponse;

  List<dynamic> getResponseJson() {
    if (_jsonResponse.isNotEmpty) {
      Map<String, dynamic> json = jsonDecode(_jsonResponse);
      return json['data'];
    }
    return null;
  }
}
