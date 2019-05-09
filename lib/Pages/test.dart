//import 'package:flutter/cupertino.dart';

import 'package:flutter/material.dart';

class notePad extends StatefulWidget {
  @override
  _notePadState createState() => _notePadState();
}

TextStyle style =
    TextStyle(color: Colors.black, fontFamily: 'Montserrat', fontSize: 20.0);

class _notePadState extends State<notePad> {
  @override
  Widget build(BuildContext context) {
    String useFname;
    final fnameField = TextFormField(
      validator: (input) {
        if (input.isEmpty) {
          return 'Please Enter First Name';
        }
      },
      obscureText: false,
      style: style,
      decoration: InputDecoration(
          contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
          hintText: "First Name",
          border:
              OutlineInputBorder(borderRadius: BorderRadius.circular(10.0))),
      onSaved: (input) => useFname = input,
    );
    return Scaffold(
      appBar: AppBar(
        title: Text('Notepad'),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.done),
      ),
      body: Column(
        children: <Widget>[
          
          Container(
              height: 200.0,
              width: 300.0,
              child: Material(
                borderRadius: BorderRadius.circular(0.0),
                shadowColor: Colors.white,
                color: Colors.white,
                elevation: 0.0,
                child: GestureDetector(
                  child: Center(
                    child: TextFormField(
                      
                      style: style,
                    ),
                  ),
                  onTap: () {},
                ),
              )),
        ],
      ),
    );
  }
}
