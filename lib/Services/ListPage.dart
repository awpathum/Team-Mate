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

class _ListPageState extends State<ListPage> {
  void _onCategorySelected(bool selected, category_id) {
    if (selected == true) {
      setState(() {
        presentMembers.add(category_id);
      });
    } else {
      setState(() {
        presentMembers.remove(category_id);
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
                            .contains(snapshot.data[index].data["Name"]),
                        title: Text(snapshot.data[index].data["Name"]),
                        onChanged: (bool selected) {
                          //markMember(snapshot.data[index].data["Name"]);
                          _onCategorySelected(
                              selected, snapshot.data[index].data["Name"]);
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
