import 'package:flutter/material.dart';
import 'package:teamapp/Pages/home.dart';
import 'package:teamapp/Pages/signIn.dart';


void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        //primarySwatch: Colors.blue,
        backgroundColor: Colors.teal[50],
      ),
      home: Home(),
    );
  }
}

