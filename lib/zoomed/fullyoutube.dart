import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import 'package:flutter/services.dart';

class FullYoutube extends StatefulWidget {
  final String id;
  
  FullYoutube(this.id,);

  @override
  _FullYoutubeState createState() => _FullYoutubeState();
}

class _FullYoutubeState extends State<FullYoutube> {
  YoutubePlayerController _controller;
  @override
  void initState() {
    
    _controller = YoutubePlayerController(
      initialVideoId: widget.id,
      
      flags: YoutubePlayerFlags(

        hideControls: false,
        mute: false,
        autoPlay: true,
      ),
    );
    _controller.toggleFullScreenMode();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations(
        [DeviceOrientation.landscapeLeft, DeviceOrientation.landscapeRight]);
    return Scaffold(
      body: Center(
        child: GestureDetector(
          //onDoubleTap: () {},
          child: YoutubePlayer(
            controller: _controller,
            showVideoProgressIndicator: true,
            onReady: () {
              print('Player is ready.');
            },
          ),
        ),
      ),
    );
  }
}
