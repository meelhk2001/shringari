import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import '../zoomed/fullvideo.dart';

import 'holder.dart';

class VideoPost extends StatefulWidget {
  final String link;
  final String timeStamp;
  VideoPost(this.link, this.timeStamp);

  @override
  _VideoPostState createState() => _VideoPostState();
}

class _VideoPostState extends State<VideoPost> {
  VideoPlayerController _controller;
  Future<void> _initializeVideoPlayerFuture;
  @override
  void initState() {
    _controller = VideoPlayerController.network(widget.link, useCache: true
    );

    _initializeVideoPlayerFuture = _controller.initialize();
    super.initState();
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
      child: GestureDetector(
        onDoubleTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) =>
                      FullVideo(widget.link, widget.timeStamp)));
        },
        onTap: () {
          print(_controller.value.initialized.toString());
          setState(() {
            if (_controller.value.isPlaying) {
              _controller.pause();
            } else if (_controller.value.position ==
                _controller.value.duration) {
              _controller.seekTo(Duration(microseconds: 1));
              _controller.play();
            } else {
              _controller.play();
            }
          });
        },
        child: Container(
          child: FutureBuilder(
            future: _initializeVideoPlayerFuture,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                return AspectRatio(
                  aspectRatio: _controller.value.aspectRatio,
                  child: Stack(
                    alignment: Alignment.bottomCenter,
                    children: [
                      VideoPlayer(_controller),
                      VideoProgressIndicator(_controller, allowScrubbing: true),
                      if (!_controller.value.isPlaying)
                        _PlayPauseOverlay(
                          controller: _controller,
                        ),
                    ],
                  ),
                );
              } else {
                return Center(child: CircularProgressIndicator());
              }
            },
          ),
        ),
      ),
    );
  }
}

class _PlayPauseOverlay extends StatelessWidget {
  const _PlayPauseOverlay({Key key, this.controller}) : super(key: key);

  final VideoPlayerController controller;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        AnimatedSwitcher(
          duration: Duration(milliseconds: 50),
          reverseDuration: Duration(milliseconds: 200),
          child: controller.value.isPlaying
              ? SizedBox.shrink()
              : Container(
                  color: Colors.black26,
                  child: Center(
                    child: Icon(
                      Icons.play_arrow,
                      color: Colors.white,
                      size: 100.0,
                    ),
                  ),
                ),
        ),
        // GestureDetector(
        //   onTap: () {
        //     controller.value.isPlaying ? controller.pause() : controller.play();
        //   },
        // ),
      ],
    );
  }
}
