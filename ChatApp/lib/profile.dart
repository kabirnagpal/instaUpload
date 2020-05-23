import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class Profile extends StatefulWidget {
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {

File _imageFile;

Future <void>_pickImage(ImageSource source) async{
  File selected = await ImagePicker.pickImage(source: source);
  setState(() {
    _imageFile = selected;
  });
}

void _clear(){
  setState(() {
    _imageFile=null;
  });
}
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(
        title: Text("Upload Image"), 
      ),
      bottomNavigationBar: BottomAppBar(
        child: Row(
          children: <Widget>[
            IconButton(
              icon: Icon(Icons.photo_camera),
              onPressed: () => _pickImage(ImageSource.camera),
              ),
            IconButton(
              icon: Icon(Icons.photo_album),
              onPressed: () => _pickImage(ImageSource.gallery),
              ),
          ],
        ),
      ),
      
      body: ListView(
        children: <Widget>[
          if (_imageFile != null) ...[
            Container(
                padding: EdgeInsets.all(32), child: Image.file(_imageFile)),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                FlatButton(
                  color: Colors.black,
                  child: Icon(Icons.refresh),
                  onPressed: _clear,
                ),
              ],
            ),
          ]
        ],
      ),
    );
  }
}