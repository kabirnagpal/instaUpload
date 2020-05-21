import 'package:flutter/material.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
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
                
              });
            }, 
            child: Text("Submit"))
          ],
        )
      ),
    );
  }
}