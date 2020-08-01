import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'package:flutter/services.dart';

class FullVideo extends StatefulWidget {
  final String link;
  final String timeStamp;
  FullVideo(this.link, this.timeStamp);

  @override
  _FullVideoState createState() => _FullVideoState();
}

class _FullVideoState extends State<FullVideo> {
  VideoPlayerController _controller;
  Future<void> _initializeVideoPlayerFuture;
  @override
  void initState() {
    _controller = VideoPlayerController.network(
      widget.link,
      useCache: true
    );

    _initializeVideoPlayerFuture = _controller.initialize();

    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeRight,
      DeviceOrientation.landscapeLeft,
  ]);
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
  ]);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
          body: Center(
            child: GestureDetector(
              onDoubleTap: (){
                Navigator.of(context).pop();
                SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
  ]);
              },
          onTap: () {
            print(_controller.value.initialized.toString());
            setState(() {
              // If the video is playing, pause it.
              if (_controller.value.isPlaying) {
                _controller.pause();
              } else if (_controller.value.position == _controller.value.duration) {
                
                // If the video is paused, play it.
                _controller.seekTo(Duration(microseconds: 1));
                _controller.play();
              }
              else{
                _controller.play();
              }
            });
          },
          child: Container(
            child: // Use a FutureBuilder to display a loading spinner while waiting for the
// VideoPlayerController to finish initializing.
                FutureBuilder(
              future: _initializeVideoPlayerFuture,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  // If the VideoPlayerController has finished initialization, use
                  // the data it provides to limit the aspect ratio of the VideoPlayer.
                  return AspectRatio(
                    aspectRatio: _controller.value.aspectRatio,
                    // Use the VideoPlayer widget to display the video.
                    child: Stack(
                      alignment: Alignment.bottomCenter,
                      children: [VideoPlayer(_controller),
                      VideoProgressIndicator(_controller, allowScrubbing: true),
                      
                      
                      ],
                      ),
                  );
                } else {
                  // If the VideoPlayerController is still initializing, show a
                  // loading spinner.
                  return Center(child: CircularProgressIndicator());
                }
              },
            ),
          ),
        ),
      ),
    );
  }
}