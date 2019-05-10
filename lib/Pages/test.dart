import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';

class notePad extends StatefulWidget {
  @override
  _notePadState createState() => _notePadState();
}

class _notePadState extends State<notePad> {
  final nameController = TextEditingController();
  final textController = TextEditingController();
  
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
          newNoteDialog();
        },
      ),
      body: Column(
        children: <Widget>[
          ListView(
            scrollDirection: Axis.vertical,
            shrinkWrap: true,
            children: <Widget>[
              Card(
                child: ListTile(
                  leading: Icon(EvaIcons.flagOutline),
                  //title: //add not name here,
                  trailing: Icon(Icons.more_vert),
                  onTap: () {
                    //show note
                  },
                ),
              )
            ],
          ),
        ],
      ),
    );
  }

  Future<void> newNoteDialog() async {
    /*if(field == 'IndexNo'){
      return warning();
    }*/
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: TextField(
            controller: nameController,
            decoration: InputDecoration(labelText: 'Enter Name Here'),
          ),
          actions: <Widget>[
            FlatButton(
              child: Text('Cancel', style: TextStyle(color: Colors.red)),
              onPressed: () {
                //removeMem(id);
                Navigator.pop(context);
              },
            ),
            FlatButton(
              child: Text('Save', style: TextStyle(color: Colors.green)),
              onPressed: () {
                saveNote(nameController.text.toString(),
                    textController.text.toString());
                Navigator.pop(context);
                //nedd to add a toast here
              },
            ),
          ],
          content: Column(
            children: <Widget>[
              TextField(
                controller: textController,
                decoration: InputDecoration(labelText: 'Enter Some Text..'),
              ),
            ],
          ),
        );
      },
    );
  }

  saveNote(String name, String text) async {
    Map<String, String> txt = {
      name: text,
    };
    Firestore.instance
        .collection('Notes')
        .document(name)
        .setData(txt)
        .then((result) {
      print('Done');
    }).catchError((e) {
      print(e);
    });
  }
}
