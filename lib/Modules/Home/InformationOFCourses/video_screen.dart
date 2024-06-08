import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class VideoPlayFullScreenRotated extends StatefulWidget {
  final String videoUrl;

  const VideoPlayFullScreenRotated({required this.videoUrl});

  @override
  _VideoPlayFullScreenRotatedState createState() => _VideoPlayFullScreenRotatedState();
}

class _VideoPlayFullScreenRotatedState extends State<VideoPlayFullScreenRotated> {
  late VideoPlayerController _controller;
  bool _isPlaying = false;
  bool _isVertical = false;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.network(widget.videoUrl)
      ..initialize().then((_) {
        setState(() {});
      });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;

    return Scaffold(
      body: _controller.value.isInitialized
          ? GestureDetector(
        onTap: () {
          setState(() {
            _isPlaying ? _controller.pause() : _controller.play();
            _isPlaying = !_isPlaying;
          });
        },
        child: Container(
          width: screenSize.width,
          height: screenSize.height,
          child: Transform.rotate(
            angle: 90 * 3.1415926535 / 180, // 90 degrees in radians
            child: Center(
              child: AspectRatio(
                aspectRatio: _controller.value.aspectRatio,
                child: Stack(
                  alignment: Alignment.bottomCenter,
                  children: [

                    VideoPlayer(_controller),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        IconButton(
                          icon: Icon(_isPlaying ? Icons.pause : Icons.play_arrow),
                          onPressed: () {
                            setState(() {
                              _isPlaying ? _controller.pause() : _controller.play();
                              _isPlaying = !_isPlaying;
                            });
                          },
                        ),
                        IconButton(
                          icon: Icon(Icons.fast_rewind),
                          onPressed: () {
                            _controller.seekTo(_controller.value.position - Duration(seconds: 10));
                          },
                        ),
                        IconButton(
                          icon: Icon(Icons.fast_forward),
                          onPressed: () {
                            _controller.seekTo(_controller.value.position + Duration(seconds: 10));
                          },
                        ),
                        IconButton(
                          icon: Icon(_isVertical ? Icons.rotate_90_degrees_ccw : Icons.rotate_90_degrees_cw),
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => VideoPlayFullScreenRotated(videoUrl: widget.videoUrl),
                              ),
                            );
                          },
                        ),
                      ],
                    ),

                  ],
                ),
              ),
            ),
          ),
        ),
      )
          : Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
