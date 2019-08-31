import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Favourites extends StatefulWidget {
  
  @override
  _FavouritesState createState() => _FavouritesState();
}

class _FavouritesState extends State<Favourites> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SlideShow()
    );
  }
}

class SlideShow extends StatefulWidget {
  @override
  _SlideShowState createState() => _SlideShowState();
}
 

class _SlideShowState extends State<SlideShow> {
  ///View port fraction to take 80 % of the display
  final PageController ctrl = PageController(viewportFraction: 0.8);

  ///Firestore instance
  final Firestore db = Firestore.instance;
  Stream slides;
  //String activeTag = 'favorites';

  // Keep track of current page to avoid unnecessary renders
  int currentPage = 0;

  @override
  void initState() {
    _queryDb();
    
    // Set state when page changes
    ctrl.addListener(() { 
      int next = ctrl.page.round();

      if(currentPage != next) { 
        setState(() {
          currentPage = next;
        });
      } 
    });
  }
  
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: slides,
      initialData: [

      ],
      builder: (context, AsyncSnapshot snap) { 
      List slideList = snap.data.toList();
      return PageView.builder(
        controller: ctrl,
        itemCount: slideList.length + 1,
         itemBuilder: (context, int currentIdx) {
              if (currentIdx == 0) {
                return _buildFirstPage();
              } else if (slideList.length >= currentIdx) {
                // Active page
                bool active = currentIdx == currentPage;
                return _buildStoryPage(slideList[currentIdx - 1], active);
              }
            }
      );
      }
    );
  }
  ///Build Story Page
  _buildStoryPage(Map data, bool active) {
     // Animated Properties
    final double blur = active ? 30 : 0;
    final double offset = active ? 20 : 0;
    final double top = active ? 100 : 200;


    return AnimatedContainer(
      duration: Duration(milliseconds: 500),
      curve: Curves.easeOutQuint,
      margin: EdgeInsets.only(top: top, bottom: 50, right: 30),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),

        image: DecorationImage(
            fit: BoxFit.cover,
            image: NetworkImage(data['image']),
        ),
        

        boxShadow: [BoxShadow(color: Colors.black87, blurRadius: blur, offset: Offset(offset, offset))]
      ),
      child: Center(
        child: Material(color: Colors.black38,child: Text(data['caption'], style: TextStyle(fontSize: 30, color: Colors.white),)),
      ),

    );
  }

  ///Build the initial page
   _buildFirstPage() {
    return Container(child: 
      Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
    
        children: [
          Text('View posts as'),
          Text('Story View', style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),),
          Row(children: <Widget>[
            Expanded(child: Text('Inspired by reflectly, one of the beautiful apps made with fluttter')),
            FlutterLogo()
          ],),
          Text('Swipe up to view the full image', style: TextStyle(color: Colors.red),),
        ],
      )
    );
  }


  Stream _queryDb(
    //{ String tag ='favorites' }
    ) {
    
    // Make a Query
    Query query = db.collection('posts').orderBy('date', descending: true);

    // Map the documents to the data payload
    slides = query.snapshots().map((list) => list.documents.map((doc) => doc.data));

    // Update the active tag
    // setState(() {
    //   activeTag = tag;
    // });

  }
}

