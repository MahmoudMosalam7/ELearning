import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'CourseInformation.dart';

class VideoPreview extends StatelessWidget {
  const VideoPreview({super.key, required this.videoUrl});
  final String videoUrl;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: VideoTrailer(videoUrl:  videoUrl,),
      ),
    );
  }
}
