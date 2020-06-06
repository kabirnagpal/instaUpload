import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class UploadPost extends StatefulWidget {
  @override
  _UploadPostState createState() => _UploadPostState();
}

class _UploadPostState extends State<UploadPost> {
  void uploadPost()async{
    try{
      if(caption==null)
        caption=' ';
      var now = new DateTime.now();
      StorageReference storageReference = FirebaseStorage.instance    
        .ref()    
        .child('DataPosts/'+userEmail.split('.com')[0]+'/'+now.toString()+'.jpeg');    
      StorageUploadTask uploadTask = storageReference.putFile(_imageFile);    
      await uploadTask.onComplete;    
      print('File Uploaded');
      String downloadAddress = await storageReference.getDownloadURL();
      
      _cloud.collection('Posts').document(userEmail).collection('UserPosts').add({
        "url":downloadAddress,
        "caption":caption
      });
    }catch(e){print(e);} 
    Navigator.pop(context);
  }
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
  String userEmail,caption = ' ';
  var _auth = FirebaseAuth.instance;
  File _imageFile;
  var _cloud = Firestore.instance;
  bool isimage = false;
  Future <void>_pickImage(ImageSource source) async{
  File selected = await ImagePicker.pickImage(source: source);
  setState(() {
    _imageFile = selected;
    if(selected==null)
      _clear();
    else 
      isimage = true;
  });
}

void _clear(){
  setState(() {
    _imageFile=null;
    isimage = false;
  });
}
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueAccent,
      appBar: AppBar(
        title: Text("Upload Image"), 
      ),
      body: Container(
        padding: EdgeInsets.all(32), 
        child: ListView(
          children: <Widget>[
            if(_imageFile != null)...[
            Image.file(_imageFile),
            TextFormField(
                      decoration: InputDecoration(
                        helperText: 'Enter some captions'
                        ),
                      onChanged: (value){
                        caption = (value);
                        }            
                      )
            ]
          ],
        )
      ),
      bottomNavigationBar: BottomAppBar(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            if (_imageFile == null)...[
              Expanded(
                  child: IconButton(
                  icon: Icon(Icons.photo_camera),
                  onPressed: () => _pickImage(ImageSource.camera),
                  ),
              ),
              Expanded(
                  child: IconButton(
                  icon: Icon(Icons.photo_album),
                  onPressed: () => _pickImage(ImageSource.gallery),
                  ),
              ),
            ]
            else...[
              Expanded(
                child: FlatButton(
                  child: Icon(Icons.delete),
                  onPressed: _clear,
                ),
              ),
              Expanded(
                child: FlatButton(
                  child: Icon(Icons.file_upload),
                  onPressed: uploadPost,
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}