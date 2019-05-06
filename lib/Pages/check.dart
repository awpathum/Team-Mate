import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:teamapp/Pages/collectionid.dart';

class check extends StatefulWidget {
  @override
  _checkState createState() => _checkState();
}
List<dynamic> allId = List<dynamic>();
class _checkState extends State<check> {
  TextStyle style = TextStyle(
      fontFamily: 'Montserrat', fontSize: 20.0, color: Colors.black54);
  @override
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
            /*Flexible(
                child: Container(
                  child: FutureBuilder(
                    future: getDetails(),
                    builder: (contetx,
                        AsyncSnapshot<Map<dynamic, List<dynamic>>> snapshot) {
                      /* if(snapshot.hasData){
                        return Text('${snapshot.data.length}');
                      }else if(snapshot.hasData){
                        print('Error');
                      }*/
                      if (!snapshot.hasData) {
                        return Container(
                            child: Column(
                          children: <Widget>[
                            SizedBox(
                              height: 200.0,
                            ),
                            //Text(today + ' had no practices', style: diastyle),
                          ],
                        ));
                      } else if (snapshot.connectionState ==
                          ConnectionState.waiting) {
                        return CircularProgressIndicator();
                      } else {
                        return Center(
                          child: ListView.builder(
                              padding: const EdgeInsets.only(bottom: 20.0),
                              scrollDirection: Axis.vertical,
                              shrinkWrap: true,
                             // itemCount:
                               //   count, //((snapshot.data.values.join("").length)/2).toInt(),
                              itemBuilder: (context, index) {
                                return Center(
                                  child: ListTile(
                                    title: Text(snapshot.data["fname"][index] +
                                        "                       " +
                                        snapshot.data["mindex"][
                                            index]), //snapshot data should dispaly in this text field
                                  ),
                                );
                              }),
                        );
                      }
                    },
                  ),
                ),
              ),*/
          ],
        ),
      ),
    );
  }

  setAsc() {}
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
}
}


