import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'dart:async';

import 'package:flutter/scheduler.dart';
import 'package:teamapp/Pages/createSheet.dart';

class ListPage extends StatefulWidget {
  @override
  _ListPageState createState() => _ListPageState();
}

var presentMembers = Map();
//presentMembers['Date'] = CreateSheet.strDate;

//var presentMembers = {'Date':CreateSheet.strDate};

class _ListPageState extends State<ListPage> {
  void _onCategorySelected(bool selected, name,indexno) {
    if (selected == true) {
      setState(() {
        //presentMembers.add(category_id);
        presentMembers['Name'] = name;
        presentMembers['indexno'] = indexno;
      });
    } else {
      setState(() {
        presentMembers.remove(name);
        presentMembers.remove(indexno);
      });
    }
    print(presentMembers);
  }

  Future getPosts() async {
    var firestore = Firestore.instance;
    QuerySnapshot qn = await firestore.collection("teamapp").getDocuments();
    print("*");
    return qn.documents;
  }

  @override
  Widget build(BuildContext context) {
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
            return ListView.builder(
                padding: const EdgeInsets.only(bottom: 20.0),
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                itemCount: snapshot.data.length,
                itemBuilder: (_, index) {
                  return Center(
                    child: CheckboxListTile(
                        value: presentMembers
                            .containsValue(snapshot.data[index].data["Name"]),
                        title: Text(snapshot.data[index].data["Name"]),
                        onChanged: (bool selected) {
                          //markMember(snapshot.data[index].data["Name"]);
                          _onCategorySelected(
                              selected, snapshot.data[index].data["Name"],snapshot.data[index].data["IndexNo"]);
                        }),
                  );
                  /* return ListTile(
                    title: Expanded(
                      child: Text(snapshot.data[index].data["Name"]),
                    ),
                  );*/
                });
          }
        },
      ),
    );
  }
}
