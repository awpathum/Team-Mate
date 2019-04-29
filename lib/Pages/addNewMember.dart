import 'package:flutter/material.dart';

class addNewMember extends StatefulWidget {
  @override
  _addNewMemberState createState() => _addNewMemberState();
}

class _addNewMemberState extends State<addNewMember> {
  TextStyle style = TextStyle(fontFamily: 'Montserrat', fontSize: 20.0);
  String _indexNo, _nicNo, _name, _faculty, _year, _telephone;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {

    final indexField = TextFormField(
      validator: (input) {
        if (input.isEmpty) {
          return 'Please Enter Index Number';
        }
      },
      obscureText: false,
      style: style,
      decoration: InputDecoration(
          contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
          hintText: "Index Number",
          border:
              OutlineInputBorder(borderRadius: BorderRadius.circular(32.0))),
      onSaved: (input) => _indexNo = input,
    );

    final nicField = TextFormField(
      validator: (input) {
        if (input.isEmpty) {
          return 'Please Enter NIC Number';
        }
      },
      obscureText: false,
      style: style,
      decoration: InputDecoration(
          contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
          hintText: "NIC Number",
          border:
              OutlineInputBorder(borderRadius: BorderRadius.circular(32.0))),
      onSaved: (input) => _nicNo = input,
    );

    final nameField = TextFormField(
      validator: (input) {
        if (input.isEmpty) {
          return 'Please Enter The Name';
        }
      },
      obscureText: false,
      style: style,
      decoration: InputDecoration(
          contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
          hintText: "Name",
          border:
              OutlineInputBorder(borderRadius: BorderRadius.circular(32.0))),
      onSaved: (input) => _name = input,
    );

    final facultyField = TextFormField(
      validator: (input) {
        if (input.isEmpty) {
          return 'Please Enter The Faculty';
        }
      },
      obscureText: false,
      style: style,
      decoration: InputDecoration(
          contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
          hintText: "Faculty",
          border:
              OutlineInputBorder(borderRadius: BorderRadius.circular(32.0))),
      onSaved: (input) => _faculty = input,
    );

    final yearField = TextFormField(
      validator: (input) {
        if (input.isEmpty) {
          return 'Please Enter The Year';
        }
      },
      obscureText: false,
      style: style,
      decoration: InputDecoration(
          contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
          hintText: "Year",
          border:
              OutlineInputBorder(borderRadius: BorderRadius.circular(32.0))),
      onSaved: (input) => _year = input,
    );

    final telephoneField = TextFormField(
      validator: (input) {
        if (input.isEmpty) {
          return 'Please Enter Contact Number';
        }
      },
      obscureText: false,
      style: style,
      decoration: InputDecoration(
          contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
          hintText: "Telephone",
          border:
              OutlineInputBorder(borderRadius: BorderRadius.circular(32.0))),
      onSaved: (input) => _telephone = input,
    );
    return Scaffold(
      appBar: AppBar(
        title: Text('Add New Member'),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Container(
            color: Colors.white,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(10.0, 20.0, 10.0, 50.0),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    SizedBox(
                          height: 12.0,
                        ),
                        indexField,
                        SizedBox(
                          height: 45.0,
                        ),
                        nicField,
                        SizedBox(
                          height: 45.0,
                        ),
                        nameField,
                        SizedBox(
                          height: 45.0,
                        ),
                        facultyField,
                        SizedBox(
                          height: 45.0,
                        ) ,
                        yearField,
                        SizedBox(
                          height: 45.0,
                        ),
                        telephoneField,
                  ],
                ),
              )
            ),
          ),
        ),
      ),
    );
  }
}
