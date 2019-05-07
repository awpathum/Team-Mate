import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:teamapp/Pages/collectionid.dart';

class check extends StatefulWidget {
  @override
  _checkState createState() => _checkState();
}

List<dynamic> allId = List<dynamic>();
List<String> keys = List<String>();
List<int> vals = List<int>();

class _checkState extends State<check> {
  TextStyle style = TextStyle(
      fontFamily: 'Montserrat', fontSize: 20.0, color: Colors.black54);
  @override
  initSate(){
    getDetails();
    print('Done');
  }
  
  Widget build(BuildContext context) {
    final ascending = Radio(
      value: 0,
      onChanged: setAsc(),
    );
    final decending = Radio(
      value: 1,
      onChanged: setDec(),
    );
    final ascTitle = Text('Ascending', style: style);
    final decTitle = Text('Decending', style: style);
    return Scaffold(
      appBar: AppBar(
        title: Text('Check Attendance'),
        actions: <Widget>[
          FlatButton(
            child: Text('Done'),
            onPressed: () {
              getDetails();
            },
          ),
          FlatButton(
            child: Text('Check'),
            onPressed: () {
              countId();
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(10.0, 20.0, 10.0, 10.0),
        child: Column(
          children: <Widget>[
            Row(
              children: <Widget>[
                SizedBox(
                  width: 5.0,
                ),
                ascending,
                SizedBox(
                  width: 10.0,
                ),
                ascTitle,
                SizedBox(
                  width: 10.0,
                ),
                decending,
                SizedBox(
                  width: 10.0,
                ),
                decTitle,
              ],
            ),
            Flexible(
              child: Container(
                child: FutureBuilder(
                  future: getList(),
                  builder: (contetx, AsyncSnapshot<List<String>> snapshot) {
                   /* if (snapshot.hasData) {
                      return Text('${snapshot.data.length}');
                    } else if (snapshot.hasData) {
                      print('Error');
                    }*/
                    print('*');
                    if (!snapshot.hasData) {
                      return Container(
                          child: Column(
                        children: <Widget>[
                          SizedBox(
                            height: 200.0,
                          ),
                          Text(' had no practices',),
                        ],
                      ));
                    } else if (snapshot.connectionState ==
                        ConnectionState.waiting) {
                      return CircularProgressIndicator();
                    } else {
                      print('#');
                      return Center(
                        child: ListView.builder(
                            padding: const EdgeInsets.only(bottom: 20.0),
                            scrollDirection: Axis.vertical,
                            shrinkWrap: true,
                            itemCount: allId
                                .length, //((snapshot.data.values.join("").length)/2).toInt(),
                            itemBuilder: (context, index) {
                              return Center(
                                child: ListTile(

                                    title: Text(allId[index]+"    " + snapshot.data[index]), //snapshot data should dispaly in this text field
                                    ),
                              );
                            }),
                      );
                    }
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  setAsc() {
    Firestore.instance.collection('Attendance').orderBy('201');
  }
  setDec() {}

  Future getDetails() async {
    var firestore = Firestore.instance;

    QuerySnapshot memsnap =
        await firestore.collection('RecodeBook').getDocuments();
    print('&');
    int count = memsnap.documents.length;
    print(count);

    QuerySnapshot querySnapshot2 =
        await Firestore.instance.collection("Members").getDocuments();
    var list2 = querySnapshot2.documents;
    list2.forEach((f) {
      allId.add(f.documentID);
    });
    print(allId);
    QuerySnapshot querySnapshot =
        await Firestore.instance.collection("RecodeBook").getDocuments();
    var list = querySnapshot.documents;
    list.forEach((f) {
      pracDays.add(f.documentID);
    });
    print(pracDays);
    for (int i = 0; i < count; i++) {
      print('1st for loop');
      List<String> newList = List<String>();
      print(pracDays[i]);

      Firestore.instance
          .collection('RecodeBook')
          .document(pracDays[i])
          .get()
          .then((DocumentSnapshot ds) {
        print(ds.exists);
        print(ds['Names']);
        newList = List.from(ds['Index']);
        memId.addAll(newList);
        print(memId);
      }).catchError((e) {
        print(e);
      });
      print(allId.length);
    }
    //countId();
  }

  countId() {
    print(memId);
    print('#');
    int lenMem = memId.length; //members who came practice
    int lenAll = allId.length; //all members
    int c = 0;
    print(lenMem);
    print(lenAll);
    for (int i = 0; i < lenAll; i++) {
      print('outer for loop');
      for (int j = 0; j < lenMem; j++) {
        print('inner for loop');
        if (allId[i] == memId[j]) {
          print('if statement');
          c++;
        } else {
          print('else statement');
        }
      }
      dayCount[allId[i]] = c;
      print(c);
      c = 0;
    }
    print(dayCount);
    uploadData();
    keys = dayCount.keys.toList();
    vals = dayCount.values.toList();

    setState(() {
      info = info;
    });
  }

  Future uploadData() async {
    Firestore.instance
        .collection('Attendance')
        .document('xyz')
        .setData(dayCount)
        .then((result) {})
        .catchError((e) {
      print(e);
    });

  }
/*Future getPosts() async {
    var firestore = Firestore.instance;
    //firestore.collection('teamapp').orderBy(DocumentReference());  // order colllection as Name
    QuerySnapshot qn = await firestore.collection('Attendance').getDocuments();
    
    return qn.documents;
}*/

    Future<List<String>> getList() async {
    var firestore = Firestore.instance;
   // Map<dynamic, List<dynamic>> info = Map<dynamic, List<dynamic>>();
   List<String> info = List<String>();
    DocumentReference docRef =
        firestore.collection('Attendance').document('xyz');
print('&');
    return docRef.get().then((datasnapshot) {
      if (datasnapshot.exists) {
        for(int i = 0;i < allId.length;i++){
          String id = datasnapshot.data[allId[i]].toString();
        print(id);
        info.add(id);
        }
        
       // String name = datasnapshot.data[""].toList();
        
        print('#');
        print(info);
        print(info.length);
        //count = name.length;
        return info;
      }
    });
  }
}
