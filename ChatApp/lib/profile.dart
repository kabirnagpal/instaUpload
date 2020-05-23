import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Profile extends StatefulWidget {
  @override
  _ProfileState createState() => _ProfileState();
}
class _ProfileState extends State<Profile> {
  
  
  void getCurrUser() async {
    
    FirebaseUser user = await _auth.currentUser();
    setState(() {
      title = user.email;
    });
  }
  String title = "Welcome";
  var _auth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    getCurrUser();
    return Scaffold(
      
      appBar: AppBar(
        title: Text(title),
      ),
      body: Column(
        children: <Widget>[
          FlatButton(
            onPressed: (){
              Navigator.pushNamed(context, '/Upload');
            }, 
            child: Text("upload Image"),
          )
        ],
      ),
    );
  }
}