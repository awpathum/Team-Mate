import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ViewSheet extends StatefulWidget {
  @override
  _ViewSheetState createState() => _ViewSheetState();
}

DateTime _date = DateTime.now();
initState() {
  String strDate = _date.toString().substring(0, 10);
  return strDate;
}

class _ViewSheetState extends State<ViewSheet> {
  int count = 0; //for item count
  TextStyle style = TextStyle(
      fontFamily: 'Montserrat', fontSize: 20.0, color: Colors.black54);
      TextStyle diastyle = TextStyle(
      fontFamily: 'Montserrat', fontSize: 18.0, color: Colors.red[200]);
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
        print('Date Selected:{$today}');
      });
    }
  }

  @override
  Widget build(BuildContext context) {
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
    return Scaffold(
        appBar: AppBar(
          title: Text('View Sheet'),
        ),
        body: Padding(
          padding: const EdgeInsets.fromLTRB(10.0, 20.0, 10.0, 10.0),
          child: Column(
            children: <Widget>[
              Row(
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
              Flexible(
                child: Container(
                  child: FutureBuilder(
                    future: getList(),
                    builder: (contetx, AsyncSnapshot<Map<dynamic,List<dynamic>>> snapshot) {
                     /* if(snapshot.hasData){
                        return Text('${snapshot.data.length}');
                      }else if(snapshot.hasData){
                        print('Error');
                      }*/
                      if (!snapshot.hasData) {
                        return Container(

                          child: Column(
                            children: <Widget>[
                              SizedBox(height: 200.0,),
                              Text(today + ' had no practices', style:diastyle),
                            ],
                          )
                        );
                        
                      } else if(snapshot.connectionState == ConnectionState.waiting){
                        return CircularProgressIndicator();
                      }else{
                        return Center(
                          child: ListView.builder(
                              padding: const EdgeInsets.only(bottom: 20.0),
                              scrollDirection: Axis.vertical,
                              shrinkWrap: true,
                              itemCount: count,//((snapshot.data.values.join("").length)/2).toInt(),
                              itemBuilder: (context, index) {
                                
                                return Center(
                                  child: ListTile(
                                    title: Text(snapshot.data["fname"][index] + "                       " + snapshot.data["mindex"][index]), //snapshot data should dispaly in this text field
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
        ));
  }
Future<Map<dynamic,List<dynamic>>> getList() async {
    var firestore = Firestore.instance;
    Map<dynamic,List<dynamic>> info = Map<dynamic,List<dynamic>>();
    DocumentReference docRef =
        firestore.collection('RecodeBook').document(today);

    return docRef.get().then((datasnapshot) {
      if (datasnapshot.exists) {
        List<dynamic> name = datasnapshot.data['Names'].toList();
        List<dynamic> indexno = datasnapshot.data["Index"].toList();
        info = {"fname":name,"mindex":indexno};
        print('#');
        print(info);
        print(info.length);
        count = name.length;
        return info;
      }
    });
  }
}
