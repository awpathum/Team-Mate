import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'dart:async';

import 'package:flutter/scheduler.dart';

class ListPage extends StatefulWidget {
  @override
  _ListPageState createState() => _ListPageState();
}

var presentMembers = new List();
bool marked = false;

class _ListPageState extends State<ListPage> {
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
                        value: timeDilation != 1.0,
                        title: Text(snapshot.data[index].data["Name"]),
                        onChanged: (bool value) {
                          markMember(snapshot.data[index].data["Name"]);
                           setState(() { timeDilation = value ? 2.0 : 1.0; });
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

  markMember(String name) {
    if (marked == true) {
      presentMembers.add(name);
      print(presentMembers);
    }
    else{
      presentMembers.remove(name);
      print(presentMembers);
    }
  }
}
