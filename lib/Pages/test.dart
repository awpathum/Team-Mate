import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:teamapp/Pages/newNote.dart';

class notePad extends StatefulWidget {
  @override
  _notePadState createState() => _notePadState();
}

class _notePadState extends State<notePad> {
  final nameController = TextEditingController();
  final textController = TextEditingController();
  String file;
  String note;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Notepad'),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(
          EvaIcons.fileAddOutline,
        ),
        onPressed: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => newNote()));
        },
      ),
      body: Column(
        children: <Widget>[
          FutureBuilder(
            future: viewNotes(),
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return Text('No Data');
              } else if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              } else {
                return Center(
                  child: ListView.builder(
                      scrollDirection: Axis.vertical,
                      shrinkWrap: true,
                      itemCount: snapshot.data.length,
                      itemBuilder: (context, index) {
                        return Card(
                          child: ListTile(
                              leading: Icon(EvaIcons.flagOutline),
                              title: Text(
                                  snapshot.data[index].data["title"].toString()),
                              trailing: Icon(Icons.more_vert),
                              onTap: () {
                                showNotes(snapshot.data[index].toString());
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            newNote(file:snapshot.data[index]['text'],title:snapshot.data[index]['title'])));
                              }),
                        );
                      }),
                );
              }
            },
          )
        ],
      ),
    );
  }

  Future viewNotes() async {
    var firestore = Firestore.instance;
    //firestore.collection('teamapp').orderBy(DocumentReference());  // order colllection as Name
    QuerySnapshot qn = await firestore.collection('Notes').getDocuments();
    print('viewNotes');
    return qn.documents;
  }

  Future showNotes(String text) async {
    print('*****');
    var firestore = Firestore.instance;

    DocumentReference docRef = firestore.collection('Notes').document(text);

    //note = docRef.get().toString();
    print(text);
    return docRef.get().then((datasnapshot) {
      if (datasnapshot.exists) {
       print('###');
        note = datasnapshot.data["text"];
        return 0;
       // return info;
      }
    });
  }
}
