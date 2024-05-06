import 'dart:async';

import 'package:accordion/accordion.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:learning/Modules/Home/InformationOFCourses/payment.dart';
import 'package:learning/Modules/Home/InformationOFCourses/select_method_of_payment.dart';
import 'package:learning/Modules/Home/InformationOFCourses/video_preview.dart';
import 'package:video_player/video_player.dart';

import '../../../TColors.dart';
import '../../../apis/courseInformation/http_service_courseInformation.dart';
import '../../../apis/upload_course/add_price_compiler_delete_publish.dart';
import '../../../models/module_model.dart';
import '../../../network/local/cache_helper.dart';
import '../../../shared/constant.dart';
import '../../Account/become_an_instructor/Instructor_page/update_course_information.dart';

class CourseInformation extends StatefulWidget {
  const CourseInformation({Key? key, required this.courseId, required this.fromInstructor});
  final String courseId;
  final bool fromInstructor;

  @override
  State<CourseInformation> createState() => _CourseInformationState();
}

class _CourseInformationState extends State<CourseInformation>  {
  HttpServiceCourse httpServiceCourse = HttpServiceCourse();
  HttpServiceCoursePriceAndPublishAndDeleteAndCompiler httpCourse = HttpServiceCoursePriceAndPublishAndDeleteAndCompiler();


  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    if (_isLoading) {
      _getCourse(); // Fetch course data only if _isLoading is true
    }
  }

  Future<void> _getCourse() async {
    try {
      // Fetch course data only if not already loading
      if (_isLoading) {
        String? token = CacheHelper.getData(key: 'token');
        Map<String, dynamic> courseData = await httpServiceCourse.getCourse(widget.courseId, token!);
        setState(() {
          data = courseData['data']['results'];
          _isLoading = false; // Set _isLoading to false after data is fetched
        });
      }
    } catch (e) {
      print('Error fetching course data: $e');
      setState(() {
        _isLoading = false; // Set _isLoading to false in case of error
      });
    }
  }

  late String path;
  Future<void> _getModule(String moduleId) async {
    try {
       // Only fetch data if not already loading
        String? token = CacheHelper.getData(key: 'token');
        String courseData = await httpServiceCourse.getModule(moduleId, token!);
        setState(() {
          path = courseData;
          // _initializeController();
          _isLoading = false;
        });

    } catch (e) {
      print('Error fetching course data: $e');
      setState(() {
        _isLoading = false;
      });
    }
  }

 String errorMessage = '';
  Future<void> _deleteCourse() async {
    try {
      // Fetch course data only if not already loading
        String id = CacheHelper.getData(key: 'courseId');
        if(widget.fromInstructor){
          id = widget.courseId;
        }
         await httpCourse.deleteCourse(CacheHelper.getData(key: 'token'),
             id);
        Navigator.pop(context);
        errorMessage = "";
        Fluttertoast.showToast(
          msg: "Delete Course Success",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 5,
          backgroundColor: Colors.green,
          textColor: Colors.white,
          fontSize: 16.0,
        );

    } catch (e) {
      print('Error while delete course data: $e');
      setState(() {
        errorMessage = 'Error: $e';
        if (errorMessage.contains('422')) {
          errorMessage = "Check your Emails link !";
        } else {
          errorMessage = "Unexpected Error!";
        }
      });
      Fluttertoast.showToast(
        msg: errorMessage,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 5,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0,
      );
    }
  }

  @override
  Widget build(BuildContext context) {

    print("hellllllllllllllllllllllllllllllllo1");
    if (data == null || data!.isEmpty) {
      _getCourse(); // Fetch course data only if data is null or empty
    }print("hellllllllllllllllllllllllllllllllo2");
    print("hellllllllllllllllllllllllllllllllo${data?['videoTrailer']}");

       // Ensure that super.build is called

    if (_isLoading) {
      return Scaffold(
        appBar: AppBar(
          title: const Text("Course Details"),
        ),
        body: const Center(child: CircularProgressIndicator()),
      );
    } else {
      if (data != null && data!.isNotEmpty) {
        String videoURL = 'https://youtube.com/shorts/r9BGpTQzTjI?si=PRUUCiCHLPei7vIU' ;
        if(data?['videoTrailer'] != null){
          videoURL = data?['videoTrailer'];
        }
        int rating =  0 ;
        if(data?['ratingsAverage'] != null){
          rating = (data!['ratingsAverage']).round();
        }
        List<dynamic> listSections = data!['sections'];
        print('[[[[[[[[[[[[[');
        return Scaffold(
          appBar: AppBar(
            title: const Text("Course Details"),
            actions: widget.fromInstructor?[
              CircleAvatar(
                backgroundColor: Colors.grey,
                radius: 15.h,
                child:  IconButton(icon:Icon(Icons.delete), onPressed: () {
                  _deleteCourse();
                },),
              )
            ]:[
              CircleAvatar(
                backgroundColor: Colors.grey,
                radius: 15.h,
                child: const Icon(Icons.share),
              ),
              const SizedBox(width: 4),
              CircleAvatar(
                backgroundColor: Colors.grey,
                radius: 15.h,
                child: const Icon(Icons.shopping_cart),
              ),
            ],
          ),
          body: Padding(
            padding: EdgeInsets.all(8.0.r),
            child: Column(
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        VideoTrailer(videoUrl: videoURL,),
                        SizedBox(height: 20.h),
                        Text('${data!['title']}',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 25.sp,
                          ),
                        ),
                        SizedBox(height: 5.h),
                        Text('${data!['subTitle']}',
                          style: TextStyle(
                            fontSize: 20.sp,
                          ),),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            for (int i = 0; i <rating ; i++)
                              const Icon(Icons.star, color: Colors.yellow),
                            for (int i = rating; i < 5; i++)
                              const Icon(Icons.star_border, color: Colors.yellow),
                            SizedBox(width: 5.w),
                            Text('${data!['ratingsAverage']}'),
                            SizedBox(width: 5.w),
                          ],
                        ),
                        SizedBox(height: 5.h),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            SizedBox(width: 5.w),
                            const Text('39.768 students (248 ratings)'),
                            SizedBox(width: 5.w),
                          ],
                        ),
                        SizedBox(height: 10.h),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            SizedBox(width: 5.w),
                            const Text('Created by'),
                            Text(' ${data!['instructor']['name']}',
                              style: const TextStyle(
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
                            const Text('Language '),
                            SizedBox(width: 5.w),
                            Text('${data!['language']}'),
                            SizedBox(width: 5.w),
                            const Icon(Icons.language),
                            SizedBox(width: 5.w),
                          ],
                        ),
                        SizedBox(height: 20.h),
                        Row(
                          children: [
                            const Spacer(),
                            Container(
                              width: 160,
                              height: 40,
                              decoration: const BoxDecoration(
                                  color: Colors.green
                              ),
                              child: const Center(child: Text('Add to wishlist')),
                            ),
                            SizedBox (width: 2.w,),
                            Container(
                              width: 160,
                              height: 40,
                              decoration: const BoxDecoration(
                                  color: Colors.green
                              ),
                              child: const Center(child: Text('Add to cart')),
                            ),
                            const Spacer(),
                          ],
                        ),
                        SizedBox(height: 20.h),
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
                            Flexible( // Wrap the Text widget with Flexible
                              child: Text('${data!['whatWillBeTaught']}',
                                style: TextStyle(
                                  fontSize: 15.sp,
                                ),
                                maxLines: 5,
                                overflow: TextOverflow.ellipsis,
                              )
                            ),

                            SizedBox(width: 5.w),
                            const Icon(Icons.done),
                            SizedBox(width: 5.w),
                          ],
                        ),
                        SizedBox(height: 10.h),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            SizedBox(width: 5.w),
                            Text('Curriculum',
                              style: TextStyle(
                                  fontSize: 20.sp,
                                  fontWeight: FontWeight.bold
                              ),
                            ),
                            SizedBox(width: 5.w),
                          ],
                        ),
                        SizedBox(height: 10.h),
                        SingleChildScrollView(
                          child: ListView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: listSections.length,
                            itemBuilder: (context, index) {
                              print('from info ${listSections.length}');
                              return Accordion(
                                rightIcon:  Padding(
                                  padding: EdgeInsets.all(8.0),
                                  child: Icon(Icons.keyboard_arrow_down_rounded,),
                                ),
                                headerBackgroundColor: Colors.green,
                                contentBackgroundColor: Colors.teal,
                                paddingListTop: 0,
                                paddingListBottom: 0,
                                children: [
                                  AccordionSection(
                                    header: SizedBox(
                                      height: MediaQuery.of(context).size.height * 0.05,
                                      child: Row(
                                        children: [
                                          Padding(
                                            padding: EdgeInsets.only(left: 10),
                                            child: Text(
                                              '${data!['sections'][index]['title']}',
                                              style: const TextStyle(
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    content:modules( data!['sections'][index]) ,
                                  ),
                                ],
                              );
                            },
                          ),
                        ),
                        SizedBox(height: 10.h),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            SizedBox(width: 5.w),
                            Text('Requirements',
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
                            Flexible( // Wrap the Text widget with Flexible
                                child: Text('${data!['requirements']}',
                                  style: TextStyle(
                                    fontSize: 15.sp,
                                  ),
                                  maxLines: 10,
                                  overflow: TextOverflow.ellipsis,
                                )
                            ),

                          ],
                        ),
                        SizedBox(height: 10.h),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            SizedBox(width: 5.w),
                            Text('Target Audience',
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
                            Flexible( // Wrap the Text widget with Flexible
                                child: Text('${data!['targetAudience']}',
                                  style: TextStyle(
                                    fontSize: 15.sp,
                                  ),
                                  maxLines: 25,
                                  overflow: TextOverflow.ellipsis,
                                )
                            ),

                          ],
                        ),
                        SizedBox(height: 10.h),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            SizedBox(width: 5.w),
                            Text('Description',
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
                            Flexible( // Wrap the Text widget with Flexible
                                child: Text('${data!['courseDescription']}',
                                  style: TextStyle(
                                    fontSize: 15.sp,
                                  ),
                                  maxLines: 25,
                                  overflow: TextOverflow.ellipsis,
                                )
                            ),

                          ],
                        ),
                        // Add other sections/widgets as needed
                      ],
                    ),
                  ),
                ),
               if(widget.fromInstructor)
                 Row(
                  children: [
                    Container(
                      width: 150.w,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20.0.r),
                        color: TColors.secondray,
                      ),
                      child: MaterialButton(
                        child: const Text(
                          'Update',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20.0,
                          ),
                        ),
                        onPressed: () {
                          print('');
                       Navigator.of(context).push(MaterialPageRoute(builder: (context){
                            return UpdateCourse(courseID:data!['_id'] ,);
                          }));
                        },
                      ),
                    ),
                    Spacer(),
                    Container(
                      width: 150.w,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20.0.r),
                        color: TColors.secondray,
                      ),
                      child: MaterialButton(
                        child: const Text(
                          'Publish',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20.0,
                          ),
                        ),
                        onPressed: () {
                             print('from courseInfo ${data}');
                          },
                      ),
                    )
                  ],
                ),
                if(widget.fromInstructor == false)
                  Row(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "${data!['price']['currency']} ${data!['price']['amount']}",
                            style: TextStyle(
                                fontSize: 16.h,
                                fontWeight: FontWeight.bold),
                          ),
                          const Text(
                            "EGP 999",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          )
                        ],
                      ),
                      Spacer(),
                      Container(
                        width: 220.w,
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
                            print('price ${ data!['price']['currency']} ${data!['price']['amount']}');
                            /*  Get.to(SelectPayment(courseID : widget.courseId,
                        /*${data!['price']['currency']}*/
                            coursePrice: '${data!['price']['currency']} ${data!['price']['amount']}',));
                        */ Navigator.of(context).push(MaterialPageRoute(builder: (context){
                              return SelectPayment(courseID : widget.courseId,
                                coursePrice: ' ${data!['price']['amount']}',);
                            }));
                          },
                        ),
                      )
                    ],
                  ),
              ],
            ),
          ),
        );
      } else {
        return Scaffold(
          appBar: AppBar(
            title: const Text("Course Details"),
          ),
          body: const Center(
            child: Text("No data available"),
          ),
        );
      }
    }
  }

  Widget modules(dynamic serverData){
    List<ModuleModel> module = ModuleModel.parseModuleFromServer(serverData!);

    print('modulessss]]]]]]]]]]sssssss = ${module}');
    return ListView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: module.length ,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween, // Aligns children at the start and end of the row
              children: [
                Flexible(
                  child: Text(
                    '${module[index].name}',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                TextButton(onPressed: ()async{
                  //VideoPreview
                  if(module[index].isFree){
                    await _getModule(module[index].id );
                    Navigator.of(context).push(MaterialPageRoute(builder: (context){
                      return VideoPreview(videoUrl:path,) ;
                    }));
                    //Get.to(VideoPreview(videoUrl:path,));
                  }
                }, child: module[index].isFree?Text('Preview',
                 style: TextStyle(
                   color: Colors.white
                 ),
                ):Container()
                )
              ],
            )
            ,
          )
          ;
        }
    );
  }
}

class VideoTrailer extends StatefulWidget {
  const VideoTrailer({Key? key, required this.videoUrl});
  final String videoUrl;

  @override
  State<VideoTrailer> createState() => _VideoTrailerState();
}

class _VideoTrailerState extends State<VideoTrailer> {
  late VideoPlayerController _controller;
  late Timer _timer;
  double _progressValue = 0.0;

  @override
  void initState() {
    super.initState();
    _initializeController();
  }

  void _initializeController() {
    _controller = VideoPlayerController.network(
      widget.videoUrl.isNotEmpty
          ? widget.videoUrl
          : 'https://youtube.com/shorts/4Es8_jiJ9Gc?si=Xomja1pU5IFb7GRb',
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

    _timer = Timer.periodic(const Duration(seconds: 1), (Timer timer) {
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
    print('from videooooooooooooooootrailer');
    return _controller.value.isInitialized
        ? Center(
      child: SizedBox(
        width: double.infinity,
        height: 200,
        child: Stack(
          alignment: Alignment.center,
          children: [
            SizedBox(
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
                valueColor:
                const AlwaysStoppedAnimation<Color>(Colors.blue),
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
    )
        : Container();
  }
}
