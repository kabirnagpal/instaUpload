import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
class Upload extends StatefulWidget {
  @override
  _UploadState createState() => _UploadState();
}

class _UploadState extends State<Upload> {

  @override
  void initState() {
    getCurrUser();
    super.initState();
  }

  void getCurrUser() async {
    FirebaseUser user = await _auth.currentUser();
    setState(() {
      userEmail = user.email;
    });
  }

  String userEmail;
var _auth = FirebaseAuth.instance;
File _imageFile;

Future uploadFile() async {    
   StorageReference storageReference = FirebaseStorage.instance    
       .ref()    
       .child('Profiles/'+userEmail.split('.com')[0]+'.jpeg');    
   StorageUploadTask uploadTask = storageReference.putFile(_imageFile);    
   await uploadTask.onComplete;    
   print('File Uploaded');      
   Navigator.pushReplacementNamed(context,'/Profile');
 }  

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
                FlatButton(
                  color: Colors.black,
                  child: Icon(Icons.update),
                  onPressed: uploadFile,
                ),
              ],
            ),
          ]
        ],
      ),
    );
  }
}