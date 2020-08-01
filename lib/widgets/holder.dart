import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Holder extends StatelessWidget {
  final Widget child;
  final String timeStamp;
  Holder({this.child, this.timeStamp});
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: Container(
              color: Colors.black12,
              padding: EdgeInsets.all(10),
              width: MediaQuery.of(context).size.width,
              child: child,//add here
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(
              left: 10.0,
              right: 10,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  DateFormat('dd/MMM/yyyy').format(
                      DateTime.fromMillisecondsSinceEpoch(
                          int.parse(timeStamp))),
                  style: TextStyle(color: Colors.orange[300]),
                ),
                IconButton(
                    icon: Icon(Icons.delete_forever,color: Colors.orange[300],),
                    onPressed: () {
                      showDialog(
                          context: context,
                          builder: (context) => AlertDialog(
                                content: Container(
                                  height:
                                      MediaQuery.of(context).size.width * 0.30,
                                  child: Column(
                                    children: [
                                      RaisedButton(
                                          onPressed: () {
                                            try {
                                              Firestore.instance
                                                  .collection('posts')
                                                  .document(timeStamp)
                                                  .delete();
                                            } catch (error) {
                                              throw error;
                                            }
                                            Navigator.of(context).pop();
                                          },
                                          child: Text('Delete Post')),
                                      SizedBox(height: 5),
                                      FlatButton(
                                          onPressed: () {
                                            Navigator.of(context).pop();
                                          },
                                          child: Text('Cancel'))
                                    ],
                                  ),
                                ),
                              ));
                    })
              ],
            ),
          ),
          SizedBox(height: 8),
          Divider(
            height: 1,
            color: Colors.black38,
          ),
          SizedBox(height: 10)
        ],
      ),
    );
  }
}
