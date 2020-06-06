import 'package:ChatApp/regsiter.dart';
import 'package:ChatApp/upload_post.dart';
import 'package:flutter/material.dart';
import 'login.dart';
import 'regsiter.dart';
import 'profile.dart';
import 'upload.dart';
import 'upload_post.dart';
void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: '/',
    routes: {
    '/Login': (context) => Login(),
    '/Register': (context) =>Register(),
    '/Upload': (context) =>Upload(),
    '/Profile': (context)=>Profile(),
    '/UploadPost':(context)=>UploadPost()
  },
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.deepPurple,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueAccent,
      appBar: AppBar(
        centerTitle: true,
        title: Text("ChatAPP"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            EntryButtons(text: Text("Login"), route:'/Login'),
            EntryButtons(text: Text("Register"), route: '/Register')
          ],
        ),
      ),
    );
  }
}

class EntryButtons extends StatelessWidget {
final text;
final route;
EntryButtons({this.text,this.route});

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      elevation: 5,
      textColor: Colors.white70,
      color: Colors.deepPurple,
      onPressed: (){
        Navigator.pushNamed(
        context, route);
      },
      child: text,
      );
  }
}
