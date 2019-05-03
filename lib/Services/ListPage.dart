import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'dart:async';
import 'package:flutter/scheduler.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:teamapp/Pages/createSheet.dart';
import 'package:teamapp/Services/crud.dart';

class ListPage extends StatefulWidget {
  @override
  _ListPageState createState() => _ListPageState();
}

//var presentMembers = Map();
//Map<List<String>, List<String>> attendanceSheet = new Map<List<String>, List<String>>();
List<String> names = new List<String>();
List<String> index = new List<String>();

//presentMembers['Date'] = CreateSheet.strDate;

//var presentMembers = {'Date':CreateSheet.strDate};

class _ListPageState extends State<ListPage> {
  // crudMethods crudObj = new crudMethods();
  void _onCategorySelected(bool selected, name, indexno) {
    if (selected == true) {
      setState(() {
        //presentMembers.add(category_id);
        names.add(name);
        index.add(indexno);
        //attendanceSheet.addAll("",names);
        //presentMembers['Name'] = name;
        //presentMembers['indexno'] = indexno;
      });
    } else {
      setState(() {
        names.remove(name);
        index.remove(indexno);
        //presentMembers.remove(name);
        //presentMembers.remove(indexno);
      });
    }
    print(names);
    print(index);
  }

  Future getPosts() async {
    var firestore = Firestore.instance;
    QuerySnapshot qn = await firestore.collection('teamapp').getDocuments();
    print("*");
    return qn.documents;
  }

  Future uploadData() async {
    Map<String, List<String>> attendanceSheet = {
      'Names': names,
      'Index': index,
    };
var getDate = CreateSheetState();
String date = getDate.strDate;
    //Firestore.instance.collection('teamapp').add(memberDetails).catchError((e){
    //print(e);
    //String today = CreateSheet.strDate;
    //print(today);
    Firestore.instance.collection('today').document(date).setData(attendanceSheet).then((result){
      print(date);
       Fluttertoast.showToast(
          msg: "Done",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIos: 1,
          backgroundColor: Colors.black54,
          textColor: Colors.white,
          fontSize: 16.0);
    }).catchError((e){
      print(e);
    });
    /*Firestore.instance
        .collection('today')
        .add(attendanceSheet)
        .catchError((e) {
      print(e);
    });*/
  }

  @override
  Widget build(BuildContext context) {
    final submitButton = Material(
      elevation: 5.0,
      borderRadius: BorderRadius.circular(30.0),
      color: Color(0xff01A0C7),
      child: FloatingActionButton(
        elevation: 5.0,
        onPressed: () {
          uploadData();
          /* final FormState = _formKey.currentState;

          if (FormState.validate()) {
            uploadData();
          }*/
        },
        child: Icon(Icons.check),
      ),
    );
    return Container(
      child: FutureBuilder(
        future: getPosts(),
        builder: (_, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: Text("Loading"),
            );
          } else {
            // final nameList = snapshot.data["Name"];
            //print(nameList);
            return Column(
              children: <Widget>[
                ListView.builder(
                    padding: const EdgeInsets.only(bottom: 20.0),
                    scrollDirection: Axis.vertical,
                    shrinkWrap: true,
                    itemCount: snapshot.data.length,
                    itemBuilder: (_, index) {
                      return Center(
                        child: CheckboxListTile(
                            value: names
                                .contains(snapshot.data[index].data["Name"]),
                            title: Text(snapshot.data[index].data["Name"]),
                            onChanged: (bool selected) {
                              //markMember(snapshot.data[index].data["Name"]);
                              _onCategorySelected(
                                  selected,
                                  snapshot.data[index].data["Name"],
                                  snapshot.data[index].data["IndexNo"]);
                            }),
                      );
                    }),
                Column(
                  children: <Widget>[
                    SizedBox(
                      height: 120,
                    ),
                    Row(
                      children: <Widget>[
                        SizedBox(
                          width: 290,
                        ),
                        submitButton,
                      ],
                    ),
                  ],
                ),
              ],
            );
          }
        },
      ),
    );
  }
}
