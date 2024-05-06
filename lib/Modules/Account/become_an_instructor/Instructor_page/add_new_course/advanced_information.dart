import 'dart:async';
import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:learning/shared/constant.dart';
import 'package:video_player/video_player.dart';

import '../../../../../apis/upload_course/http_service_advanced_information.dart';
import '../../../../../network/local/cache_helper.dart';
import 'course_curriculum/course_curriculum.dart';

class AdvancedInformationScreen extends StatefulWidget {
  final bool fromUpdateCourse;
  final String courseId;

  const AdvancedInformationScreen({super.key, required this.fromUpdateCourse, required this.courseId});
  @override
  _AdvancedInformationScreenState createState() =>
      _AdvancedInformationScreenState();
}

class _AdvancedInformationScreenState extends State<AdvancedInformationScreen> {
  late VideoPlayerController _controller;
  FilePickerResult? _videoFile;
  FilePickerResult? _selectedImage;
  late Timer _timer;
  double _progressValue = 0.0;
  TextEditingController _courseDescriptionController = TextEditingController();
  TextEditingController _courseTeachController = TextEditingController();
  TextEditingController _targetAudienceController = TextEditingController();
  TextEditingController _courseRequrirementsController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  HttpServiceAdvancedInformation httpAdvancedInformation =
  HttpServiceAdvancedInformation();
  bool isLoading = false;
  String errorMessage = '';
  void _advancedInformation() async {
    // Reset error message and loading state
    setState(() {
      errorMessage = '';
      isLoading = true;
    });

    try {



      // Check if _profileImage is not null before calling updateMe
 /* imageFilePath,videoFilePath,String courseDescription
      ,String whatWillBeTaught,String targetAudience,
      String requirements
      ,context ,String token
      */
      print(']]]]]]]]]]]]]]]]]]]]]from edit');
      await httpAdvancedInformation.advancedInformation(
          _selectedImage!.files.single.path,
        _videoFile!.files.single.path,
        _courseDescriptionController.text,
        _courseTeachController.text,
        _targetAudienceController.text,
          _courseRequrirementsController.text,
       context,
       // Use _profileImage directly
        CacheHelper.getData(key: 'token')
      );


      errorMessage = "";
      Fluttertoast.showToast(
        msg: "Update Instructor  Success",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 5,
        backgroundColor: Colors.green,
        textColor: Colors.white,
        fontSize: 16.0,
      );

      print(' successful!');
      sections = [];
      Get.to(CourseCurriculum(courseId:'null' ,fromUpdateCourse:false ,));
    } catch (e) {
      // Handle validation errors or network errors
      setState(() {
        errorMessage = 'Error: $e';
        if (errorMessage.contains('422')) {
          errorMessage = "Check your Emails link !";
        } else {
          errorMessage = "Unexpected Error!";
        }

        Fluttertoast.showToast(
          msg: errorMessage,
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 5,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0,
        );
      });
    } finally {
      // Update loading state
      setState(() {
        isLoading = false;
      });
    }
  }
  void _updateAdvancedInformation() async {
    // Reset error message and loading state
    setState(() {
      errorMessage = '';
      isLoading = true;
    });

    try {



      // Check if _profileImage is not null before calling updateMe
      /* imageFilePath,videoFilePath,String courseDescription
      ,String whatWillBeTaught,String targetAudience,
      String requirements
      ,context ,String token
      */
      print(']]]]]]]]]]]]]]]]]]]]]from edit');
      await httpAdvancedInformation.updateAdvancedInformation(
          _selectedImage!.files.single.path,
          _videoFile!.files.single.path,
          _courseDescriptionController.text,
          _courseTeachController.text,
          _targetAudienceController.text,
          _courseRequrirementsController.text,
          context,
          // Use _profileImage directly
          CacheHelper.getData(key: 'token'),
        widget.courseId
      );


      errorMessage = "";
      Fluttertoast.showToast(
        msg: "Update Instructor  Success",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 5,
        backgroundColor: Colors.green,
        textColor: Colors.white,
        fontSize: 16.0,
      );

      print(' successful!');
      Navigator.pop(context);
    } catch (e) {
      // Handle validation errors or network errors
      setState(() {
        errorMessage = 'Error: $e';
        if (errorMessage.contains('422')) {
          errorMessage = "Check your Emails link !";
        } else {
          errorMessage = "Unexpected Error!";
        }

        Fluttertoast.showToast(
          msg: errorMessage,
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 5,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0,
        );
      });
    } finally {
      // Update loading state
      setState(() {
        isLoading = false;
      });
    }
  }
  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.asset('assets/placeholder_video.mp4');
    _controller.addListener(() {
      if (!_controller.value.isPlaying &&
          _controller.value.isInitialized &&
          (_controller.value.position == _controller.value.duration)) {
        // Video has reached the end, pause and seek to the beginning
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

    // Update the progress every second
    _timer = Timer.periodic(Duration(seconds: 1), (Timer timer) {
      setState(() {
        _progressValue = _controller.value.isInitialized
            ? _controller.value.position.inMilliseconds /
            _controller.value.duration.inMilliseconds
            : 0.0;
      });
    });
  }
  Future<void> _pickVideo() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles();

    if (result != null && result.files.isNotEmpty) {

      setState(() {
        _videoFile = result;
        _controller = VideoPlayerController.file(File(result.files.first.path!));
        _controller.initialize().then((_) {
          _controller.pause();
        });
      });
    }
  }
  void _removeVideo() {
    setState(() {
      _videoFile = null;
//      _controller = VideoPlayerController.asset('assets/placeholder_video.mp4');
      _controller.initialize().then((_) {
        _controller.pause();
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Advanced Information',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20.0.sp
                  ),
                ),
                SizedBox(height: 10.h),
                Center(
                  child: Stack(
                    alignment: AlignmentDirectional.bottomEnd,
                    children: [
                      Container(
                        width: double.infinity.w, // Set width to be twice the radius
                        height: 170.0.h, // Set height to be twice the radius
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8.0), // Adjust the borderRadius as needed
                          color: Colors.green,
                        ),
                        child: _selectedImage != null
                            ? ClipRRect(
                          borderRadius: BorderRadius.circular(8.0),
                          child: Image.file(
                            File(_selectedImage!.files.single.path!) ,
                            fit: BoxFit.cover,
                          ),
                        )
                            : Center(
                          child: Icon(
                            Icons.image,
                            size: 70.sp,
                            color: Colors.white,
                          ),
                        ),
                      ),

                      GestureDetector(
                        onTap: () {
                          _showBottomSheet(context);
                          print("Second CircleAvatar clicked!");
                        },
                        child: CircleAvatar(
                          radius: 18.0.r,
                          backgroundColor: Colors.grey[300],
                          child: Icon(
                            Icons.upload,
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 10.h),
                Text('Upload Image of Course',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 15.0.sp
                  ),
                ),
                SizedBox(height: 10.h),
                _videoFile != null
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
                            valueColor:
                            AlwaysStoppedAnimation<Color>(Colors.blue),
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
                        if (_videoFile != null)
                          Positioned(
                            top: 0,
                            right: 0,
                            child: IconButton(
                              icon: Icon(
                                Icons.delete,
                                color: Colors.white,
                              ),
                              onPressed: () {
                                setState(() {
                                  _removeVideo();
                                });
                              },
                            ),
                          ),
                      ],
                                  ),
                                ),
                    )
                    : Container(),
                SizedBox(height: 20.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: 230.w,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20.0.r,),
                        color: Colors.green,
                      ),
                      child: MaterialButton(
                        child:  Text(
                          'Upload Trailer',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 22.0.sp,
                          ),
                        )  ,

                        onPressed: _pickVideo,
                      ),
                    ),
                  ],
                ),

                SizedBox(height: 20.h),
                Text('Course Description',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 15.0.sp
                  ),
                ),
                SizedBox(height: 10.h),
                TextFormField(
              controller: _courseDescriptionController,
              maxLines: null, // Set to null for a multiline text area
              decoration: InputDecoration(
                hintText: 'Enter your text here...',
              ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Course Description is required';
                    }
                    return null;
                  },

                ),
                SizedBox(height: 20.h),
                Text('What you will teach in this course',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 15.0.sp
                  ),
                ),
                SizedBox(height: 10.h),
                TextFormField(
                  controller: _courseTeachController,
                  maxLines: null, // Set to null for a multiline text area
                  decoration: InputDecoration(
                    hintText: 'Enter your text here...',
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'This Field is required';
                    }
                    return null;
                  },

                ),
                SizedBox(height: 20.h),
                Text('Target Audience',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 15.0.sp
                  ),
                ),
                SizedBox(height: 10.h),
                TextFormField(
                  controller: _targetAudienceController,
                  maxLines: null, // Set to null for a multiline text area
                  decoration: InputDecoration(
                    hintText: 'Enter your text here...',
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Target Audience is required';
                    }
                    return null;
                  },


                ),
                SizedBox(height: 20.h),
                Text('Course Requirments',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 15.0.sp
                  ),
                ),
                SizedBox(height: 10.h),
                TextFormField(
                  controller: _courseRequrirementsController,
                  maxLines: null, // Set to null for a multiline text area
                  decoration: InputDecoration(
                    hintText: 'Enter your text here...',
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Course Requiremenets is required';
                    }
                    return null;
                  },

                ),
                SizedBox(height: 10.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: 230.w,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20.0.r,),
                        color: Colors.green,
                      ),
                      child: MaterialButton(
                        child:  Text(
                          'Save & Next',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 22.0.sp,
                          ),
                        )  ,

                        onPressed: (){
                          if (_formKey.currentState!.validate()) {
                            if(widget.fromUpdateCourse){
                              print('from true mosalam');
                              _updateAdvancedInformation();
                            }
                            else _advancedInformation();
                            ();
                          }
                          //Get.to(Payment());
                        },),
                    ),
                  ],
                )



              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    _timer.cancel(); // Cancel the timer to avoid memory leaks
    super.dispose();
  }
  void _showBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
          // You can customize the content of your bottom sheet here
          padding: EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                title: Text('Please Upload Image!'
                  ,style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                onTap: () {
                  // Handle share action
                  Navigator.pop(context); // Close the bottom sheet
                },
              ),

              ListTile(
                leading: Icon(Icons.store),
                title: Text('Gallery'),
                onTap: () {
                  // Handle delete action
                  _pickImageFromGallery();
                  Navigator.pop(context); // Close the bottom sheet
                },
              ),
            ],
          ),
        );
      },
    );
  }

  Future _pickImageFromGallery()async{
    FilePickerResult? result = await FilePicker.platform.pickFiles();
      if( result == null) return;
    setState(() {
      _selectedImage = result;
    });

  }
}