import 'dart:convert';

import 'package:appnodejs/models/product.dart';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;

class ProductData extends ChangeNotifier {
  String myurl = "http://192.168.1.9:3000/products";
  Product product;
  List<Product> products;
  String errorMessage;
  bool _isFetching = false;

  Future<List<Product>> getData() async {
    _isFetching = true;
    final response = await http.get(myurl);
    if (response.statusCode == 200) {
      Iterable list = json.decode(response.body);
      setProductList(list);
      
    } else {
      Map<String, dynamic> result = json.decode(response.body);
      setMessage(result['message']);
    }
    _isFetching = false;
    return getListProduct();
  }

  // String get getResponseText => _jsonResponse;

  bool get isFetching => _isFetching;

  void setProductList(Iterable list) {
    products =  list.map((model) => Product.fromMap(model)).toList();
  }

  void setProduct(value) {
    product = value;
    notifyListeners();
  }

  void setMessage(result) {
    errorMessage = result;
    notifyListeners();
  }

  String getMessage() {
    return errorMessage;
  }

  bool isProduct() {
    return product != null ? true : false;
  }

  Product getProduct() {
    return product;
  }

  List<Product> getListProduct() {
    return products;
  }
}
