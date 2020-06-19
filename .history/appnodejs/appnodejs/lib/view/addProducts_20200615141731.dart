import 'package:flutter/material.dart';
import 'package:appnodejs/c'

class AddDataProduct extends StatefulWidget {

AddDataProduct({this.title});
final String title;

  @override
  _AddDataProductState createState() => _AddDataProductState();
  
}

class _AddDataProductState extends State<AddDataProduct> {
  DataBaseHelper dataBaseHelper = new DataBaseHelper();

  final TextEditingController _nameController = new TextEditingController();
  final TextEditingController _priceController = new TextEditingController();
  final TextEditingController _stockController = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
