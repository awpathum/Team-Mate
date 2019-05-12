import 'package:flutter/material.dart';
import 'package:teamapp/Pages/addNewMember.dart';
import 'package:teamapp/Pages/check.dart';
import 'package:teamapp/Pages/createSheet.dart';
import 'package:teamapp/Pages/newNote.dart';
import 'package:teamapp/Pages/selectProfile.dart';
import 'package:teamapp/Pages/signIn.dart';
import 'package:teamapp/Pages/test.dart';
import 'package:teamapp/Pages/viewProfile.dart';
import 'package:teamapp/Pages/viewSheet.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  TextStyle style =
      TextStyle(fontFamily: 'Montserrat', fontSize: 20.0, color: Colors.white);
  @override
  Widget build(BuildContext context) {
    final createSheet = Material(
      elevation: 4.0,
      borderRadius: BorderRadius.circular(10.0),
      color: Color(0xff564154),
      child: MaterialButton(
        child: Column(
          children: <Widget>[
            SizedBox(
              height: 40.0,
            ),
            Icon(
              Icons.create,
              color: Colors.white,
              size: 50.0,
            ),
            SizedBox(
              height: 40.0,
            ),
            Text(
              'Create Sheet',
              style: style,
            ),
          ],
        ),
        //minWidth: MediaQuery.of(context).size.width / 2,
        //height: MediaQuery.of(context).size.width / 4,
        onPressed: () => Navigator.push(
            context, MaterialPageRoute(builder: (context) => CreateSheet())),
      ),
    );
    final viewSheet = Material(
      elevation: 4.0,
      borderRadius: BorderRadius.circular(10.0),
      color: Color(0xffff8164),
      child: MaterialButton(
        child: Column(
          children: <Widget>[
            SizedBox(
              height: 40.0,
            ),
            Icon(
              EvaIcons.monitor,
              color: Colors.white,
              size: 50.0,
            ),
            SizedBox(
              height: 40.0,
            ),
            Text(
              'View Sheet',
              style: style,
            ),
          ],
        ),
        //minWidth: MediaQuery.of(context).size.width / 2,
        //height: MediaQuery.of(context).size.width / 4,
        onPressed: () => Navigator.push(
            context, MaterialPageRoute(builder: (context) => ViewSheet())),
      ),
    );
    final addMember = Material(
      elevation: 4.0,
      borderRadius: BorderRadius.circular(10.0),
      color: Color(0xff8f826b),
      child: MaterialButton(
        child: Column(
          children: <Widget>[
            SizedBox(
              height: 40.0,
            ),
            Icon(
              EvaIcons.personAdd,
              color: Colors.white,
              size: 50.0,
            ),
            SizedBox(
              height: 40.0,
            ),
            Text(
              'New Member',
              style: style,
            ),
          ],
        ),
        //minWidth: MediaQuery.of(context).size.width / 2,
        //height: MediaQuery.of(context).size.width / 4,
        onPressed: () => Navigator.push(
            context, MaterialPageRoute(builder: (context) => addNewMember())),
      ),
    );
    final checkAttendance = Material(
      elevation: 4.0,
      borderRadius: BorderRadius.circular(10.0),
      color: Color(0xff779fa1),
      child: MaterialButton(
        child: Column(
          children: <Widget>[
            SizedBox(
              height: 40.0,
            ),
            Icon(
              EvaIcons.checkmarkSquare,
              color: Colors.white,
              size: 50.0,
            ),
            SizedBox(
              height: 40.0,
            ),
            Text(
              'Recode Book',
              style: style,
            ),
          ],
        ),
        //minWidth: MediaQuery.of(context).size.width / 2,
        //height: MediaQuery.of(context).size.width / 4,
        onPressed: () => Navigator.push(
            context, MaterialPageRoute(builder: (context) => check())),
      ),
    );
    final viewProfile = Material(
      elevation: 4.0,
      borderRadius: BorderRadius.circular(10.0),
      color: Color(0xff88498f),
      child: MaterialButton(
        child: Column(
          children: <Widget>[
            SizedBox(
              height: 40.0,
            ),
            Icon(
              EvaIcons.fileText,
              color: Colors.white,
              size: 50.0,
            ),
            SizedBox(
              height: 40.0,
            ),
            Text(
              'View Profile',
              style: style,
            ),
          ],
        ),
        //minWidth: MediaQuery.of(context).size.width / 2,
        //height: MediaQuery.of(context).size.width / 4,
        onPressed: () => Navigator.push(
            context, MaterialPageRoute(builder: (context) => selectProfile())),
      ),
    );
    final notifi = Material(
      elevation: 4.0,
      borderRadius: BorderRadius.circular(10.0),
      color: Colors.red[200],
      child: MaterialButton(
        child: Column(
          children: <Widget>[
            SizedBox(
              height: 40.0,
            ),
            Icon(
              Icons.library_books,
              color: Colors.white,
              size: 50.0,
            ),
            SizedBox(
              height: 40.0,
            ),
            Text(
              'Notes',
              style: style,
            ),
          ],
        ),
        //minWidth: MediaQuery.of(context).size.width / 2,
        //height: MediaQuery.of(context).size.width / 4,
        onPressed: () => Navigator.push(
            context, MaterialPageRoute(builder: (context) => notePad())),
      ),
    );
    /*final viewSheet = MaterialButton(
         child: Text('Done'),
         minWidth: MediaQuery.of(context).size.width / 2,
         height: MediaQuery.of(context).size.width / 4,
         
         onPressed: (){},
       );*/
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black87,
        title: Text('Home', style: TextStyle(color: Colors.white)),
      ),
      backgroundColor: Colors.white,
      body: CustomScrollView(
        primary: false,
        slivers: <Widget>[
          SliverPadding(
            padding: const EdgeInsets.all(10.0),
            sliver: SliverGrid.count(
              mainAxisSpacing: 10.0,
              crossAxisSpacing: 10.0,
              crossAxisCount: 2,
              children: <Widget>[
                createSheet,
                viewSheet,
                addMember,
                checkAttendance,
                viewProfile,
                notifi,
              ],
            ),
          ),
        ],
      ),
    );
  }
}
