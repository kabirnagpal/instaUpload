import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Register extends StatefulWidget {

  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  void createUser(var email,var password)async{
    AuthResult a;
    try{
      a = await _auth.createUserWithEmailAndPassword(
      email: email, 
      password: password
      );
      if(a!=null){
        Navigator.popAndPushNamed(context, '/Login');
      }
    }
    catch(e){
      print(e);
      Navigator.pop(context);
    }     
  }

    var _auth = FirebaseAuth.instance;
    String email,password;
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Register"),
      ),
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
                createUser(email, password);
              });
            }, 
            child: Text("Submit"))
          ],
        )
      ),
    );
  }
}