import 'dart:async';

import 'package:accordion/accordion.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:video_player/video_player.dart';

import '../../../apis/courseInformation/http_service_courseInformation.dart';
import '../../../apis/upload_course/add_price_compiler_delete_publish.dart';
import '../../../models/module_model.dart';
import '../../../network/local/cache_helper.dart';
import '../../../shared/constant.dart';
import 'compiler_webview.dart';

class CourseContent extends StatefulWidget {
  const CourseContent({Key? key, required this.courseId});
  final String courseId;


  @override
  State<CourseContent> createState() => _CourseContentState();
}

class _CourseContentState extends State<CourseContent> with SingleTickerProviderStateMixin   {
  late TabController _tabController;
  HttpServiceCourse httpServiceCourse = HttpServiceCourse();
  HttpServiceCoursePriceAndPublishAndDeleteAndCompiler httpCourse = HttpServiceCoursePriceAndPublishAndDeleteAndCompiler();


  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
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
          title: const Text("Course Content"),
        ),
        body: const Center(child: CircularProgressIndicator()),
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
            title: const Text("Course Content"),
              bottom: TabBar(
                controller: _tabController,
                indicatorColor: Colors.green,
                labelColor: Colors.green,
                // Set the color of the selected tab's text to black
                unselectedLabelColor: Colors.grey, // Set the color of unselected tabs' text to gray
                tabs: [
                  Tab(
                    text: 'Curriculum',
                  ),
                  Tab(
                    text: 'Test',
                  ),
                ],
              )

          ),
          body:  TabBarView(
            controller: _tabController,
            children: [
              curriculum(listSections), // Assuming All widget is for the "All" tab
              Container(
                color: Colors.redAccent,
                child: const Icon(Icons.settings),
              ),

            ],
          ),
        );
      } else {
        return Scaffold(
          appBar: AppBar(
            title: const Text("Course Content"),
          ),
          body: const Center(
            child: Text("No data available"),
          ),
        );
      }
    }
  }
  Widget curriculum (List<dynamic> listSections){
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
                      Text('Sections',
                        style: TextStyle(
                            fontSize: 18.sp,
                            fontWeight: FontWeight.bold
                        ),
                      ),
                      SizedBox(width: 5.w),
                      IconButton(onPressed: (){},
                          icon: Icon(Icons.chat)),
                      Spacer(),
                      if(data!['compiler'] != null)
                        TextButton(onPressed: (){
                          Get.to(CompilerWebView(compilerURL: data!['compiler'],));
                        }, child: Text('Compiler',
                        style: TextStyle(
                            fontSize: 18.sp,
                            fontWeight: FontWeight.bold
                        ) ,))
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
    );
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
                }, child: module[index].isFree?Text('Watch',
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