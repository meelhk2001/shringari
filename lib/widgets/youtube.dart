import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import 'holder.dart';
import '../zoomed/fullyoutube.dart';

class Youtube extends StatefulWidget {
  final String id;
  final String timeStamp;

  Youtube(this.id, this.timeStamp);

  @override
  _YoutubeState createState() => _YoutubeState();
}

class _YoutubeState extends State<Youtube> {
  YoutubePlayerController _controller;

  @override
  void didChangeDependencies() {
    if (_controller.value.isFullScreen) {
      _controller.toggleFullScreenMode();
    }
    super.didChangeDependencies();
  }

  @override
  void initState() {
    super.initState();
    _controller = YoutubePlayerController(
      initialVideoId: widget.id,
      flags: YoutubePlayerFlags(
        hideControls: false,
        mute: false,
        autoPlay: false,
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    return Holder(
      timeStamp: widget.timeStamp,
      child: Container(
        child: GestureDetector(
          onDoubleTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => FullYoutube(widget.id))).whenComplete(() { _controller.play(); SystemChrome.setPreferredOrientations(
        [DeviceOrientation.portraitDown, DeviceOrientation.portraitUp]);});
                     _controller.pause();
          },
          child: YoutubePlayer(
            actionsPadding: EdgeInsets.all(5),
            bottomActions: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(),
                  IconButton(icon: Icon(Icons.add), onPressed: () {})
                ],
              )
            ],
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
