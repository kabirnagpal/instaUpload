import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Chats extends StatefulWidget {
  @override
  _ChatsState createState() => _ChatsState();
}
class _ChatsState extends State<Chats> {
  
  
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
    );
  }
}