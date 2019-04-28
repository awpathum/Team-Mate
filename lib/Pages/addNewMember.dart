import 'package:flutter/material.dart';

class addNewMember extends StatefulWidget {
  @override
  _addNewMemberState createState() => _addNewMemberState();
}

class _addNewMemberState extends State<addNewMember> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add New Member'),
      ),
      body: Center(
        child: Column(
          children: <Widget>[
            Container(
              margin: const EdgeInsets.all(20.0),
              child: Row(
                children: <Widget>[
                  Text(
                    //'Hello, $_name! How are you?',
                    'Index Number',
                    textAlign: TextAlign.left,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
