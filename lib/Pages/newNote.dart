import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:teamapp/Pages/collectionid.dart';
import 'package:teamapp/Pages/test.dart';

class newNote extends StatefulWidget {
  final String file;

  newNote({Key key, this.file}) : super(key: key);

  @override
  _newNoteState createState() => _newNoteState();
}

String hello = 'hello';

class _newNoteState extends State<newNote> {
  /*void dispose() {
    textController.dispose();
    super.dispose();
  }*/


 /* final textController = TextEditingController.fromValue(TextEditingValue(
    text: file,
    selection: TextSelection(
        baseOffset: widget.file.length, extentOffset: widget.file.length),
    composing: TextRange.collapsed(20),
  ));*/
//final textController = TextEditingController.fromValue(TextEditingValue(text:"",selection:TextSelection.collapsed(offset: 15), composing: TextRange.empty));
final textController = TextEditingController();
  void initState() {
    textController.text = widget.file;
   /* textController.addListener(() {
      String text = widget.file;
      textController.value = textController.value.copyWith(
        text: text,
        selection:
            TextSelection(baseOffset: text.length, extentOffset: text.length),
        composing: TextRange.empty,
      );
    });*/
    super.initState();
  }

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
                
               /* onChanged: (name) {
                  setState(() {
                    textController.text = name;
                  });
                },*/
                //  keyboardType: TextInputType.numberWithOptions(),
                maxLines: 100,
               // autofocus: false,
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

  final noteController = TextEditingController();
//final textController = TextEditingController();

}

