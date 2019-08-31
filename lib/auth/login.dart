import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:studyjam_blog/main.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  var email=TextEditingController();
  var password=TextEditingController();

  Future LoginUser ()async{
    try{
      await FirebaseAuth.instance.signInWithEmailAndPassword(email: email.text,password: password.text);
      print("Login success");
      var user=await FirebaseAuth.instance.currentUser();
      Navigator.pushReplacement(context,MaterialPageRoute(builder: (BuildContext context)=>MyHomePage(userid: user.uid)));
    }
    catch(e){
      print(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CupertinoNavigationBar(
        middle: Text("Login to Flutter Blog"),
    ),
    body: ListView(
      children: <Widget>[
        FlutterLogo(
         size:250
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: CupertinoTextField(
            controller: email,
            placeholder: "Email",
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: CupertinoTextField(
            controller: password,
            placeholder: "Password",
            obscureText: true,
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: CupertinoButton(child: Text("Login"),onPressed: (){
            LoginUser();
          },),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: CupertinoButton(child: Text("Register"),onPressed: (){
            Navigator.push(context, MaterialPageRoute(builder: (BuildContext context)=>RegisterPage()));
          },),
        )
      ],
    ),
    );
  }
}

class RegisterPage extends StatefulWidget {
  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  var name=TextEditingController();
  var email=TextEditingController();
  var password=TextEditingController();
  

  Future RegisterUser() async{
    try{
    await print(email.toString());
    await FirebaseAuth.instance.createUserWithEmailAndPassword(email: email.text,password: password.text);
    print("Success");
    var user=await FirebaseAuth.instance.currentUser();
    await print(user.uid);
    await Firestore.instance.collection('users').document(user.uid).setData({'name':name.text,'email':email.text});
    Navigator.pop(context);
    }
    catch(e){
      print(e.toString());
    }

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: CupertinoNavigationBar(middle: Text("Sign up"),),
    body: ListView(
      children: <Widget>[
         FlutterLogo(
         size:250
        ),
         Padding(
          padding: const EdgeInsets.all(8.0),
          child: CupertinoTextField(
            controller: name,
            placeholder: "Full Name",
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: CupertinoTextField(
            controller: email,
            placeholder: "Email",
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: CupertinoTextField(
            controller: password,
            obscureText: true,
            placeholder: "Password",
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: CupertinoButton(
            onPressed: (){
              RegisterUser();
            },
            child: Text("Register"),
          )
        ),
      ],
    ),
    );
  }
}