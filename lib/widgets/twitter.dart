import 'package:flutter/material.dart';
import 'package:tweet_webview/tweet_webview.dart';
import '../zoomed/fulltweet.dart';
import 'holder.dart';

class Twitter extends StatelessWidget {
  final String link;
  final String timeStamp;
  Twitter(this.link, this.timeStamp);
  @override
  Widget build(BuildContext context) {
    return Holder(
      timeStamp: timeStamp,
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.width * 1.5,
        child: Stack(
          children: [
            TweetWebView.tweetUrl(link),
            GestureDetector(
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => FullTweet(link)));
              },
            )
          ],
        ),
      ),
    );
  }
}
