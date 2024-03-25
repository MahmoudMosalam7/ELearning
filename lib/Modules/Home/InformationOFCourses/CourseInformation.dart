import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:learning/Modules/Home/InformationOFCourses/payment.dart';
import 'package:video_player/video_player.dart';

import '../../../TColors.dart';
import '../../../apis/courseInformation/courseInformation.dart';
import '../../../network/local/cache_helper.dart';

class CourseInformation extends StatefulWidget {
  CourseInformation({Key? key, required this.courseId}) : super(key: key);
  final String courseId;

  @override
  State<CourseInformation> createState() => _CourseInformationState();
}

class _CourseInformationState extends State<CourseInformation> {
  HttpServiceCourse httpServiceCourse = HttpServiceCourse();
  late Map<String, dynamic> data;

  late VideoPlayerController _controller;
  late Timer _timer;
  double _progressValue = 0.0;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _getCourse();
  }

  Future<void> _getCourse() async {
    try {
      String? token = CacheHelper.getData(key: 'token');
      data = await httpServiceCourse.getCourse(widget.courseId, token!);
      _initializeController();
      print('Fetched course Data: $data');
      setState(() {
        _isLoading = false;
      });
    } catch (e) {
      print('Error fetching course data: $e');
      setState(() {
        _isLoading = false;
      });
    }
  }

  void _initializeController() {
    _controller = VideoPlayerController.network(
      data['data']['results']['videoTrailer'],
    )..initialize().then((_) {
      setState(() {});
    });

    _controller.addListener(() {
      if (!_controller.value.isPlaying &&
          _controller.value.isInitialized &&
          (_controller.value.position == _controller.value.duration)) {
        _controller.pause();
        _controller.seekTo(Duration.zero);
      }
      setState(() {
        _progressValue = _controller.value.isInitialized
            ? _controller.value.position.inMilliseconds /
            _controller.value.duration.inMilliseconds
            : 0.0;
      });
    });

    _timer = Timer.periodic(Duration(seconds: 1), (Timer timer) {
      setState(() {
        _progressValue = _controller.value.isInitialized
            ? _controller.value.position.inMilliseconds /
            _controller.value.duration.inMilliseconds
            : 0.0;
      });
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text(
            "Course Details",
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        actions: [
          CircleAvatar(
            backgroundColor: Colors.grey,
            radius: 15.h,
            child: Icon(Icons.share),
          ),
          SizedBox(width: 4),
          CircleAvatar(
            backgroundColor: Colors.grey,
            radius: 15.h,
            child: Icon(Icons.shopping_cart),
          ),
        ],
      ),
      body: _isLoading
          ? Center(child: CircularProgressIndicator())
          : Padding(
        padding: EdgeInsets.all(8.0.r),
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Container(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _controller != null && _controller.value.isInitialized
                          ? Center(
                        child: Container(
                          width: double.infinity,
                          height: 200,
                          child: Stack(
                            alignment: Alignment.center,
                            children: [
                              Container(
                                width: double.infinity,
                                child: AspectRatio(
                                  aspectRatio: 16 / 9,
                                  child: VideoPlayer(_controller),
                                ),
                              ),
                              Positioned(
                                bottom: 10,
                                left: 0,
                                right: 0,
                                child: LinearProgressIndicator(
                                  value: _progressValue,
                                  valueColor: AlwaysStoppedAnimation<Color>(
                                      Colors.blue),
                                  backgroundColor: Colors.grey,
                                ),
                              ),
                              Positioned.fill(
                                child: Center(
                                  child: IconButton(
                                    icon: Icon(
                                      _controller.value.isPlaying
                                          ? Icons.pause
                                          : Icons.play_arrow,
                                      color: Colors.white,
                                    ),
                                    iconSize: 50,
                                    onPressed: () {
                                      setState(() {
                                        _controller.value.isPlaying
                                            ? _controller.pause()
                                            : _controller.play();
                                      });
                                    },
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ) : Container(),
                      // Add other course information widgets here
                      SizedBox(height: 20.h),
                      Text('${ data['data']['results']['title']}'
                       ,style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 25.sp,
                        ),
                      ),

                      SizedBox(height: 5.h),
                      Text('${ data['data']['results']['subTitle']}'
                        ,style: TextStyle(
                          fontSize: 20.sp,
                        ),),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          for (int i = 0; i <data['data']['results']['ratingsAverage']; i++)
                          Icon(Icons.star, color: Colors.yellow),
                          for (int i =data['data']['results']['ratingsAverage']; i < 5; i++)
                            Icon(Icons.star_border, color: Colors.yellow),
                          SizedBox(width: 5.w),
                          Text('${ data['data']['results']['ratingsAverage']}'),
                          SizedBox(width: 5.w),


                        ],
                      ),
                      SizedBox(height: 5.h),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          SizedBox(width: 5.w),
                          Text('39.768 students (248 ratings)'),
                          SizedBox(width: 5.w),


                        ],
                      ),
                      SizedBox(height: 10.h),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          SizedBox(width: 5.w),
                          Text('Created by'),
                          Text(' ${ data['data']['results']['instructor']['name']}',
                          style: TextStyle(
                            color: Colors.blue
                          ),
                          ),
                          SizedBox(width: 5.w),


                        ],
                      ),
                      SizedBox(height: 5.h),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text('Language '),
                          SizedBox(width: 5.w),
                          Text('${ data['data']['results']['language']}'),
                          SizedBox(width: 5.w),
                          Icon(Icons.language),
                          SizedBox(width: 5.w),

                        ],
                      ),

                      SizedBox(height: 20.h),
                      Row(
                        children: [
                          Spacer(),
                          Container(
                            width: 160,
                            height: 40,
                            decoration:  BoxDecoration(

                                color: Colors.green
                            ),
                            child: Center(child: Text('Add to wishlist')),
                          ),
                          SizedBox(width: 2.w,),
                          Container(
                            width: 160,
                            height: 40,
                            decoration:  BoxDecoration(

                              color: Colors.green
                            ),
                            child: Center(child: Text('Add to cart')),
                          ),
                          Spacer(),
                        ],
                      ),
                      SizedBox(height: 20.h),
                      //whatWillBeTaught
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          SizedBox(width: 5.w),
                          Text('What you\'ll learn',
                          style: TextStyle(
                            fontSize: 20.sp,
                            fontWeight: FontWeight.bold
                          ),
                          ),
                          SizedBox(width: 5.w),


                        ],
                      ),
                      SizedBox(height: 10.h),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          SizedBox(width: 5.w),
                          Text('${ data['data']['results']['whatWillBeTaught']}',
                            style: TextStyle(
                                fontSize: 20.sp,
                            ),
                          ),
                          SizedBox(width: 5.w),
                          Icon(Icons.done),
                          SizedBox(width: 5.w),


                        ],
                      ),
                      Text('mmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmm'),

                      SizedBox(height: 20),
                      Text('mmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmm'),

                      SizedBox(height: 20),
                      Text('mmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmm'),

                      SizedBox(height: 20),
                      Text('mmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmm'),
                      SizedBox(height: 20),

                      SizedBox(height: 20),

                    ],
                  ),
                ),
              ),
            ),
            Row(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "EGP 199",
                      style: TextStyle(
                          fontSize: 20.h,
                          fontWeight: FontWeight.bold),
                    ),
                    Text(
                      "EGP 999",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    )
                  ],
                ),
                SizedBox(width: 15.w),
                Container(
                  width: 230.w,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20.0.r),
                    color: TColors.secondray,
                  ),
                  child: MaterialButton(
                    child: const Text(
                      'Enroll Now',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20.0,
                      ),
                    ),
                    onPressed: () {
                      Get.to(Payment());
                    },
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
