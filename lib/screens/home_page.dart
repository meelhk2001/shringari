import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'add_post.dart';
import '../widgets/textpost.dart';
import '../widgets/imagepost.dart';
import '../widgets/videopost.dart';
import '../widgets/facebook.dart';
import '../widgets/youtube.dart';
import '../widgets/twitter.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  var _show = true;
  bool isScrollingDown = false;
  ScrollController scroll = ScrollController();
  //var _change = true;
  @override
  void initState() {
    myScroll();
    super.initState();
  }

  @override
  void dispose() {
    scroll.removeListener(() {});
    super.dispose();
  }

  void myScroll() async {
    scroll.addListener(() {
      if (scroll.position.userScrollDirection == ScrollDirection.reverse) {
        if (!isScrollingDown) {
          isScrollingDown = true;
          //_showAppbar = false;
          setState(() {
            _show = false;
          });
        }
      }
      if (scroll.position.userScrollDirection == ScrollDirection.forward) {
        if (isScrollingDown) {
          isScrollingDown = false;
          //_showAppbar = true;
          setState(() {
            _show = true;
          });
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIOverlays([]);

    return Scaffold(
      floatingActionButton: _show
          ? SpeedDial(
              animatedIcon: AnimatedIcons.menu_close,
              children: [
                SpeedDialChild(
                    child: Icon(Icons.add),
                    label: 'Add Post',
                    onTap: () {
                      Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => AddPost()))
                          .whenComplete(() => () {
                                setState(() {});
                              });
                    }),
                SpeedDialChild(
                    child: Icon(Icons.dashboard), label: 'Your Content')
              ],
            )
          : null,
      body: Stack(
        children: [
          StreamBuilder<dynamic>(
              stream: Firestore.instance
                  .collection('posts')
                  .orderBy('timeStamp', descending: true)
                  .snapshots(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  var document = snapshot.data.documents;
                  return ListView.builder(
                      controller: scroll,
                      itemCount: snapshot.data.documents.length,
                      itemBuilder: (context, index) => Column(
                            children: [
                              if (index == 0)
                                Image.asset(
                                  'assets/shringari.png',
                                  fit: BoxFit.cover,
                                ),
                              document[index]['dataType'] == 0
                                  ? TextPost(document[index]['link'],
                                      document[index]['timeStamp'])
                                  : document[index]['dataType'] == 1
                                      ? ImagePost(document[index]['link'],
                                          document[index]['timeStamp'])
                                      : document[index]['dataType'] == 2
                                          ? VideoPost(document[index]['link'],
                                              document[index]['timeStamp'])
                                          : document[index]['dataType'] == 3
                                              ? Twitter(document[index]['link'],
                                                  document[index]['timeStamp'])
                                              : document[index]['dataType'] == 4
                                                  ? Facebook(
                                                      document[index]['link'],
                                                      document[index]
                                                          ['timeStamp'])
                                                  : document[index]
                                                              ['dataType'] ==
                                                          5
                                                      ? Facebook(
                                                          document[index]
                                                              ['link'],
                                                          document[index]
                                                              ['timeStamp'])
                                                      : Youtube(
                                                          document[index]
                                                              ['link'],
                                                          document[index]
                                                              ['timeStamp']),
                            ],
                          ));
                } else {
                  return Center(child: Text('Loading.......'));
                }
              }),
          if (_show)
            Padding(
              padding: EdgeInsets.only(
                  top: 30, right: MediaQuery.of(context).size.width * 0.75),
              child: InkWell(
                onTap: () {
                  scroll.animateTo(
                    0.0,
                    duration: const Duration(milliseconds: 300),
                    curve: Curves.easeOut,
                  );
                },
                child: ClipRRect(
                  child: Container(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        //SizedBox(width: 30,),
                        Text(
                          'Shringari',
                          style: TextStyle(fontSize: 20, color: Colors.black),
                        ),
                        SizedBox(),
                      ],
                    ),
                    height: 35,
                    color: Colors.orange[300],
                  ),
                  borderRadius: BorderRadius.only(
                      topRight: Radius.circular(180),
                      bottomRight: Radius.circular(180)),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
