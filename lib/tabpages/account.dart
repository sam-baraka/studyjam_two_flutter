import 'package:flutter/material.dart';

class Account extends StatefulWidget {
  @override
  _AccountState createState() => _AccountState();
}

class _AccountState extends State<Account> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Account",
      theme: ThemeData(primarySwatch: Colors.blue),
      home: AccountHome(),
    );
  }
}

class AccountHome extends StatefulWidget {
  @override
  _AccountHomeState createState() => _AccountHomeState();
}

class _AccountHomeState extends State<AccountHome> {
  @override
  Widget build(BuildContext context) {
    return Container(
      
    );
  }
}