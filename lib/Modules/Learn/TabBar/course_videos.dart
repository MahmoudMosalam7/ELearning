import 'dart:async';
import 'package:easy_localization/easy_localization.dart';
import 'package:accordion/accordion.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:learning/Modules/Learn/TabBar/testScreen.dart';
import 'package:shimmer/shimmer.dart';
import 'package:video_player/video_player.dart';
import '../../../apis/courseInformation/http_service_courseInformation.dart';
import '../../../apis/reviews/reviews.dart';
import '../../../apis/upload_course/add_price_compiler_delete_publish.dart';
import '../../../chat/home/chat_home_screen.dart';
import '../../../models/module_model.dart';
import '../../../network/local/cache_helper.dart';
import '../../../shared/constant.dart';
import '../../../translations/locale_keys.g.dart';
import 'compiler_webview.dart';
import 'course_content_screen.dart';


class CourseContent extends StatefulWidget {
  const CourseContent({Key? key, required this.courseId});
  final String courseId;


  @override
  State<CourseContent> createState() => _CourseContentState();
}

class _CourseContentState extends State<CourseContent> with SingleTickerProviderStateMixin   {
  late TabController _tabController;
  HttpServiceCourse httpServiceCourse = HttpServiceCourse();
  HttpServiceReviews httpServiceReviews = HttpServiceReviews();
  HttpServiceCoursePriceAndPublishAndDeleteAndCompiler httpCourse = HttpServiceCoursePriceAndPublishAndDeleteAndCompiler();


  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);

      _getCourse(); // Fetch course data only if _isLoading is true

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

  Future<void> _createReview(double rating ,String comment) async {
    try {
      // Fetch course data only if not already loading

        String? token = CacheHelper.getData(key: 'token');
         await httpServiceReviews.createReview(
             data!['_id'], rating,comment,token!);
        setState(() {

         print('alll is dooooooooooone'); // Set _isLoading to false after data is fetched
        });

    } catch (e) {
      print('Error create reviews data: $e');
      setState(() {
        _isLoading = false; // Set _isLoading to false in case of error
      });
    }
  }
  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
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
          title:  Text(LocaleKeys.LearnCourseContentTitle.tr()),
        ),
        body: buildShimmerEffect(),
      );
    } else {
      if (data != null && data!.isNotEmpty) {
        String videoURL = 'https://youtube.com/shorts/r9BGpTQzTjI?si=PRUUCiCHLPei7vIU' ;
        if(data?['videoTrailer'] != null){
          videoURL = data?['videoTrailer'];
        }

        List<dynamic> listSections = data!['sections'];
        print('[[[[[[[[[[[[[');
        return Scaffold(
          appBar: AppBar(
            title:  Text(LocaleKeys.LearnCourseContentTitle.tr()),
              bottom: TabBar(
                controller: _tabController,
                indicatorColor: Colors.green,
                labelColor: Colors.green,
                // Set the color of the selected tab's text to black
                unselectedLabelColor: Colors.grey, // Set the color of unselected tabs' text to gray
                tabs: [
                  Tab(
                    text: '${LocaleKeys.LearnCourseContentCurriculum.tr()}',
                  ),
                  Tab(
                    text: '${LocaleKeys.LearnCourseContentTest.tr()}',
                  ),
                ],
              )

          ),
          body:  TabBarView(
            controller: _tabController,
            children: [
              CourseContentScreen(courseId: widget.courseId,), // Assuming All widget is for the "All" tab
              TestScreen(courseId: widget.courseId,),

            ],
          ),
        );
      } else {
        return Scaffold(
          appBar: AppBar(
            title:  Text(LocaleKeys.LearnCourseContentTitle.tr()),
          ),
          body:  Center(
            child: Text(LocaleKeys.LearnCourseContentNodataavailable.tr()),
          ),
        );
      }
    }
  }
  Widget buildShimmerEffect() {
    return Padding(
      padding: EdgeInsets.all(8.0),
      child: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 20.0),
                  Row(
                    children: [
                      Container(
                        width: 150.0,
                        height: 20.0,
                        color: Colors.white,
                      ),
                      SizedBox(width: 5.0),
                      Container(
                        width: 20.0,
                        height: 20.0,
                        color: Colors.white,
                      ),
                      SizedBox(width: 5.0),
                      Container(
                        width: 100.0,
                        height: 20.0,
                        color: Colors.white,
                      ),
                      if (true) // Placeholder for optional compiler button
                        SizedBox(width: 5.0),
                      if (true)
                        Expanded(
                          child: Container(
                            width: 100.0,
                            height: 20.0,
                            color: Colors.white,
                          ),
                        ),
                      SizedBox(width: 5.0),
                    ],
                  ),
                  SizedBox(height: 10.0),
                  ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: 10, // Placeholder for the number of sections
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 8.0),
                        child: Shimmer.fromColors(
                          baseColor: Color(0xFFE0E0E0),
                          highlightColor: Color(0xFFF5F5F5),
                          child: Column(
                            children: [
                              Container(
                                height: MediaQuery.of(context).size.height * 0.05,
                                color: Colors.white,
                                margin: EdgeInsets.only(bottom: 8.0),
                              ),
                              Container(
                                height: 50.0, // Placeholder for module content
                                color: Colors.white,
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                  SizedBox(height: 10.0),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget curriculum (List<dynamic> listSections){
    if (_isLoading) {
      return buildShimmerEffect();
    } else {
    return Padding(
      padding: EdgeInsets.all(8.0.r),
      child: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 20.h),
                  Row(
                    children: [
                      SizedBox(width: 5.w),
                      Text(LocaleKeys.LearnCourseContentSections.tr(),
                        style: TextStyle(
                            fontSize: 18.sp,
                            fontWeight: FontWeight.bold
                        ),
                      ),
                      SizedBox(width: 5.w),
                      IconButton(onPressed: (){
                        String  email =  data!['instructor']['email'] ;
                        print('email = $email');
                        if(email.isNotEmpty){

                         print('email =$email');
                          Navigator.push(context, MaterialPageRoute(builder: (context){
                            return ChatHomeScreen(email:email ,);
                          }));
                        }

                      },
                          icon: Icon(Icons.chat)),
                      Spacer(),
                      TextButton(onPressed: (){
                       // Get.to(CompilerWebView(compilerURL: data!['compiler'],));
                        _showRatingDialog(context);
                      }, child: Text(LocaleKeys.LearnCourseContentRating.tr(),
                        style: TextStyle(
                            fontSize: 18.sp,
                            fontWeight: FontWeight.bold
                        ) ,)),
                      if(data!['compiler'] != null)
                      Spacer(),
                      if(data!['compiler'] != null)
                        TextButton(onPressed: (){
                          Navigator.push(context, MaterialPageRoute(builder: (context){
                            return CompilerWebView(compilerURL: data!['compiler'],);
                          }));

                        }, child: Text(LocaleKeys.LearnCourseContentCompiler.tr(),
                        style: TextStyle(
                            fontSize: 18.sp,
                            fontWeight: FontWeight.bold
                        ) ,)),

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

                  // Add other sections/widgets as needed
                ],
              ),
            ),
          ),

        ],
      ),
    );}
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
                      return VideoTrailer(videoUrl:path,) ;
                    }));
                   // VideoTrailer(videoUrl:path,) ;
                    //Get.to(VideoPreview(videoUrl:path,));
                  }
                }, child: module[index].isFree?Text(LocaleKeys.LearnCourseContentScreenWatch.tr(),
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

  double _rating = 0;
  String _review = '';

  void _showRatingDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(LocaleKeys.LearnCourseContentScreenRateUs.tr()),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              RatingBar.builder(
                initialRating: _rating,
                minRating: 1,
                direction: Axis.horizontal,
                allowHalfRating: false,
                itemCount: 5,
                itemSize: 40,
                itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
                itemBuilder: (context, _) => Icon(
                  Icons.star,
                  color: Colors.amber,
                ),
                onRatingUpdate: (rating) {
                  setState(() {
                    _rating = rating;
                  });
                },
              ),
              SizedBox(height: 20),
              TextField(
                onChanged: (value) {
                  setState(() {
                    _review = value;
                  });
                },
                decoration: InputDecoration(
                  hintText: '${LocaleKeys.LearnCourseContentWriteyourreview.tr()}',
                  border: OutlineInputBorder(),
                ),
                maxLines: 3,
              ),
            ],
          ),
          actions: <Widget>[
            GestureDetector(
              child: Text(LocaleKeys.LearnCourseContentScreenCancel.tr()),
              onTap: () {
                setState(() {
                  _rating = 0;
                });

                Navigator.of(context).pop();
              },
            ),
            GestureDetector(
              child: Text(LocaleKeys.LearnCourseContentScreenSubmit.tr()),
              onTap: () {

                _createReview(_rating,_review);
                setState(() {
                  _rating = 0;
                });
                // Here you can handle the submission of rating and review
                Navigator.of(context).pop();
              },
            ),

          ],
        );
      },
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
