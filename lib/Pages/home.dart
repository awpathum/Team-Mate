import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Home'),
        ),
        body: Center(
          child: Column(
            children: <Widget>[
              Container(
                margin: const EdgeInsets.only(top: 20.0),
                child: SizedBox(
                  width: 300.0,
                  height: 50.0,
                  child: RaisedButton(
                    onPressed: () {},
                    padding: EdgeInsets.all(15.0),
                    child: Text('Create Sheet'),
                  ),
                ),
              ),
            ],
          ),
        ));
  }
}
