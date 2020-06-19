import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class _ListProductState extends StatefulWidget {
  @override
  __ListProductStateState createState() => __ListProductStateState();
}

class __ListProductStateState extends State<_ListProductState> {
  List data;

  Future<List> getData() async {
    final response = await http.get("http://192.168.1.9:3000/signin");
    return json.decode(response.body);
  }

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
