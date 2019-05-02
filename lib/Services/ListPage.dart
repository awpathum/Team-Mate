import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'dart:async';

class ListPage extends StatefulWidget {
  @override
  _ListPageState createState() => _ListPageState();
}

class _ListPageState extends State<ListPage> {
  Future getPosts() async {
    var firestore = Firestore.instance;
    QuerySnapshot qn = await firestore.collection("teamapp").getDocuments();
    print("*");
    return qn.documents;
  }

  @override
  Widget build(BuildContext context) {
    final name = RadioListTile(
      value: false,
      title: Text('Hello'),
      //onChanged: (),
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
            return ListView.builder(
                padding: const EdgeInsets.only(bottom: 20.0),
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                itemCount: snapshot.data.length,
                itemBuilder: (_, index) {
                  return Center(
                    child: SingleChildScrollView(
                      child:  RadioListTile(
                      value: false,
                      title: Text(snapshot.data[index].data["Name"]),
                    ),
                    ),
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
