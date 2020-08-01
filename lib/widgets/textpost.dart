import 'package:flutter/material.dart';

import 'package:shringari/widgets/holder.dart';

class TextPost extends StatelessWidget {
  final String text;
  final String timeStamp;
  TextPost(this.text, this.timeStamp);
  @override
  Widget build(BuildContext context) {
    return Holder(
      timeStamp: timeStamp,
      child: Text(
        text,
        textAlign: TextAlign.center,
        style: TextStyle(fontSize: 30),
      ),
    );
  }
}
