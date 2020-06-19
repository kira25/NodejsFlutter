import 'dart:convert';

import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;

class ProductData extends ChangeNotifier {
  String myurl = "http://192.168.1.9:3000/products";
  List _productList = [];
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

  bool get isFetching => _isFetching;

  set productList(List products) {
    _productList = products;
  }

  List get currentProductList => _productList;

  List<dynamic> getResponseJson() {
    if (_jsonResponse.isNotEmpty) {
      List json = jsonDecode(_jsonResponse);
      return json;
    }
    return null;
  }
}
