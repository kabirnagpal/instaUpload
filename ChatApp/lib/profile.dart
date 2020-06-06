import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'Posts.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Profile extends StatefulWidget {
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {

  Image _userImage = Image.asset('images/user.png');

  void trytogetImage() async{
    try{
      StorageReference storageReference = FirebaseStorage.instance.ref()    
        .child('Profiles/'+title.split('.com')[0]+'.jpeg');
      String downloadAddress = await storageReference.getDownloadURL();
      setState(() {
        _userImage = Image.network(downloadAddress);
      });    
    }
    catch(e){
      print(e);
    }
  }
  
  void getCurrUser() async {
    
    FirebaseUser user = await _auth.currentUser();
    setState(() {
      title = user.email;
      trytogetImage();
    });
  }
  
  var _cloud = Firestore.instance;

  @override
  void initState() {
    getCurrUser();
    super.initState();    
  }

  List<Widget> ele = [ Text("No more to show") ];

  void addListEle(){
    setState(() {
    ele.insert(0,ListElements());
    print(ele);  
    });
    
  }
  
  String title = "Welcome";
  var _auth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    
    trytogetImage();
    return Scaffold(
      backgroundColor: Colors.blueAccent,
      appBar: AppBar(
        title: Text(title),
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            flex: 3,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                CircleAvatar(
                  child: _userImage,
                  radius: 50,
                ),
                FlatButton(
                  textColor: Colors.white70,
                  color: Colors.deepPurple,
                  onPressed: (){
                    setState(() {
                    Navigator.pushNamed(context, '/Upload');
                    trytogetImage();  
                    });
                  }, 
                  child: Text("Upload Profile Pic"),
                ),
              ],  
            ),
          ),
          Expanded(
            flex:1,
            child: Text(
              "Your Posts",
              textScaleFactor: 3,
              style: TextStyle(
                color: Colors.white70
              ),
            )
          ),
          Expanded(
            flex: 7,
            child: StreamBuilder(
              stream: _cloud.collection('Posts').document(title).collection('UserPosts').snapshots(),
              builder: (context,snapshot){
                if(snapshot.hasData){
                  return ListView.builder(
                    itemCount: snapshot.data.documents.length,
                    itemBuilder: (BuildContext context,int index){
                      return Container(child: ListElements(
                        url: snapshot.data.documents[index].data['url'].toString(),
                        caption: snapshot.data.documents[index].data['caption'].toString(),
                        ));
                    }
                  );
                }
                else{
                  return Container(
                    child: Text("Make your first post"),
                  );
                }
              }
            ),
          ),
          FloatingActionButton(
            child: Icon(Icons.add_a_photo),
            onPressed: (){
              setState(() {
                Navigator.pushNamed(context, '/UploadPost');
                addListEle();
              });
            }
          )
        ],
      ),
    );
  }
}