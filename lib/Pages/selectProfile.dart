import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

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
        builder: (_,snapshot){
          if(snapshot.connectionState == ConnectionState.waiting){
            return CircularProgressIndicator();
          }else{
            return Center(
              child: ListView.builder(
                padding: const EdgeInsets.only(bottom: 20.0),
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                itemCount: snapshot.data.length,
                itemBuilder: (_,index){
                  return Center(
                    child:  Container(
                              height: 30.0,
                              width: 200.0,
                              child: Material(
                                borderRadius: BorderRadius.circular(0.0),
                                shadowColor: Colors.white,
                                color: Colors.greenAccent,
                                elevation: 0.0,
                                child: GestureDetector(
                                  onTap: () {},
                                  child: Center(
                                    child: Text(
                                      snapshot.data[index].data['Name'],
                                      style: style,
                                    ),
                                  ),
                                ),
                              )),
                  );
                },
              ),
            );
          }
        }
      ),
      
    );
  }

    Future getPosts() async {
    var firestore = Firestore.instance;
    //firestore.collection('teamapp').orderBy(DocumentReference());  // order colllection as Name
    QuerySnapshot qn = await firestore.collection('Members').orderBy("Name").getDocuments();
    print("*");
    return qn.documents;
  }
}