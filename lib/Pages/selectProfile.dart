import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:teamapp/Pages/home.dart';
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
    final div = Divider(
      height: 10.0,
      color: Colors.grey[400],
      indent: 70.0,
    );
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(
            EvaIcons.arrowBackOutline,
          ),
          color: Colors.white,
          onPressed: () {
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => Home()));
          },
        ),
        title: Text(
          'Select Profile',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Color(0xff88498f),
      ),
      body: FutureBuilder(
          future: getPosts(),
          builder: (_, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else {
              return ListView.builder(
                padding: const EdgeInsets.only(bottom: 20.0),
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                itemCount: snapshot.data.length,
                itemBuilder: (_, index) {
                  print(snapshot.data[index].data['Profilepic']);
                  if (snapshot.data[index].data['Profilepic'] != null) {
                    return Column(
                      children: <Widget>[
                        SizedBox(
                          height: 30.0,
                        ),
                        ListTile(
                          contentPadding: const EdgeInsets.only(left: 20.0),
                          leading: Container(
                              width: 70.0,
                              height: 70.0,
                              decoration: BoxDecoration(
                                  color: Colors.red,
                                  image: DecorationImage(
                                      image: NetworkImage(snapshot
                                          .data[index].data['Profilepic']),
                                      fit: BoxFit.cover),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(75.0)),
                                  boxShadow: [
                                    BoxShadow(
                                        blurRadius: 7.0, color: Colors.black)
                                  ])),
                          title: Text(
                            snapshot.data[index].data['Name'],
                            style: style,
                          ),
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => Profile(
                                        id: snapshot
                                            .data[index].data['IndexNo'])));
                          },
                        ),
                        div,
                      ],
                    );
                  } else {
                    return Column(
                      children: <Widget>[
                        ListTile(
                          contentPadding: const EdgeInsets.only(left: 20.0),
                          leading: Icon(EvaIcons.person),
                          title: Text(
                            snapshot.data[index].data['Name'],
                            style: style,
                          ),
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => Profile(
                                        id: snapshot
                                            .data[index].data['IndexNo'])));
                          },
                        ),
                        div,
                      ],
                    );
                  }
                },
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

    return qn.documents;
  }
}
