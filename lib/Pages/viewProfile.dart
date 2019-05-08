import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';

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

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: Text('View Profile'),
        ),
        floatingActionButton: FloatingActionButton(
          child: Icon(
            EvaIcons.editOutline,
            color: Colors.white,
            size: 30.0,
          ),
          onPressed: () {
            //editDialog();
          },
        ),
        body: new Stack(
          children: <Widget>[
            ClipPath(
              child: Container(color: Colors.black.withOpacity(0.8)),
              clipper: getClipper(),
            ),
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
                      Text('Not a Member'),
                    ],
                  ));
                } else if (snapshot.connectionState ==
                    ConnectionState.waiting) {
                  return CircularProgressIndicator();
                } else {
                  return Positioned(
                      width: 350.0,
                      top: MediaQuery.of(context).size.height / 8,
                      child: Column(
                        children: <Widget>[
                          Container(
                              width: 150.0,
                              height: 150.0,
                              decoration: BoxDecoration(
                                  color: Colors.red,
                                  image: DecorationImage(
                                      image: NetworkImage(
                                          snapshot.data["Profilepic"]),
                                      fit: BoxFit.cover),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(75.0)),
                                  boxShadow: [
                                    BoxShadow(
                                        blurRadius: 7.0, color: Colors.black)
                                  ])),
                          SizedBox(height: 20.0),
                          Container(
                              height: 30.0,
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
                          SizedBox(height: 20.0),
                          Container(
                              height: 30.0,
                              width: 200.0,
                              child: Material(
                                borderRadius: BorderRadius.circular(0.0),
                                shadowColor: Colors.white,
                                color: Colors.white,
                                elevation: 0.0,
                                child: GestureDetector(
                                  onTap: () {},
                                  child: Center(
                                    child: Text(
                                      snapshot.data["IndexNo"],
                                      style: style,
                                    ),
                                  ),
                                ),
                              )),
                          SizedBox(height: 20.0),
                          Container(
                              height: 30.0,
                              width: 200.0,
                              child: Material(
                                borderRadius: BorderRadius.circular(0.0),
                                shadowColor: Colors.white,
                                color: Colors.white,
                                elevation: 0.0,
                                child: GestureDetector(
                                  onTap: () {},
                                  child: Center(
                                    child: Text(
                                      snapshot.data["NIC"],
                                      style: style,
                                    ),
                                  ),
                                ),
                              )),
                          SizedBox(height: 20.0),
                          Container(
                              height: 30.0,
                              width: 200.0,
                              child: Material(
                                borderRadius: BorderRadius.circular(00.0),
                                shadowColor: Colors.white,
                                color: Colors.white,
                                elevation: 0.0,
                                child: GestureDetector(
                                  onTap: () {},
                                  child: Center(
                                    child: Text(
                                      snapshot.data["Faculty"],
                                      style: style,
                                    ),
                                  ),
                                ),
                              )),
                          SizedBox(height: 20.0),
                          Container(
                              height: 30.0,
                              width: 200.0,
                              child: Material(
                                borderRadius: BorderRadius.circular(0.0),
                                shadowColor: Colors.white,
                                color: Colors.white,
                                elevation: 0.0,
                                child: GestureDetector(
                                  onTap: () {},
                                  child: Center(
                                    child: Text(
                                      snapshot.data["Year"] + "  Year",
                                      style: style,
                                    ),
                                  ),
                                ),
                              )),
                          SizedBox(height: 20.0),
                          Container(
                              height: 30.0,
                              width: 200.0,
                              child: Material(
                                borderRadius: BorderRadius.circular(0.0),
                                shadowColor: Colors.white,
                                color: Colors.white,
                                elevation: 0.0,
                                child: GestureDetector(
                                  onTap: () {},
                                  child: Center(
                                    child: Text(
                                      snapshot.data["Telephone"],
                                      style: style,
                                    ),
                                  ),
                                ),
                              )),
                          SizedBox(height: 25.0),
                          /* Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          Container(
                              height: 30.0,
                              width: 95.0,
                              child: Material(
                                borderRadius: BorderRadius.circular(20.0),
                                shadowColor: Colors.greenAccent,
                                color: Colors.green,
                                elevation: 7.0,
                                child: GestureDetector(
                                  onTap: () {},
                                  child: Center(
                                    child: Text(
                                      'Edit Name',
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontFamily: 'Montserrat'),
                                    ),
                                  ),
                                ),
                              )),
                          Container(
                              height: 30.0,
                              width: 95.0,
                              child: Material(
                                borderRadius: BorderRadius.circular(20.0),
                                shadowColor: Colors.blueAccent,
                                color: Colors.red,
                                elevation: 7.0,
                                child: GestureDetector(
                                  onTap: () {},
                                  child: Center(
                                    child: Text(
                                      'Edit Photo',
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontFamily: 'Montserrat'),
                                    ),
                                  ),
                                ),
                              )),
                          Container(
                              height: 30.0,
                              width: 95.0,
                              child: Material(
                                borderRadius: BorderRadius.circular(20.0),
                                shadowColor: Colors.redAccent,
                                color: Colors.red,
                                elevation: 7.0,
                                child: GestureDetector(
                                  onTap: () {},
                                  child: Center(
                                    child: Text(
                                      'Log out',
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontFamily: 'Montserrat'),
                                    ),
                                  ),
                                ),
                              ))
                        ],
                      ),*/
                        ],
                      ));
                }
              },
            ),
          ],
        ));
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

  Future<void> editDialog(String field, String id) async {
    String name;
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
}

class getClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = new Path();

    path.lineTo(0.0, size.height / 1.9);
    path.lineTo(size.width + 125, 0.0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    // TODO: implement shouldReclip
    return true;
  }
}
