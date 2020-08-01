import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';

class ImageZoom extends StatelessWidget {
  final String link;
  ImageZoom(this.link);
  @override
  Widget build(BuildContext context) {
    print(link);
    return Scaffold(
      body: Container(
        child: PhotoView(imageProvider: NetworkImage(link)),
      ),
      
    );
  }
}