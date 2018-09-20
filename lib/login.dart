import 'package:flutter/material.dart';
import 'package:hello_world/zone.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final email = TextEditingController();
  final password = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: new AppBar(
          title: const Text('Login'),
        ),
        body: Container(
          padding: EdgeInsets.all(10.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              TextFormField(
                decoration: InputDecoration(labelText: 'Enter your email'),
                key: widget.key,
                controller: email,
              ),
              new TextFormField(
                key: widget.key,
                decoration: InputDecoration(labelText: 'Enter your password'),
                controller: password,
              ),
              Container(
                  margin: EdgeInsets.only(top: 10.0),
                  child: ButtonTheme(
                      minWidth: double.infinity,
                      child: new RaisedButton(
                          child: Text("Login"), onPressed: doLogin)))
            ],
          ),
        ));
  }

  doLogin() {
    Map<String, String> map = {
      "email": email.text,
      "password": password.text
    };

    http
        .post("http://192.168.43.118:8000/api/auth/login", body: map)
        .then((response) {
      if (response.statusCode == 401) {
        return showMessageDialog("Invalid email or password");
      }

      final decoded = json.decode(response.body);
      
      Navigator.of(context).push(new MaterialPageRoute(
        builder: (BuildContext context) {
          return new ZoneList();
        }
      ));

    }).catchError((error) {
      print("errror =====>" + error);
    });
  }

  showMessageDialog(String message) {
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          content: Text(message),
        );
      },
    );
  }
}
