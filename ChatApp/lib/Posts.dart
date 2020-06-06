import 'package:flutter/material.dart';

class ListElements extends StatefulWidget {
  String url,caption;
  ListElements({this.url,this.caption});
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
            child: Image.network(widget.url),
          ),
          Text(
            widget.caption,
            textScaleFactor: 1.5,
          ),
          SizedBox(
            height: 20,
          )
        ]
      ),
    );
  }
}