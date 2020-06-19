import 'dart:convert';

import 'package:appnodejs/main.dart';
import 'package:appnodejs/view/detail.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ListProductState extends StatefulWidget {
  @override
  _ListProductStateState createState() => _ListProductStateState();
}

class _ListProductStateState extends State<ListProductState> {
  List data;

  Future<List> getData() async {
    final response = await http.get("http://192.168.1.9:3000/products");
    return json.decode(response.body);
  }

  @override
  void initState() {
    super.initState();
    this.getData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: <Widget>[
          IconButton(
              icon: Icon(Icons.arrow_back),
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => MainPage()));
              })
        ],
        title: Text('Listview Products'),
      ),
      body: Column(
        children: <Widget>[
          new FutureBuilder<List>(
              future: getData(),
              builder: (context, snapshot) {
                if (snapshot.hasError) print(snapshot.error);
                return snapshot.hasData
                    ? new ItemList(
                        list: snapshot.data,
                      )
                    : new Center(
                        child: CircularProgressIndicator(),
                      );
              }),
        ],
      ),
    );
  }
}

class ItemList extends StatelessWidget {
  final List list;
  ItemList({this.list});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: list == null ? 0 : list.length,
      itemBuilder: (context, index) {
        return Container(
            padding: EdgeInsets.all(10.0),
            child: GestureDetector(
              onTap: () => Navigator.of(context).push(MaterialPageRoute(
                  builder: (BuildContext context) =>
                      Detail(list: list, index: index))),
              child: new Card(
                child: new ListTile(
                  title: new Text(
                    list[index]['name'].toString(),
                    style: TextStyle(
                      fontSize: 25.0,
                      color: Colors.orangeAccent,
                    ),
                  ),
                ),
              ),
            ));
      },
    );
  }
}
