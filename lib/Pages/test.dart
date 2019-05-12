import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:teamapp/Pages/home.dart';
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
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
          onPressed: () {
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => Home()));
          },
        ),
        title: Text(
          'Notepad',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.red[200],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.red[200],
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
          Flexible(
            child: FutureBuilder(
              future: viewNotes(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (snapshot.connectionState ==
                    ConnectionState.waiting) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                } else {
                  return Center(
                    child: ListView.builder(
                        padding: const EdgeInsets.only(bottom: 20.0),
                        scrollDirection: Axis.vertical,
                        shrinkWrap: true,
                        itemCount: snapshot.data.length,
                        itemBuilder: (context, index) {
                          return Card(
                            child: ListTile(
                                leading: Icon(EvaIcons.flagOutline),
                                title: Text(snapshot.data[index].data["title"]
                                    .toString()),
                                trailing: IconButton(
                                  icon: Icon(EvaIcons.fileRemoveOutline),
                                  onPressed: () {
                                    deleteWarning(
                                        snapshot.data[index]['title']);

                                    ///deleteNotes(snapshot.data[index]['title']);
                                  },
                                ),
                                onTap: () {
                                  showNotes(snapshot.data[index].toString());
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => newNote(
                                              file: snapshot.data[index]
                                                  ['text'],
                                              title: snapshot.data[index]
                                                  ['title'])));
                                }),
                          );
                        }),
                  );
                }
              },
            ),
          )
        ],
      ),
    );
  }

  Future<void> deleteWarning(String title) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: true, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Delete!'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text(
                    'Are you Sure you want to delete' + " " + '${title}' + "?"),
              ],
            ),
          ),
          actions: <Widget>[
            FlatButton(
              child: Text('Cancel'),
              onPressed: () {
                deleteNotes(title);
                Navigator.of(context).pop();
              },
            ),
            FlatButton(
              child: Text(
                'Delete',
                style: TextStyle(color: Colors.red),
              ),
              onPressed: () {
                deleteNotes(title);
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  Future deleteNotes(String title) async {
    await Firestore.instance
        .collection('Notes')
        .document(title)
        .delete()
        .then((result) {
      print('deleted');
    }).catchError((e) {
      print(e);
    });
    setState(() {});
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
