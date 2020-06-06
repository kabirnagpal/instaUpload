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
  bool isimage = false;

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
  print(selected);
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
          child: isimage ? Image.file(_imageFile):null
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
                  onPressed: uploadFile,
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}