import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:teamapp/Pages/home.dart';
import 'package:teamapp/Pages/selectProfile.dart';
import 'package:url_launcher/url_launcher.dart';

class Profile extends StatefulWidget {
  final String id;
  Profile({Key key, this.id}) : super(key: key);
  @override
  _ProfileState createState() => new _ProfileState();
}

class _ProfileState extends State<Profile> {
  TextStyle style =
      TextStyle(color: Colors.black, fontFamily: 'Montserrat', fontSize: 20.0);
  final _formKey = GlobalKey<FormState>();
  var tele;

  @override
  Widget build(BuildContext context) {
    final div = Divider(
      height: 10.0,
      color: Colors.grey[300],
    );
    return new Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(
            EvaIcons.arrowBackOutline,
          ),
          color: Colors.white,
        onPressed: (){
          Navigator.push(
            context, MaterialPageRoute(builder: (context) => Home()));
        },),
        title: Text('View Profile',style: TextStyle(color: Colors.white)),
        backgroundColor: Color(0xff88498f),
        actions: <Widget>[
          IconButton(
            icon: Icon(EvaIcons.homeOutline,color: Colors.white,),
            iconSize: 35.0,
            onPressed: () {
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => Home()));
            },
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Color(0xff88498f),
        child: Icon(
          EvaIcons.phoneCallOutline,
          color: Colors.white,
          size: 30.0,
        ),
        onPressed: () {
          launchURL(tele);
        },
      ),
      body: SingleChildScrollView(
          child: Stack(
        children: <Widget>[
          FutureBuilder(
            future: getList(widget.id),
            builder: (context, AsyncSnapshot<Map<String, String>> snapshot) {
              if (!snapshot.hasData) {
                print('no data');
                return Container(
                    child: Column(
                  children: <Widget>[
                    SizedBox(
                      height: 200.0,
                    ),
                  ],
                ));
              } else if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              } else {
                tele = snapshot.data['Telephone'];
                return Column(
                  children: <Widget>[
                    SizedBox(
                      height: 20.0,
                    ),
                    Container(
                        width: 150.0,
                        height: 150.0,
                        decoration: BoxDecoration(
                            color: Colors.red,
                            image: DecorationImage(
                                image:
                                    NetworkImage(snapshot.data["Profilepic"]),
                                fit: BoxFit.cover),
                            borderRadius:
                                BorderRadius.all(Radius.circular(75.0)),
                            boxShadow: [
                              BoxShadow(blurRadius: 7.0, color: Colors.black)
                            ])),
                    SizedBox(height: 20.0),
                    Center(
                      child: Card(
                        elevation: 2.0,
                        margin: const EdgeInsets.all(20.0),
                        child: Column(
                          children: <Widget>[
                            Container(
                                height: 45.0,
                                width: 200.0,
                                child: Material(
                                  borderRadius: BorderRadius.circular(0.0),
                                  shadowColor: Colors.white,
                                  color: Colors.white,
                                  elevation: 0.0,
                                  child: GestureDetector(
                                    child: Center(
                                      child: Text(
                                        snapshot.data['Name'],
                                        style: style,
                                      ),
                                    ),
                                    onTap: () {
                                      editDialog(
                                          'Name', snapshot.data['IndexNo']);
                                    },
                                  ),
                                )),
                            div,
                            Container(
                                height: 45.0,
                                width: 200.0,
                                child: Material(
                                  borderRadius: BorderRadius.circular(0.0),
                                  shadowColor: Colors.white,
                                  color: Colors.white,
                                  elevation: 0.0,
                                  child: GestureDetector(
                                    /* onTap: () {
                                    editDialog(
                                        'IndexNo', snapshot.data['IndexNo']);
                                  },*/
                                    child: Center(
                                      child: Text(
                                        snapshot.data["IndexNo"],
                                        style: style,
                                      ),
                                    ),
                                  ),
                                )),
                            div,
                            Container(
                                height: 45.0,
                                width: 200.0,
                                child: Material(
                                  borderRadius: BorderRadius.circular(0.0),
                                  shadowColor: Colors.white,
                                  color: Colors.white,
                                  elevation: 0.0,
                                  child: GestureDetector(
                                    onTap: () {
                                      editDialog(
                                          'NIC', snapshot.data['IndexNo']);
                                    },
                                    child: Center(
                                      child: Text(
                                        snapshot.data["NIC"],
                                        style: style,
                                      ),
                                    ),
                                  ),
                                )),
                            div,
                            Container(
                                height: 45.0,
                                width: 200.0,
                                child: Material(
                                  borderRadius: BorderRadius.circular(00.0),
                                  shadowColor: Colors.white,
                                  color: Colors.white,
                                  elevation: 0.0,
                                  child: GestureDetector(
                                    onTap: () {
                                      editDialog(
                                          'Faculty', snapshot.data['IndexNo']);
                                    },
                                    child: Center(
                                      child: Text(
                                        snapshot.data["Faculty"],
                                        style: style,
                                      ),
                                    ),
                                  ),
                                )),
                            div,
                            Container(
                                height: 45.0,
                                width: 200.0,
                                child: Material(
                                  borderRadius: BorderRadius.circular(0.0),
                                  shadowColor: Colors.white,
                                  color: Colors.white,
                                  elevation: 0.0,
                                  child: GestureDetector(
                                    onTap: () {
                                      editDialog(
                                          'Year', snapshot.data['IndexNo']);
                                    },
                                    child: Center(
                                      child: Text(
                                        snapshot.data["Year"] + "  Year",
                                        style: style,
                                      ),
                                    ),
                                  ),
                                )),
                            div,
                            Container(
                                height: 45.0,
                                width: 200.0,
                                child: Material(
                                  borderRadius: BorderRadius.circular(0.0),
                                  shadowColor: Colors.white,
                                  color: Colors.white,
                                  elevation: 0.0,
                                  child: GestureDetector(
                                    onTap: () {
                                      editDialog('Telephone',
                                          snapshot.data['IndexNo']);
                                    },
                                    child: Center(
                                      child: Text(
                                        snapshot.data["Telephone"],
                                        style: style,
                                      ),
                                    ),
                                  ),
                                )),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: 5.0),
                    Row(
                      children: <Widget>[
                        SizedBox(
                          width: 20.0,
                        ),
                        IconButton(
                          icon: Icon(EvaIcons.trash2Outline,
                              size: 20.0, color: Colors.redAccent),
                          onPressed: () {
                            deleteDialog(snapshot.data["IndexNo"]);
                          },
                        )
                      ],
                    )
                  ],
                );
              }
            },
          ),
        ],
      )),
    );
  }

  removeMem(String id) async {
    await Firestore.instance.collection('Members').document(id).delete();
  }

  Future<Map<String, String>> getList(var index) async {
    print(widget.id);
    var firestore = Firestore.instance;
    Map<String, String> info = Map<String, String>();
    DocumentReference docRef = firestore.collection('Members').document(index);

    return docRef.get().then((datasnapshot) {
      if (datasnapshot.exists) {
        // List<dynamic> name = datasnapshot.data['Names'].toList();
        //List<dynamic> indexno = datasnapshot.data["Index"].toList();
        // info = {"fname": name, "mindex": indexno};
        String name = datasnapshot.data['Name'].toString();
        String fname = datasnapshot.data['FirstName'].toString();
        String index = datasnapshot.data['IndexNo'].toString();
        String nic = datasnapshot.data['NIC'].toString();
        String fac = datasnapshot.data['Faculty'].toString();
        String imgurl = datasnapshot.data['Profilepic'].toString();
        String year = datasnapshot.data['Year'].toString();
        String tele = datasnapshot.data['Telephone'].toString();

        info = {
          "Name": name,
          "FirstName": fname,
          "IndexNo": index,
          "NIC": nic,
          "Faculty": fac,
          "Profilepic": imgurl,
          "Year": year,
          "Telephone": tele
        };
        /*info['Name'] = name;
        info['FirstName'] = fname;
        info['IndexNo'] = index;
        info['NIC'] = nic;
        info['Faculty'] = fac;
        info['Profilepic'] = imgurl;
        info['Year'] = year;
        info['Telephone'] = tele;*/
        print(info);
        print(info.length);

        print(info);
        return info;
      }
    });
  }

  Future<void> warning() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: true,
      // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          content: Column(
            children: <Widget>[
              Icon(EvaIcons.alertTriangleOutline),
              Text(
                'Index Number Cannot change',
                style: style,
              )
            ],
          ),
        );
      },
    );
  }

  Future<void> deleteDialog(String id) async {
    /*if(field == 'IndexNo'){
      return warning();
    }*/
    return showDialog<void>(
      context: context,
      barrierDismissible: true, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Are You Sure?'),
          actions: <Widget>[
            FlatButton(
              child: Text('Delete',style: TextStyle(color: Colors.red)),
              onPressed: () {
                removeMem(id);
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => selectProfile()));
              },
            ),
            FlatButton(
              child: Text('Cancel',style: TextStyle(color: Colors.green)),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ],
        );
      },
    );
  }

  Future<void> editDialog(String field, String id) async {
    String name, index, nic, faculty, year, telephone;
    /*if(field == 'IndexNo'){
      return warning();
    }*/
    return showDialog<void>(
      context: context,
      barrierDismissible: true, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Edit'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Form(
                  key: _formKey,
                  child: TextFormField(
                    obscureText: false,
                    onSaved: (input) => name = input,
                    decoration: InputDecoration(
                      //border: ,
                      labelText: 'Enter Text Here',
                    ),
                  ),
                ),
              ],
            ),
          ),
          actions: <Widget>[
            FlatButton(
              child: Text('OK'),
              onPressed: () {
                _formKey.currentState.save();
                if (name.isNotEmpty) {
                  updateDetails(id, field, name);
                  Navigator.of(context).pop();
                }
              },
            ),
          ],
        );
      },
    );
  }

  updateDetails(String doc, String field, String data) async {
    print('****');
    print(data);

    _formKey.currentState.save();
    Map<String, String> submit = {field: data};

    Firestore.instance
        .collection('Members')
        .document(doc)
        .updateData(submit)
        .then((result) {
      print('Done');
    }).catchError((e) {
      print(e);
    });
  }

  launchURL(var number) async {
    var url = number;
    if (await canLaunch(number)) {
      await launch(number);
    } else {
      throw 'Could not launch $url';
    }
  }
}
