import 'package:flutter/material.dart';

class checkAttendance extends StatefulWidget {
  @override
  _checkAttendanceState createState() => _checkAttendanceState();
}

class _checkAttendanceState extends State<checkAttendance> {
  TextStyle style = TextStyle(
      fontFamily: 'Montserrat', fontSize: 20.0, color: Colors.black54);
  @override
  setAsc() {}
  setDec() {}
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
      ),
      floatingActionButton: FloatingActionButton(
        child: Text('Done'),
        onPressed: () {},
      ),
      body: Padding(
          padding: const EdgeInsets.fromLTRB(10.0, 20.0, 10.0, 10.0),
          child: Column(children: <Widget>[
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
            ),Flexible(
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

                                    title: Text(snapshot.data[index]), //snapshot data should dispaly in this text field
                                    ),
                              );
                            }),
                      );
                    }
                  },
                ),
              ),
            ),
          ])),
    );
  }
}
