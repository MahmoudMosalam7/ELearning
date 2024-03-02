import 'package:flutter/material.dart';
import 'package:learning/TColors.dart';

class VideoPlay extends StatefulWidget{
  @override
  State<VideoPlay> createState() => _VideoPlayState();
}

class _VideoPlayState extends State<VideoPlay> {
  bool s=true;
  bool d=true;

  @override
  Widget build(BuildContext context) {
    return(Scaffold(
      appBar: AppBar(
        title: Text("Video playback option"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(30.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text("Play audio in background",
                  style: TextStyle(
                      fontSize: 20.0
                  ),),
                Spacer(flex: 1,),
                Switch(value: s, onChanged: (value){
                  setState(() {
                    s=value;
                  });

                },
                  activeColor: TColors.Ternary,
                )
              ],
            ),
            SizedBox(height: 50.0,),
            Row(
              children: [
                Text("Auto-play next lecture",
                  style: TextStyle(
                      fontSize: 20.0
                  ),),
                Spacer(flex: 1,),
                Switch(value: d, onChanged: (value){
                  setState(() {
                    d=value;
                  });
                },
                  activeColor: TColors.Ternary,)
              ],
            ),
          ],


        ),
      ),
    )
    );
  }
}