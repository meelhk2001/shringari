import 'package:flutter/material.dart';
import '../zoomed/fullsocial.dart';
import 'dart:async';
import 'package:webview_flutter/webview_flutter.dart';
import 'holder.dart';
//import 'package:flutter_html/flutter_html.dart';

class Social extends StatefulWidget {
  final String link;
  final String timeStamp;
  Social(this.link, this.timeStamp);
  @override
  _SocialState createState() => _SocialState();
}

class _SocialState extends State<Social> {
  final Completer<WebViewController> _controller =
      Completer<WebViewController>();

  @override
  Widget build(BuildContext context) {
    return Holder(
      timeStamp: widget.timeStamp,
      child: ConstrainedBox(
        constraints: new BoxConstraints(
    //minHeight: 35.0,
    maxHeight: MediaQuery.of(context).size.width * 1.3,
  ),
        // width: double.infinity,
        // height: MediaQuery.of(context).size.width * 1.3,
        child: Stack(
          children: [
            WebView(
            
              gestureNavigationEnabled: false,
              debuggingEnabled: false,
              initialUrl: widget.link,
              javascriptMode: JavascriptMode.unrestricted,
              onWebViewCreated: (WebViewController webViewController) {
                _controller.complete(webViewController);
              },
            ),
            GestureDetector(
              onTap: (){
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => FullSocial(widget.link)));
              },
            )
          ],
        ),
      ),
    );
  }
}
