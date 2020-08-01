import 'package:flutter/material.dart';
import '../zoomed/imagepost.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'holder.dart';

class ImagePost extends StatelessWidget {
  final String link;
  final String timeStamp;
  ImagePost(this.link, this.timeStamp);
  @override
  Widget build(BuildContext context) {
    return Holder(
      timeStamp: timeStamp,
                    child: GestureDetector(
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => ImageZoom(link)));
          },
          child:
          //Image.network(link,fit: BoxFit.cover,),
           CachedNetworkImage(
             fit: BoxFit.cover,
            imageUrl: link,
            fadeInCurve: Curves.easeIn,
            fadeInDuration: Duration(milliseconds: 1000),
            placeholder: (context, link) =>
                Image.asset('assets/placeholder.png'),
          )
          ),
    );
  }
}
