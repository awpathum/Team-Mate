import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:teamapp/Pages/addNewMember.dart';
import 'package:flutter_calendar/flutter_calendar.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:teamapp/Services/ListPage.dart';

class CreateSheet extends StatefulWidget {
  @override
  _CreateSheetState createState() => _CreateSheetState();
}

class _CreateSheetState extends State<CreateSheet> {
  TextStyle style = TextStyle(
      fontFamily: 'Montserrat', fontSize: 20.0, color: Colors.black54);
  DateTime _date = DateTime.now();
  String strDate;
  String search;


  Future<Null> _selectDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
      context: context,
      initialDate: _date,
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );

    if (picked != null && picked != _date) {
      setState(() {
        _date = picked;
        strDate = _date.toString().substring(0, 10);
        print('Date Selected: ${strDate}');
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final searchText = TextFormField(
      style: style,
      decoration: InputDecoration(hintText: "Enter First Name"),
      onSaved: (input) => search = input,
    );
    final pickedDate = Text(
      'Date Selected: ${strDate}',
      textAlign: TextAlign.center,
      overflow: TextOverflow.ellipsis,
      style: style,
    );
    final pickDateButton = IconButton(
      onPressed: () {
        _selectDate(context);
      },
      tooltip: 'Pick Date',
      icon: Icon(Icons.calendar_today),
      iconSize: 25.0,
    );
    final searchButton = IconButton(
      onPressed: () {},
      tooltip: 'Hit',
      icon: Icon(Icons.search),
      iconSize: 25.0,
    );

    final name = RadioListTile(
      value: false,
      title: Text('Hello'),
      //onChanged: (),
    );

    return Scaffold(
      appBar: AppBar(
        title: Text('Create Sheet'),
      ),
      body: Center(
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.fromLTRB(10.0, 20.0, 10.0, 10.0),
              child: Row(
                children: <Widget>[
                  SizedBox(
                    width: 10.0,
                  ),
                  pickedDate,
                  SizedBox(
                    width: 45.0,
                  ),
                  pickDateButton,
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(10.0, 0.0, 10.0, 20.0),
              child: Row(
                children: <Widget>[
                  SizedBox(
                    width: 10.0,
                  ),
                  Flexible(
                    child: searchText,
                  ),
                  SizedBox(
                    width: 10.0,
                  ),
                  searchButton,
                ],
              ),
            ),
           ListPage(),
            /*Flexible(
              child: SingleChildScrollView(
                child: Column(
                  children: <Widget>[
                    name,
                    name,
                    name,
                    name,
                    name,
                    name,
                    name,
                    name,
                    name,
                    name,
                    name,
                    name,
                  ],
                ),
              ),
            ),*/
          ],
        ),
      ),
    );
  }
}
