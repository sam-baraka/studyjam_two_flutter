import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:io';
import 'package:path/path.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:firebase_auth/firebase_auth.dart';

class NewPost extends StatefulWidget {

  @override
  _NewPostState createState() => _NewPostState();
}

class _NewPostState extends State<NewPost> {
  File _image;
  var caption=TextEditingController();
  @override
  Widget build(BuildContext context) {
Future getImage() async {
      var image = await ImagePicker.pickImage(source: ImageSource.gallery);

      setState(() {
        _image = image;
          print('Image Path $_image');
      });
    }

    Future uploadPic(BuildContext context) async{
      String fileName = basename(_image.path);
       StorageReference firebaseStorageRef = await FirebaseStorage.instance.ref().child(fileName);
       StorageUploadTask uploadTask = firebaseStorageRef.putFile(_image);
       var user=await FirebaseAuth.instance.currentUser();
       var imageurl=await (await uploadTask.onComplete).ref.getDownloadURL();
       var url=imageurl.toString();
       print(user.uid);
       print(url);
      await Firestore.instance.collection('posts').document().setData({ 'image': imageurl, 'caption': caption.text,'date': DateTime.now(), 'userid': user.uid });
      print("Post uploaded");
      Scaffold.of(context).showSnackBar(SnackBar(content: Text('Post Uploaded')));
    }

    return Scaffold(
        body: Container(
          child: ListView(
            children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: GestureDetector(
                      onTap: (){
                        getImage();
                      },
                      child: Container(
                        height: 250.0,
                        child: (_image!=null)?Image.file(
                          _image,
                          fit: BoxFit.cover,
                        ):Center(child: Text('Pick an Image'),)
                      ),
                    ),
                  ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: CupertinoTextField(
                    controller: caption,
                    placeholder: "Enter Caption",
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: CupertinoButton(
                    onPressed: (){
                      uploadPic(context);
                    },
                    color: Colors.blue,
                    child: Text("Upload Post"),
                  ),
                )

            ],
          ),
        ),
        );
  }
}
