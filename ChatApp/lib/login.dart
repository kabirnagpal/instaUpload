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
          isLoading = false;
          Navigator.pushNamed(context, '/Profile');
        }
    }
    catch(e){print(e);
    Navigator.pop(context);}
  }
  String email,password;
  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueAccent,
      appBar: AppBar(
        title: Text("Login"),
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
                  verifyUser(email, password);
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