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
        isLoading = false;
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
    bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueAccent,
      appBar: AppBar(
        title: Text("Register"),
      ),
      body: SafeArea(
        child: Column(

          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              padding: EdgeInsets.symmetric(horizontal: 20,vertical: 5),
              child: TextFormField(
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.white54,
                  helperText: 'Email'
                ),
                onChanged: (value){
                  email = (value);
                }            
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 20,vertical: 5),
              child: TextFormField(
                obscureText: true,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.white54,
                  helperText: 'Password'
                ),
                onChanged: (value){
                  password = (value);
                }            
              ),
            ),
            if(isLoading) Center(
              child: CircularProgressIndicator(),
              )
            else  FlatButton(
              textColor: Colors.white70,
              color: Colors.deepPurple,
              onPressed: (){
                setState(() {
                  isLoading = true;
                  createUser(email, password);
                });
              }, 
              child: Text("Submit")
            ), 
          ],
        )
      ),
    );
  }
}