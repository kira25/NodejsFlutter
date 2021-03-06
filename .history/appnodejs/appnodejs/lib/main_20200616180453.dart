import 'package:appnodejs/notifiers/product_data.dart';
import 'package:appnodejs/view/addProducts.dart';
import 'package:appnodejs/view/listProducts.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:provider/provider.dart';

import 'package:appnodejs/view/login_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [ChangeNotifierProvider(create: (_) => ProductData())],
      child: MaterialApp(
          title: 'Flutter Demo',
          theme: ThemeData(
            primarySwatch: Colors.blue,
            visualDensity: VisualDensity.adaptivePlatformDensity,
          ),
          home: MainPage()),
    );
  }
}

class MainPage extends StatelessWidget {
  SharedPreferences sharedPreferences;

  @override
  Widget build(BuildContext context) {
    checkLoginStatus() async {
      sharedPreferences = await SharedPreferences.getInstance();
      if (sharedPreferences.getString('token') == null) {
        Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(builder: (BuildContext context) => LoginPage()),
            (Route<dynamic> route) => false);
      }
    }

    final productState = Provider.of<ProductData>(context);
    print(productState.getResponseText);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Node&Flutter',
          style: TextStyle(color: Colors.white),
        ),
        actions: <Widget>[
          FlatButton(
              onPressed: () {
                sharedPreferences.clear();

                Navigator.of(context).pushAndRemoveUntil(
                    MaterialPageRoute(
                        builder: (BuildContext context) => LoginPage()),
                    (Route<dynamic> route) => false);
              },
              child: Text(
                'Logout',
                style: TextStyle(color: Colors.white),
              ))
        ],
      ),
      body: Center(
          child: productState.isFetching
              ? CircularProgressIndicator()
              : productState.getResponseJson() != null
                  ? ListView.builder(
                      itemCount: productState.getResponseJson().length,
                      itemBuilder: (context, index) {
                        return ListTile(
                          title: productState.getResponseJson()[index]['name'],
                        );
                      })
                  : Text('No fetching data')),
      drawer: Drawer(
        child: new ListView(
          children: <Widget>[
            new UserAccountsDrawerHeader(
                accountName: new Text('NodeFlutter'),
                accountEmail: Text('erick.gutierrez@pucp.pe')),
            new ListTile(
              title: Text('List Products'),
              trailing: new Icon(Icons.list),
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (BuildContext context) => ListProductState()));
              },
            ),
            new ListTile(
              title: Text('Add Products'),
              trailing: new Icon(Icons.add),
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (BuildContext context) => AddDataProduct()));
              },
            ),
            new ListTile(
              title: Text('Register user'),
              trailing: new Icon(Icons.account_circle),
              onTap: () {},
            )
          ],
        ),
      ),
    );
  }
}
