import 'package:ChatApp/regsiter.dart';
import 'package:flutter/material.dart';
import 'login.dart';
import 'regsiter.dart';
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
    '/Register': (context) =>Register()
  },
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
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
    return FlatButton(
      onPressed: (){
        Navigator.pushNamed(
        context, route);
      },
      child: text,
      );
  }
}
