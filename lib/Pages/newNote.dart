import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:teamapp/Pages/test.dart';

class newNote extends StatefulWidget {
  final String file;
  newNote({Key key, this.file}) : super(key: key);
  @override
  _newNoteState createState() => _newNoteState();
}

TextEditingValue edval() {
  text:
  "";
  selection:
  const TextSelection.collapsed(offset: -1);
  composing:
  TextRange.empty;
}

final textController = TextEditingController();
final noteController = TextEditingController();

class _newNoteState extends State<newNote> {
  void initState() {
    textController.addListener(() {
      final text = widget.file;
      textController.value = textController.value.copyWith(
        text: text,
        selection:
            TextSelection(baseOffset: text.length, extentOffset: text.length),
        composing: TextRange.empty,
      );
    });
    super.initState();
  }

  /*void dispose() {
    textController.dispose();
    super.dispose();
  }*/

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('New Note'),
        actions: <Widget>[
          FlatButton(
            child: Text('Cancel'),
            onPressed: () {
              textController.dispose();
            },
          ),
          IconButton(
            icon: Icon(
              EvaIcons.homeOutline,
              size: 15.0,
              color: Colors.white,
            ),
            onPressed: () {},
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(EvaIcons.doneAllOutline),
        onPressed: () {
          saveNote(textController.text);
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => notePad()));
        },
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              TextField(
                enabled: true,
                controller: textController,
                decoration: InputDecoration(hintText: "Enter Some Text..."),
                scrollPadding: EdgeInsets.all(20.0),
                onChanged: (name) {
                  setState(() {
                    textController.text = name;
                  });
                },
                //  keyboardType: TextInputType.numberWithOptions(),
                maxLines: 100,
                autofocus: true,
              )
            ],
          ),
        ),
      ),
    );
  }

  saveNote(String txt) async {
    print(widget.file);
    print('file printed');

    await Firestore.instance
        .collection('Notes')
        .add({'text': txt}).then((result) {
      print('Done');
      Fluttertoast.showToast(
          msg: "Done",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIos: 1,
          backgroundColor: Colors.black54,
          textColor: Colors.white,
          fontSize: 16.0);
    }).catchError((e) {
      print(e);
    });
  }
}
