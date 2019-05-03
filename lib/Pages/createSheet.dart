import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:teamapp/Pages/addNewMember.dart';
import 'package:flutter_calendar/flutter_calendar.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:teamapp/Services/ListPage.dart';

class CreateSheet extends StatefulWidget {
  //static String get strDate => strDate;



 // static get uploadData => CreateSheet.uploadData;

  @override
  CreateSheetState createState() => CreateSheetState();
}
List<String> names = new List<String>();
List<String> index = new List<String>();

class CreateSheetState extends State<CreateSheet> {
  TextStyle style = TextStyle(
      fontFamily: 'Montserrat', fontSize: 20.0, color: Colors.black54);
  DateTime _date = DateTime.now();
  String strDate;
  String search;

  Future<Null> _selectDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
      context: context,
      initialDate: _date,
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );

    if (picked != null && picked != _date) {
      setState(() {
        _date = picked;
        strDate = _date.toString().substring(0, 10);
        print('Date Selected: ${strDate}');
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final searchText = TextFormField(
      style: style,
      decoration: InputDecoration(hintText: "Enter First Name"),
      onSaved: (input) => search = input,
    );
    final pickedDate = Text(
      'Date Selected: ${strDate}',
      textAlign: TextAlign.center,
      overflow: TextOverflow.ellipsis,
      style: style,
    );
    final pickDateButton = IconButton(
      onPressed: () {
        _selectDate(context);
      },
      tooltip: 'Pick Date',
      icon: Icon(Icons.calendar_today),
      iconSize: 25.0,
    );
    final searchButton = IconButton(
      onPressed: () {},
      tooltip: 'Hit',
      icon: Icon(Icons.search),
      iconSize: 25.0,
    );

    final name = RadioListTile(
      value: false,
      title: Text('Hello'),
      //onChanged: (),
    );

    final submitButton = Material(
      elevation: 5.0,
      borderRadius: BorderRadius.circular(30.0),
      color: Color(0xff01A0C7),
      child: FloatingActionButton(
        elevation: 5.0,
        onPressed: () {
          uploadData();
          /* final FormState = _formKey.currentState;

          if (FormState.validate()) {
            uploadData();
          }*/
        },
        child: Icon(Icons.check),
      ),
    );
    
    return Scaffold(
      appBar: AppBar(
        title: Text('Create Sheet'),
        actions: <Widget>[
          FlatButton(
            child: Text('Done',
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 15.0,
                    color: Colors.white)),
            onPressed: () {
              //ListPage.uploadData();
              //print('Done');

              //print(ListPage.presentList);
            },
          )
        ],
      ),
      body: Center(
          child: Padding(
        padding: const EdgeInsets.only(bottom: 30.0),
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.fromLTRB(10.0, 20.0, 10.0, 10.0),
              child: Row(
                children: <Widget>[
                  SizedBox(
                    width: 10.0,
                  ),
                  pickedDate,
                  SizedBox(
                    width: 45.0,
                  ),
                  pickDateButton,
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(10.0, 0.0, 10.0, 20.0),
              child: Row(
                children: <Widget>[
                  SizedBox(
                    width: 10.0,
                  ),
                  Flexible(
                    child: searchText,
                  ),
                  SizedBox(
                    width: 10.0,
                  ),
                  searchButton,
                ],
              ),
            ),
            Flexible(
              child: Container(
      child: FutureBuilder(
        future: getPosts(),
        builder: (_, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: Text("Loading"),
            );
          } else {
            // final nameList = snapshot.data["Name"];
            //print(nameList);
            return Column(
              children: <Widget>[
                ListView.builder(
                    padding: const EdgeInsets.only(bottom: 20.0),
                    scrollDirection: Axis.vertical,
                    shrinkWrap: true,
                    itemCount: snapshot.data.length,
                    itemBuilder: (_, index) {
                      return Center(
                        child: CheckboxListTile(
                            value: names
                                .contains(snapshot.data[index].data["Name"]),
                            title: Text(snapshot.data[index].data["Name"]),
                            onChanged: (bool selected) {
                              //markMember(snapshot.data[index].data["Name"]);
                              _onCategorySelected(
                                  selected,
                                  snapshot.data[index].data["Name"],
                                  snapshot.data[index].data["IndexNo"]);
                            }),
                      );
                    }),
                Column(
                  children: <Widget>[
                    SizedBox(
                      height: 120,
                    ),
                    Row(
                      children: <Widget>[
                        SizedBox(
                          width: 290,
                        ),
                        submitButton,
                      ],
                    ),
                  ],
                ),
              ],
            );
          }
        },
      ),
    ),
            ),
          ],
        ),
      )),
    );
  }
  String getDate(){
    return strDate;
  }
    // crudMethods crudObj = new crudMethods();
  void _onCategorySelected(bool selected, name, indexno) {
    if (selected == true) {
      setState(() {
        //presentMembers.add(category_id);
        names.add(name);
        index.add(indexno);
        //attendanceSheet.addAll("",names);
        //presentMembers['Name'] = name;
        //presentMembers['indexno'] = indexno;
      });
    } else {
      setState(() {
        names.remove(name);
        index.remove(indexno);
        //presentMembers.remove(name);
        //presentMembers.remove(indexno);
      });
    }
    print(names);
    print(index);
  }

  Future getPosts() async {
    var firestore = Firestore.instance;
    QuerySnapshot qn = await firestore.collection('teamapp').getDocuments();
    print("*");
    return qn.documents;
  }

  Future uploadData() async {
    Map<String, List<String>> attendanceSheet = {
      'Names': names,
      'Index': index,
    };
//var getDate = CreateSheetState();
//String date = getDate.strDate;
    //Firestore.instance.collection('teamapp').add(memberDetails).catchError((e){
    //print(e);
    //String today = CreateSheet.strDate;
    //print(today);
    Firestore.instance.collection('today').document(strDate).setData(attendanceSheet).then((result){
      print(strDate);
       Fluttertoast.showToast(
          msg: "Done",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIos: 1,
          backgroundColor: Colors.black54,
          textColor: Colors.white,
          fontSize: 16.0);
    }).catchError((e){
      print(e);
    });
    /*Firestore.instance
        .collection('today')
        .add(attendanceSheet)
        .catchError((e) {
      print(e);
    });*/
  }


}
