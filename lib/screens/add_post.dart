import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AddPost extends StatefulWidget {
  @override
  _AddPostState createState() => _AddPostState();
}

class _AddPostState extends State<AddPost> {
  var dataType = 0;
  final facebookLink =
      'https://www.facebook.com/plugins/post.php?href=https%3A%2F%2Fwww.facebook.com%2F';
  final twitterLink = 'https://twitframe.com/show?url=';
  var link = TextEditingController();
  Future<void> _onPost(String link, int dataType) async {
    var timeStamp = DateTime.now().millisecondsSinceEpoch.toString();
    link.trim();
    
    try {

      if(dataType== 3){
        link = link.replaceAll('://', '%3A%2F%2F');
        link= link.replaceAll('/', '%2F');
        link = twitterLink + link;
      }

      if (dataType == 6) {
      if (link.contains('=')) {
        var sublink = link.substring(link.indexOf('=') + 1);
        link = sublink;
      }
      if (link.contains('.be/')) {
        var sublink = link.substring(link.indexOf('.be/') + 4);
        link = sublink;
      }
    }
    if (dataType == 4) {
      String s1;
      if (link.contains('?')) {
        s1 = link.substring(link.indexOf('.com/') + 5, link.indexOf('?') - 1);
      } else {
        s1 = link.substring(link.indexOf('.com/') + 5, link.length - 1);
      }
      s1 = s1.replaceAll('/', '%2F');
      link = facebookLink + s1;
    }
    if (dataType == 5) {
      link = link.substring(0, link.indexOf('?')) + 'embed';
    }

      var user = await FirebaseAuth.instance.currentUser();
      if (user == null) {
        return;
      }
      await Firestore.instance.collection('posts').document(timeStamp).setData({
        'link': link,
        'dataType': dataType,
        'timeStamp': timeStamp,
        'user': user.uid
      });
      Navigator.of(context).pop();
    } catch (error) {
      showDialog(
          context: context,
          builder: (context) => AlertDialog(
                content: Text('Unable to upload'),
                actions: [
                  FlatButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: Text('Okey'))
                ],
              ));

      throw error;
    }
  }

  @override
  void dispose() {
    link.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            padding: EdgeInsets.fromLTRB(10, 200, 10, 0),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  TextField(
                      cursorColor: Colors.orange[300],
                      maxLines: null,
                      //minLines: 4,
                      controller: link,
                      textInputAction: dataType != 0
                          ? TextInputAction.done
                          : TextInputAction.newline),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      IconButton(
                          icon: Icon(Icons.text_fields),
                          color: dataType == 0
                              ? Colors.orange[300]
                              : Colors.black12,
                          onPressed: () {
                            setState(() {
                              dataType = 0;
                            });
                            setState(() {});
                          }),
                      IconButton(
                          icon: Icon(Icons.image),
                          color: dataType == 1
                              ? Colors.orange[300]
                              : Colors.black12,
                          onPressed: () {
                            setState(() {
                              dataType = 1;
                            });
                          }),
                      IconButton(
                          icon: Icon(Icons.videocam),
                          color: dataType == 2
                              ? Colors.orange[300]
                              : Colors.black12,
                          onPressed: () {
                            setState(() {
                              dataType = 2;
                            });
                          }),

                      IconButton(
                          icon: FaIcon(FontAwesomeIcons.twitter),
                          color: dataType == 3
                              ? Colors.orange[300]
                              : Colors.black12,
                          onPressed: () {
                            setState(() {
                              dataType = 3;
                            });
                          }),
                      IconButton(
                          icon: FaIcon(FontAwesomeIcons.facebook),
                          color: dataType == 4
                              ? Colors.orange[300]
                              : Colors.black12,
                          onPressed: () {
                            setState(() {
                              dataType = 4;
                            });
                          }),
                      IconButton(
                          icon: FaIcon(FontAwesomeIcons.instagram),
                          color: dataType == 5
                              ? Colors.orange[300]
                              : Colors.black12,
                          onPressed: () {
                            setState(() {
                              dataType = 5;
                            });
                          }),
                      IconButton(
                          icon: FaIcon(FontAwesomeIcons.youtube),
                          color: dataType == 6
                              ? Colors.orange[300]
                              : Colors.black12,
                          onPressed: () {
                            setState(() {
                              dataType = 6;
                            });
                          }),
                      // IconButton(icon: Icon(Icons.text_fields), onPressed: (){}),
                    ],
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  FlatButton(
                    color: Colors.orange[300],
                    onPressed: () {
                      _onPost(link.text, dataType);
                    },
                    child: Text('Post'),
                  )
                ],
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(
                top: 30, right: MediaQuery.of(context).size.width * 0.75),
            child: GestureDetector(
              onTap: () {
                Navigator.of(context).pop();
              },
              child: ClipRRect(
                child: Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      Icon(
                        Icons.keyboard_backspace,
                        size: 35,
                      ),
                      //SizedBox(),
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
