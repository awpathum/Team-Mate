import 'package:flutter/material.dart';

class checkAttendance extends StatefulWidget {
  @override
  _checkAttendanceState createState() => _checkAttendanceState();
}

class _checkAttendanceState extends State<checkAttendance> {
  @override
  Widget build(BuildContext context) {
    final ascending = Radio(
      value: 'ascending',
    );
    final decending = Radio(
      value: 'decending',
    );
    return Scaffold(
      appBar: AppBar(
        title: Text('Check Attendance'),
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(10.0, 20.0, 10.0, 10.0),
        child: Column(
          children: <Widget>[
            Row(
              children: <Widget>[
                SizedBox(width: 20.0,),
                ascending,
                SizedBox(width: 20.0,),
                decending,
              ],
              
            )
          ],
        ),
      ),
    );
  }
}