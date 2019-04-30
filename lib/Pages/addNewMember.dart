import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:async';
import 'package:teamapp/Services/crud.dart';
import 'package:fluttertoast/fluttertoast.dart';
//import 'package:teamapp/Services/crud.dart';

class addNewMember extends StatefulWidget {
  @override
  _addNewMemberState createState() => _addNewMemberState();
}

class _addNewMemberState extends State<addNewMember> {
  crudMethods crudObj = new crudMethods();
  File _image;
  TextStyle style = TextStyle(fontFamily: 'Montserrat', fontSize: 20.0);
  String _indexNo, _nicNo, _name, _faculty, _year, _telephone;
  final _formKey = GlobalKey<FormState>();
  //final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
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

    final submitButton = Material(
      elevation: 5.0,
      borderRadius: BorderRadius.circular(30.0),
      color: Color(0xff01A0C7),
      child: FloatingActionButton(
        elevation: 5.0,
        onPressed: () {
          //Navigator.of(context).pop();
          _formKey.currentState.save();
          Map<String, String> memeberDetails = {
            'IndexNo': this._indexNo,
            'NIC': this._nicNo,
            'Name': this._name,
            'Faculty': _faculty,
            'Year': this._year,
            'Telephone': this._telephone
          };
          crudObj.addData(memeberDetails).then((result) {
            _formKey.currentState.reset();
            Fluttertoast.showToast(
                msg: "Done",
                toastLength: Toast.LENGTH_SHORT,
                gravity: ToastGravity.CENTER,
                timeInSecForIos: 1,
                backgroundColor: Colors.black54,
                textColor: Colors.white,
                fontSize: 16.0);
          }).catchError((e) {
            print(e);
          });
        },
        child: Icon(Icons.check),
      ),
    );

    final imageField = Row(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.all(10.0),
          child:
              _image == null ? Text('No image selected.') : Image.file(_image),
        ),
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: IconButton(
            onPressed: getImage,
            tooltip: 'Pick Image',
            icon: Icon(Icons.add_a_photo),
            iconSize: 40.0,
          ),
        ),
      ],
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
                      ),
                      yearField,
                      SizedBox(
                        height: 45.0,
                      ),
                      telephoneField,
                      SizedBox(
                        height: 45.0,
                      ),
                      Row(
                        children: <Widget>[
                          imageField,
                          SizedBox(
                            width: 68.0,
                          ),
                          submitButton,
                        ],
                      )
                    ],
                  ),
                )),
          ),
        ),
      ),
    );
  }

  Future getImage() async {
    var image = await ImagePicker.pickImage(source: ImageSource.camera);
    setState(() {
      _image = image;
    });
  }
}
