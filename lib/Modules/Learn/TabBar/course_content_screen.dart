import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'dart:isolate';
import 'dart:ui';

import 'package:accordion/accordion.dart';
import 'package:flip_card/flip_card.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../../apis/courseInformation/http_service_courseInformation.dart';
import '../../../apis/reviews/reviews.dart';
import '../../../apis/upload_course/add_price_compiler_delete_publish.dart';
import '../../../chat/home/chat_home_screen.dart';
import '../../../models/module_model.dart';
import '../../../models/test_model.dart';
import '../../../network/local/cache_helper.dart';
import '../../../shared/constant.dart';
import '../../Home/InformationOFCourses/CourseInformation.dart';
import 'compiler_webview.dart';


class CourseContentScreen extends StatefulWidget {
  const CourseContentScreen({super.key, required this.courseId});
  final String courseId;

  @override
  State<CourseContentScreen> createState() => _CourseContentScreenState();
}
/*
*
  @override
  void initState() {
    super.initState();
    if (_isLoading) {
      _getCourse(); // Fetch course data only if _isLoading is true
    } // Fetch course data only if _isLoading is true

    _checkPermissions();
    IsolateNameServer.registerPortWithName(
      _port.sendPort,
      'downloader_send_port',
    );
    _port.listen((dynamic data) {
      String id = data[0];
      int status = data[1];
      int progress = data[2];

      final DownloadTaskStatus taskStatus = DownloadTaskStatus.values[status];

      if (taskStatus == DownloadTaskStatus.complete) {
        print('Download complete!');
      } else if (taskStatus == DownloadTaskStatus.failed) {
        print('Download failed!');
      }
    });
    FlutterDownloader.registerCallback(downloadCallback);
  }
*/
class _CourseContentScreenState extends State<CourseContentScreen> {
  HttpServiceCourse httpServiceCourse = HttpServiceCourse();
  bool _isLoading = true;
  late Map<String,dynamic> serverData ;
  String errorMessage = '';
    HttpServiceCoursePriceAndPublishAndDeleteAndCompiler httpCourse = HttpServiceCoursePriceAndPublishAndDeleteAndCompiler();

  HttpServiceReviews httpServiceReviews = HttpServiceReviews();



  final ReceivePort _port = ReceivePort();

  @override
  void initState() {
    super.initState();
    _checkPermissions();
    IsolateNameServer.registerPortWithName(
      _port.sendPort,
      'downloader_send_port',
    );
    _port.listen((dynamic data) {
      String id = data[0];
      int status = data[1];
      int progress = data[2];

      final DownloadTaskStatus taskStatus = DownloadTaskStatus.values[status];

      if (taskStatus == DownloadTaskStatus.complete) {
        print('Download complete!');
      } else if (taskStatus == DownloadTaskStatus.failed) {
        print('Download failed!');
      }
    });
    FlutterDownloader.registerCallback(downloadCallback as DownloadCallback);
    if (_isLoading) {
      _getCourse(); // Fetch course data only if _isLoading is true
    } // Fetch course data only if _isLoading is true

  }

  @override
  void dispose() {
    IsolateNameServer.removePortNameMapping('downloader_send_port');
    super.dispose();
  }
// Change the signature of downloadCallback to match the expected signature
  void downloadCallback(String id, int status, int progress) {
    final SendPort? send = IsolateNameServer.lookupPortByName('downloader_send_port');
    send?.send([id, status, progress]);
  }


  Future<void> _checkPermissions() async {
    var status = await Permission.storage.status;
    if (!status.isGranted) {
      await Permission.storage.request();
    }
  }

  void _downloadVideo(String link) async {
    final url = ' https://res.cloudinary.com/dcjrolufm/video/upload/v1711559499/modules/module-d1b87675-e9b3-441e-9c4b-1347860b7651-1711559457652.mp4';
    if (url.isNotEmpty) {
      print('lllllllllinkkkkkkk = $url');
      final externalDir = await getExternalStorageDirectory();
      final savedDir = externalDir!.path;

      final taskId = await FlutterDownloader.enqueue(
        url: url,
        savedDir: savedDir,
        showNotification: true, // show download progress in status bar (for Android)
        openFileFromNotification: true, // click on notification to open downloaded file (for Android)
        saveInPublicStorage: true, // set to true to save file in public storage
      );
      print('Download task ID: $taskId');

      // Add a delay to prevent frequent updates
      await Future.delayed(Duration(seconds: 1));
    }
  }


  Future<void> _getCourse() async {
    try {
      // Set _isLoading to true before fetching data
      setState(() {
        _isLoading = true;
      });

      String? token = CacheHelper.getData(key: 'token');
      Map<String, dynamic> courseData = await httpServiceCourse.getCourse(widget.courseId, token!);
      setState(() {
        data = courseData['data']['results'];
        listSections = data!['sections'];
        _isLoading = false; // Set _isLoading to false after data is fetched
      });
    } catch (e) {
      print('Error fetching course data: $e');
      setState(() {
        _isLoading = false; // Set _isLoading to false in case of error
      });
    }
  }
  late List<dynamic> listSections ;
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
  Widget build(BuildContext context) {
    if (_isLoading) {
      return Center(child: CircularProgressIndicator());
    }else{
    return curriculum(listSections);}
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
                        IconButton(onPressed: (){
                          String  email =  data!['instructor']['email'] ;
                          print('email = $email');
                          if(email.isNotEmpty){

                            print('email =$email');
                            Get.to(ChatHomeScreen(email:email ,));
                          }

                        },
                            icon: Icon(Icons.chat)),
                        Spacer(),
                        TextButton(onPressed: (){
                          // Get.to(CompilerWebView(compilerURL: data!['compiler'],));
                          _showRatingDialog(context);
                        }, child: Text('Rating',
                          style: TextStyle(
                              fontSize: 18.sp,
                              fontWeight: FontWeight.bold
                          ) ,)),
                        if(data!['compiler'] != null)
                          Spacer(),
                        if(data!['compiler'] != null)
                          TextButton(onPressed: (){
                            Get.to(CompilerWebView(compilerURL: data!['compiler'],));
                          }, child: Text('Compiler',
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
                      return VideoPlayerScreen(videoUrl:path,) ;
                    }));
                    // VideoTrailer(videoUrl:path,) ;
                    //Get.to(VideoPreview(videoUrl:path,));
                  }
                }, child: module[index].isFree?Text('Watch',
                  style: TextStyle(
                      color: Colors.white
                  ),
                ):Container()
                ),

                IconButton(onPressed: ()async{
                  if(module[index].isFree){
                    await _getModule(module[index].id );

                    print('course contente path = $path');
                    _downloadVideo(path);
                    // VideoTrailer(videoUrl:path,) ;
                    //Get.to(VideoPreview(videoUrl:path,));
                  }
                },
                    icon: Icon(Icons.download,color:
                  Colors.white
                  ,))
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
          title: Text('Rate Us'),
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
                  hintText: 'Write your review...',
                  border: OutlineInputBorder(),
                ),
                maxLines: 3,
              ),
            ],
          ),
          actions: <Widget>[
            GestureDetector(
              child: Text('Cancel'),
              onTap: () {
                setState(() {
                  _rating = 0;
                });

                Navigator.of(context).pop();
              },
            ),
            GestureDetector(
              child: Text('Submit'),
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
