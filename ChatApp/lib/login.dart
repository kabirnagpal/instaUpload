import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  var _auth = FirebaseAuth.instance;
  void verifyUser(email,password)async{
    try{
      AuthResult a = await _auth.signInWithEmailAndPassword(
        email: email, password: password);
        if(a!=null){
          Navigator.pushNamed(context, '/Chats');
        }
    }
    catch(e){print(e);
    Navigator.pop(context);}
  }
  String email,password;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: <Widget>[
            TextFormField(
              decoration: InputDecoration(
                helperText: 'Email'
              ),
              onChanged: (value){
                email = (value);
              }            
            ),
            TextFormField(
              obscureText: true,
              decoration: InputDecoration(
                helperText: 'Password'
              ),
              onChanged: (value){
                password = (value);
              }            
            ),
            FlatButton(onPressed: (){
              setState(() {
                verifyUser(email,password);
              });
            }, 
            child: Text("Submit"))
          ],
        )
      ),
    );
  }
}