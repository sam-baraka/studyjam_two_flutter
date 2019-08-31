import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
//Firebase stuff
import 'package:cloud_firestore/cloud_firestore.dart';
//Like button
import 'package:like_button/like_button.dart';

class HomeTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: StreamBuilder<QuerySnapshot>(
          stream: Firestore.instance.collection('posts').orderBy('date', descending: true).snapshots(),
          builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.hasError) return Text('Error');
            switch (snapshot.connectionState) {
              case ConnectionState.waiting:
                return Center(
                  child: CupertinoActivityIndicator(),
                );
              default:
                return ListView(
                    children:
                    snapshot.data.documents.map((DocumentSnapshot document) {
                      return Card(
                        child: Column(
                          children: <Widget>[
                            Container(
                              height: 250.0,
                              child: Stack(
                                children: <Widget>[
                                  Positioned.fill(
                                    child: Image.network(
                                      document['image'],
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                  Positioned(
                                    bottom: 0.0,
                                    left: 0.0,
                                    right: 0.0,
                                    child: Material(
                                      color: Colors.black54,
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.end,
                                        //alignment: MainAxisAlignment.end,
                                        children: <Widget>[
                                      Expanded(child: Text(document['caption'], style: TextStyle(color: Colors.white),)),
                                          LikeButton(),
                                          CupertinoButton(
                                            child: Text('Share'),
                                            onPressed: () {},
                                          )
                                        ],
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),
                      );
                    }).toList());
            }
          },
        ));
  }
}

