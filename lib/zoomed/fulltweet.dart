import 'package:flutter/material.dart';
import 'package:tweet_webview/tweet_webview.dart';

class FullTweet extends StatelessWidget {
  final String link;
  FullTweet(this.link);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: TweetWebView.tweetUrl(link),
      ),
      
    );
  }
}