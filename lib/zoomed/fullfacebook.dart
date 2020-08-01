import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'dart:async';

class FullFacebook extends StatelessWidget {
  final String link;
  FullFacebook(this.link);
  final Completer<WebViewController> _controller =
      Completer<WebViewController>();
      
  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      body: Center(
        child: WebView(
          
          initialUrl: link,
          javascriptMode: JavascriptMode.unrestricted,
          onWebViewCreated: (WebViewController webViewController) {
            _controller.complete(webViewController);
          },
        ),
      ),
    );
  }
}
