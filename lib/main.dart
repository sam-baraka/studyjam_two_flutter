import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/rendering.dart';

//Own tab pages
import 'package:studyjam_blog/tabpages/account.dart';
import 'package:studyjam_blog/tabpages/favourites.dart';
import 'package:studyjam_blog/tabpages/home.dart';
import 'package:studyjam_blog/tabpages/addnew.dart';
import 'package:studyjam_blog/auth/login.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Blog',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  final userid;
  const MyHomePage({Key key, this.userid}) : super(key: key);
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int currentTabIndex = 0;
  @override
  final tabPages = <Widget>[
    HomeTab(),

    ///Ignore this for now
    ///Reflectly inspired animation
    Favourites(),
    NewPost(),
    Account()
  ];
  final tabs = <BottomNavigationBarItem>[
    BottomNavigationBarItem(icon: Icon(Icons.home), title: Text("Home")),
    ///Also ignore this for now
    BottomNavigationBarItem(
        icon: Icon(Icons.stop_screen_share), title: Text("Story")),
    BottomNavigationBarItem(icon: Icon(Icons.add_a_photo), title: Text("New")),
    BottomNavigationBarItem(
        icon: Icon(Icons.account_circle), title: Text("Account"))
  ];
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        scrollDirection: Axis.vertical,
        slivers: <Widget>[
          CupertinoSliverNavigationBar(
            leading: FlutterLogo(
              size: 50,
            ),
            largeTitle: Text("Flutter Photo Blog"),
          ),
          SliverFillRemaining(
            child: tabPages[currentTabIndex],
          )
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentTabIndex,
        items: tabs,
        type: BottomNavigationBarType.fixed,
        onTap: (int index) {
          setState(() {
            print(index);
            currentTabIndex = index;
          });
        },
      ),
    );
  }
}
