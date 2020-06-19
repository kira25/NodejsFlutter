import 'dart:convert';

import 'package:appnodejs/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool _isloading = false;
  bool _isregistered = false;

  final TextEditingController emailController = new TextEditingController();
  final TextEditingController passwordController = new TextEditingController();
  final TextEditingController usernameController = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light
        .copyWith(statusBarColor: Colors.transparent));
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [Colors.blue, Colors.teal])),
        child: _isloading
            ? Center(
                child: CircularProgressIndicator(),
              )
            : ListView(
                children: <Widget>[
                  heardSection(),
                  textSection(),
                  buttonSection(),
                ],
              ),
      ),
    );
  }

  signIn(String email, pass) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    Map data = {'email': email, 'password': pass};
    var jsonResponse = null;

    var response =
        await http.post("http://192.168.1.9:3000/signin", body: data);
    if (response.statusCode == 200) {
      jsonResponse = json.decode(response.body);
      print('Response status: ${response.statusCode}');
      print('Response body: ${response.body}');
      if (jsonResponse != null) {
        setState(() {
          _isloading = false;
        });
        sharedPreferences.setString("token", jsonResponse['token']);
        Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(builder: (BuildContext context) => MainPage()),
            (Route<dynamic> route) => false);
      }
    } else {
      setState(() {
        _isloading = false;
      });
      print(response.body);
    }
  }

  signUp(String username, email, pass) {}

  Column buttonSection() {
    return Column(
      children: <Widget>[
        Container(
          width: MediaQuery.of(context).size.width,
          height: 40.0,
          padding: EdgeInsets.symmetric(horizontal: 15.0),
          child: RaisedButton(
            onPressed: () {
              emailController.text == "" ||
                      passwordController.text == "" ||
                      _isregistered == false
                  ? null
                  : () {
                      setState(() {
                        _isloading = true;
                      });
                      signIn(emailController.text, passwordController.text);
                    };

              emailController.text == "" ||
                      passwordController.text == "" ||
                      _isregistered == true
                  ? null
                  : () {
                      setState(() {
                        _isloading = true;
                      });
                      signUp(usernameController.text, emailController.text,
                          passwordController);
                    };
            },
            elevation: 0.8,
            color: Colors.purple,
            child: Text(
              _isregistered ? "Sign up" : "Sig In",
              style: TextStyle(color: Colors.white70),
            ),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5.0)),
          ),
        ),
        SizedBox(
          height: 20.0,
        ),
        GestureDetector(
          onTap: () {
            setState(() {
              _isregistered = !_isregistered;
            });
          },
          child: !_isregistered
              ? Text('Not registered? Create an account')
              : Text('Already have an account?, go and sign in'),
        )
      ],
    );
  }

  Container textSection() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 15.0, vertical: 20.0),
      child: Column(
        children: <Widget>[
          _isregistered
              ? TextField(
                  controller: emailController,
                  cursorColor: Colors.white,
                  style: TextStyle(
                    color: Colors.white70,
                  ),
                  decoration: InputDecoration(
                      icon: Icon(
                        Icons.account_box,
                        color: Colors.white70,
                      ),
                      hintText: "Username",
                      border: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.white70)),
                      hintStyle: TextStyle(color: Colors.white)),
                )
              : SizedBox(),
          TextField(
            controller: emailController,
            cursorColor: Colors.white,
            style: TextStyle(
              color: Colors.white70,
            ),
            decoration: InputDecoration(
                icon: Icon(
                  Icons.email,
                  color: Colors.white70,
                ),
                hintText: "Email",
                border: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.white70)),
                hintStyle: TextStyle(color: Colors.white)),
          ),
          SizedBox(
            height: 20.0,
          ),
          TextField(
            obscureText: true,
            controller: passwordController,
            cursorColor: Colors.white,
            style: TextStyle(
              color: Colors.white70,
            ),
            decoration: InputDecoration(
                icon: Icon(
                  Icons.lock,
                  color: Colors.white70,
                ),
                hintText: "Password",
                border: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.white70)),
                hintStyle: TextStyle(color: Colors.white)),
          ),
        ],
      ),
    );
  }

  Container heardSection() {
    return Container(
      margin: EdgeInsets.only(top: 50.0),
      padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 30.0),
      child: Text(
        'Node JS Flutter',
        style: TextStyle(
            color: Colors.white70, fontSize: 40.0, fontWeight: FontWeight.bold),
      ),
    );
  }
}
