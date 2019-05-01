import 'package:flutter/material.dart';
import 'package:teamapp/Pages/addNewMember.dart';
import 'package:flutter_calendar/flutter_calendar.dart';

class CreateSheet extends StatefulWidget {
  @override
  _CreateSheetState createState() => _CreateSheetState();
}

class _CreateSheetState extends State<CreateSheet> {
  

  DateTime _date = DateTime.now();
  String strDate;
  Future<Null>_selectDate(BuildContext context)async{
    final DateTime picked = await showDatePicker(
      context: context,
      initialDate: _date,
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );
    
    
    if(picked != null && picked != _date){
      
      setState(() {
        _date = picked;
        strDate = _date.toString().substring(0,10);
        print('Date Selected: ${strDate}');
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add New Member'),
      ),
      body: Column(
        children: <Widget>[
          IconButton(
            onPressed: (){
              _selectDate(context);
            },
            tooltip: 'Pick Image',
            icon: Icon(Icons.add_a_photo),
            iconSize: 40.0,
          ),
          Text('Date Selected: ${strDate}')
        ],
      )
    );
    
  }
  


}

/*IconButton(
            onPressed: (){
              _selectDate(context);
            },
            tooltip: 'Pick Image',
            icon: Icon(Icons.add_a_photo),
            iconSize: 40.0,
          ),*/