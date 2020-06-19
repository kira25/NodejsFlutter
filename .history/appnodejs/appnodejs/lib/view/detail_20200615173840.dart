
import 'package:appnodejs/controllers/databasehelpers.dart';
import 'package:flutter/material.dart';

class Detail extends StatefulWidget {
  List list;
  int index;
  Detail({this.index,this.list});
  @override
  _DetailState createState() => _DetailState();
}

class _DetailState extends State<Detail> {

  DataBaseHelper databaseHelper = new DataBaseHelper();


  @override
  Widget build(BuildContext context) {
    return Container(
      
    );
  }
}