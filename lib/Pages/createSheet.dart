import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class CreateSheet extends StatefulWidget {
  @override
  CreateSheetState createState() => CreateSheetState();
}

DateTime _date = DateTime.now();
initState() {
  String strDate = _date.toString().substring(0, 10);
  return strDate;
}

List<String> names = new List<String>();
List<String> index = new List<String>();

final recentnames = ["aaa", "bbb", "ccc", "ddd"];

class CreateSheetState extends State<CreateSheet> {
  final _formKey = GlobalKey<FormState>();
  TextStyle style = TextStyle(
      fontFamily: 'Montserrat', fontSize: 20.0, color: Colors.black54);

  static int count = 0;
  String today = initState();

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

        today = _date.toString().substring(0, 10);
        print('Date Selected: ${today}');
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    /* final searchText = TextFormField(
      style: style,
      decoration: InputDecoration(hintText: "Enter First Name"),
     // onSaved: (input) => search = input,
    );*/
    final pickedDate = Text(
      '${today}',
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
    /* final searchButton = IconButton(
      onPressed: () {
        //search(),
      },
      tooltip: 'Hit',
      icon: Icon(Icons.search),
      iconSize: 25.0,
    );*/

    final submitButton = Material(
      elevation: 5.0,
      borderRadius: BorderRadius.circular(30.0),
      color: Color(0xff01A0C7),
      child: FloatingActionButton(
        elevation: 5.0,
        onPressed: () {
          uploadData();
        },
        child: Text(count.toString()),
      ),
    );

    return Scaffold(
      appBar: AppBar(
        title: Text('Create Sheet'),
      ),
      floatingActionButton: submitButton,
      body: Center(
          child: Padding(
        padding: const EdgeInsets.only(bottom: 80.0),
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.fromLTRB(10.0, 20.0, 10.0, 10.0),
              child: Row(
                children: <Widget>[
                  SizedBox(
                    width: 80.0,
                  ),
                  pickedDate,
                  SizedBox(
                    width: 45.0,
                  ),
                  pickDateButton,
                ],
              ),
            ),
            Flexible(
              child: Container(
                child: FutureBuilder(
                  future: getPosts(),
                  builder: (_, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      /*return Center(
                        child: Text("Loading"),
                      );*/
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
                                child: CheckboxListTile(
                                    value: names.contains(
                                        snapshot.data[index].data["Name"]),
                                    title: Text(snapshot
                                            .data[index].data["Name"] +
                                        "                             " +
                                        snapshot.data[index].data["IndexNo"]),
                                    onChanged: (bool selected) {
                                      _onCategorySelected(
                                          selected,
                                          snapshot.data[index].data["Name"],
                                          snapshot.data[index].data["IndexNo"]);
                                    }),
                              );
                            }),
                      );
                    }
                  },
                ),
              ),
            ),
            /*SizedBox(
              height: 10.0,
            ),*/
            //submitButton
          ],
        ),
      )),
    );
  }

  String getDate() {
    return initState();
  }

  void _onCategorySelected(bool selected, name, indexno) {
    if (selected == true) {
      setState(() {
        names.add(name);
        index.add(indexno);
      });
    } else {
      setState(() {
        names.remove(name);
        index.remove(indexno);
      });
    }
    print(names);
    print(index);
    count = names.length;
  }

  Future getPosts() async {
    var firestore = Firestore.instance;
    //firestore.collection('teamapp').orderBy(DocumentReference());  // order colllection as Name
    QuerySnapshot qn = await firestore.collection('Members').orderBy("Name").getDocuments();
    print("*");
    return qn.documents;
  }

  Future uploadData() async {
    Map<String, List<String>> attendanceSheet = {
      'Names': names,
      'Index': index,
    };

    Firestore.instance
        .collection('RecodeBook')
        .document(today)
        .setData(attendanceSheet)
        .then((result) {
      print(today);
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