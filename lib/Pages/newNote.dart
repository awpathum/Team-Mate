import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:teamapp/Pages/collectionid.dart';
import 'package:teamapp/Pages/test.dart';

class newNote extends StatefulWidget {
  final String file;
  final String title;

  newNote({Key key, this.file, this.title}) : super(key: key);

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
  final titleController = TextEditingController();
  int save = 0;
  void initState() {
    textController.text = widget.file;
    titleController.text = widget.title;

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
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
          onPressed: () {
            deleteWarning();
          },
        ),
        title: Text(
          'New Note',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.red[200],
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.done,color: Colors.white,),
        backgroundColor: Colors.red[200],
        onPressed: () {
          saveNote(textController.text, titleController.text);
         /* Navigator.push(
              context, MaterialPageRoute(builder: (context) => notePad()));*/
        },
      ),
      body: Center(
        child: SingleChildScrollView(
            child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            children: <Widget>[
              TextField(
                controller: titleController,
                decoration: InputDecoration(hintText: 'Title'),
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 20.0,
              ),
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
        )),
      ),
    );
  }

  Future<void> deleteWarning() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: true, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Save Note?'),
          actions: <Widget>[
            FlatButton(
              child: Text('Yes'),
              onPressed: () {
                saveNote(textController.text, titleController.text);
                save = 1;
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => notePad()));
              },
            ),
            FlatButton(
              child: Text(
                'No',
                style: TextStyle(color: Colors.red),
              ),
              onPressed: () {
                // deleteNotes(title);
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => notePad()));
              },
            ),
          ],
        );
      },
    );
  }

  saveNote(String txt, String title) async {
    DateTime date = DateTime.now();
    if (titleController.text.isNotEmpty) {
      print(widget.file);
      print('file printed');
      await Firestore.instance
          .collection('Notes')
          .document(titleController.text.toString())
          .setData({'title': title, 'text': txt,'date': date.toString()}).then((result) {
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
      Navigator.push(
              context, MaterialPageRoute(builder: (context) => notePad()));
    }else{
       
      return Fluttertoast.showToast(
          msg: "Ttile is Empty",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIos: 1,
          backgroundColor: Colors.black54,
          textColor: Colors.white,
          fontSize: 16.0);
    }

    /* await Firestore.instance
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
    });*/
  }

  final noteController = TextEditingController();
//final textController = TextEditingController();

}
