import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:teamapp/Pages/viewProfile.dart';

class selectProfile extends StatefulWidget {
  @override
  _selectProfileState createState() => _selectProfileState();
}

class _selectProfileState extends State<selectProfile> {
  TextStyle style =
      TextStyle(color: Colors.black, fontFamily: 'Montserrat', fontSize: 20.0);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Select Profile'),
      ),
      body: FutureBuilder(
          future: getPosts(),
          builder: (_, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return CircularProgressIndicator();
            } else {
              return Center(
                child: ListView.builder(
                  padding: const EdgeInsets.only(bottom: 20.0),
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  itemCount: snapshot.data.length,
                  itemBuilder: (_, index) {
                    return Center(
                      child: ListTile(
                        contentPadding: const EdgeInsets.only(left: 50.0),
                        leading: const Icon(EvaIcons.person),
                        title: Text(
                          snapshot.data[index].data['Name'],
                          style: style,
                        ),
                        onTap: () {
                          /*var route = MaterialPageRoute(
                            builder: (BuildContext context) => Profile(
                                id : snapshot.data[index].data['IndexNo']),
                          );*/
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => Profile(id : snapshot.data[index].data['IndexNo'])));
                        },
                      ),
                    );
                  },
                ),
              );
            }
          }),
    );
  }

  Future getPosts() async {
    var firestore = Firestore.instance;
    //firestore.collection('teamapp').orderBy(DocumentReference());  // order colllection as Name
    QuerySnapshot qn =
        await firestore.collection('Members').orderBy("Name").getDocuments();
    print("*");
    return qn.documents;
  }
}
