import 'package:flutter/material.dart';

class ListElements extends StatefulWidget {
  @override
  _ListElementsState createState() => _ListElementsState();
}

class _ListElementsState extends State<ListElements> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[
          Container(
            width: 250,
            child: Image.asset('images/user.png'),
          ),
          Text(
            "Captions",
            textScaleFactor: 2,
          ),
          SizedBox(
            height: 20,
          )
        ]
      ),
    );
  }
}