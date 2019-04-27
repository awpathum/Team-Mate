import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'dart:async';

import 'package:teamapp/Pages/home.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => new _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  String _email, _password;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Sign in'),
      ),
      body: Form(
        key: _formKey,
        child: Column(
          children: <Widget>[
            TextFormField(
              validator: (input) {
                if (input.isEmpty) {
                  return 'Please Enter Email';
                }
              },
              onSaved: (input) => _email = input,
              decoration: InputDecoration(labelText: 'Enter Email'),
            ),
            TextFormField(
              validator: (input) {
                if (input.isEmpty) {
                  return 'Please enter password';
                }
              },
              onSaved: (input) => _password = input,
              decoration: InputDecoration(labelText: 'Password'),
              obscureText: true,
            ),
            RaisedButton(
              onPressed: signIn,
              child: Text('Sign in'),
            )
          ],
        ),
      ),
    );
  }

  Future<void> signIn() async{
    //validate fields
    final formState = _formKey.currentState;
    if (formState.validate()) {
      //loginto firebase
      formState.save();
      try{
          FirebaseUser user = await FirebaseAuth.instance.signInWithEmailAndPassword(email: _email,password: _password);
          //navigate to home
          Navigator.push(context, MaterialPageRoute(builder: (context) => Home()));
      }catch(e){
          print(e.message);
      }
      

    }
    
  }
}
