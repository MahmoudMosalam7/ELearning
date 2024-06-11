import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:learning/Modules/Account/become_an_instructor/Instructor_page/add_new_course/course_curriculum/pick_file_and_video.dart';
import '../../../../../../apis/upload_course/section/http_service_create_section.dart';
import '../../../../../../models/section_model.dart';
import '../../../../../../network/local/cache_helper.dart';
import '../../../../../../shared/constant.dart';
import '../../../../../../translations/locale_keys.g.dart';
import '../add_price_publish.dart';
import 'package:easy_localization/easy_localization.dart';
class CourseCurriculum extends StatefulWidget {
  final bool fromUpdateCourse;
  final String courseId;

  const CourseCurriculum({super.key, required this.fromUpdateCourse, required this.courseId});

  @override
  _CourseCurriculumState createState() => _CourseCurriculumState();
}

class _CourseCurriculumState extends State<CourseCurriculum> {
  TextEditingController _sectionNameControllers = TextEditingController();
  HttpServiceSection httpServiceSection = HttpServiceSection();

  bool isLoading = false;

  String errorMessage = '';
  void _createSection() async {
    // Reset error message and loading state
    setState(() {
      errorMessage = '';
      isLoading = true;
    });

    try {
       String   id = CacheHelper.getData(key: 'courseId');
       print('widget.courseId = ${widget.courseId}');
       if(widget.fromUpdateCourse)
         {id = widget.courseId;
         print('alllllllll');
         }


      // Add your login logic here, e.g., make API call
      String sectionId = await httpServiceSection.createSection(
        id,
        CacheHelper.getData(key: 'token')
      );

      // Login successful, you can navigate to another screen or show a success message
      //Get.to(const HomeLayout());
      errorMessage = "";
      Fluttertoast.showToast(
        msg: "create success",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 5,
        backgroundColor: Colors.green,
        textColor: Colors.white,
        fontSize: 16.0,
      );
      print('section id = $sectionId');
      if(sectionId != 'error'){
        CacheHelper.saveData(key: 'fileId', value: 0);
        print('section id = $sectionId');
        _addSection(sectionId);
      }
      print(' create section successful!');
    } catch (e) {
      // Handle validation errors or network errors
      setState(() {
        errorMessage = 'Error: $e';
        if (errorMessage.contains('404')) {
          // Your code here
          errorMessage ="Email Not Found!";
        }else{
          errorMessage ="Unexpected Error!";
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
  void _deleteSectionFromServer(int index) async {
    // Reset error message and loading state
    setState(() {
      errorMessage = '';
      isLoading = true;
    });

    try {

      // Add your login logic here, e.g., make API call
     await httpServiceSection.deleteSection(
         sections[index].sectionId,
          CacheHelper.getData(key: 'token')
      );

      // Login successful, you can navigate to another screen or show a success message
      //Get.to(const HomeLayout());
      errorMessage = "";
      Fluttertoast.showToast(
        msg: "delete section success",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 5,
        backgroundColor: Colors.green,
        textColor: Colors.white,
        fontSize: 16.0,
      );
     setState(() {
       sections.removeAt(index); //// حذف القسم من الـ sections

     });
      print(' remove section successful!');
    } catch (e) {
      // Handle validation errors or network errors
      setState(() {
        errorMessage = 'Error: $e';
        if (errorMessage.contains('404')) {
          // Your code here
          errorMessage ="Email Not Found!";
        }else{
          errorMessage ="Unexpected Error!";
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
  void dispose() {
    for (var course in sections) {
      for (var video in course.videos) {
        video.videoController?.dispose();
      }
    }

    super.dispose();
  }
  @override
  void initState() {
    super.initState();
    // Initialize _sections with the initial value of sections
    if(widget.fromUpdateCourse){
      sections = Section.parseSectionFromServer(data);
      print('from course circulam = sections = ${sections}');
    }

  }
  @override
  Widget build(BuildContext context) {
    sections = sections;
    sections.length = sections.length;
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                LocaleKeys.InstructorCourseCurriculumCourseCurriculum.tr(),
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20.0.sp,
                ),
              ),
              SizedBox(height: 10.h),
              // Set a fixed height for the container
              Container(
                height: 400.h, // Adjust the height as needed
                child: ListView.builder(

                  shrinkWrap: true,
                  itemCount: sections.length,
                  itemBuilder: (context, index) {
                    return _buildSectionContainer(index);
                  },
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: 230.w,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20.0.r),
                      color: Colors.green,
                    ),
                    child: MaterialButton(
                      child: Text(
                        LocaleKeys.InstructorCourseCurriculumAddSection.tr(),
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 22.0.sp,
                        ),
                      ),
                      onPressed: () {
                        _createSection();

                      },
                    ),
                  ),
                ],
              ),
              SizedBox(height: 10.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: 230.w,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20.0.r),
                      color: Colors.green,
                    ),
                    child: MaterialButton(
                      child: Text(
                        LocaleKeys.InstructorCourseCurriculumSaveNext.tr(),
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 22.0.sp,
                        ),
                      ),
                      onPressed: () {
                        // Handle Save & Next button press
                          Navigator.push(context, MaterialPageRoute(builder: (context){
                          return AddPriceAndPublish(courseId: '', fromInstructor: false,);
                        }));
                      },
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
  Widget _buildSectionContainer(int index) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 8.0),
      padding: EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  IconButton(
                    icon: Icon(Icons.edit),
                    onPressed: () {
                      _editSectionName(index);
                    },
                  ),
                  Text(
                    sections[index].sectionName,
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              IconButton(
                icon: Icon(Icons.delete),
                onPressed: () {
                  _deleteSection(index);
                },
              ),
            ],
          ),
          SizedBox(height: 16.0),
        if(widget.fromUpdateCourse)
          PickFileAndVideo(index: index, counter: sections[index].videos.length, fromUpdataCirc: true,),
        /*  ListView.builder(
            shrinkWrap: true,
            itemCount: sections[index].videos.length,
            itemBuilder: (context, videoIndex) {
              return Text(sections[index].videos[videoIndex].fileName);
            },
          ),

        */
          if(widget.fromUpdateCourse == false)
          PickFileAndVideo(index: index, counter: 0, fromUpdataCirc: false,),
        ],
      ),
    );
  }

  void _editSectionName(int index) {
    // Implement section name editing logic here
    // For example, you can use a dialog or navigate to a new screen
    // to allow the user to edit the section name.

    setState(() {
      //_showUpSheet(context);
      showDialogg(index);
    });
  }

  void _deleteSection(int index) {
    setState(() {
      _deleteSectionFromServer(index);


    });
  }
  void _addSection(String sectionId) {
    setState(() {
      sections.add(Section(
        sectionName: 'Section ${sections.length + 1}',
        sectionId: sectionId,
        videos: [],
      ));
    });
  }


  void showDialogg(int index){
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            LocaleKeys.InstructorCourseCurriculumPleaseChangeSectionName.tr(),
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.bold,
            ),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: _sectionNameControllers,
                decoration: InputDecoration(
                  hintText: '${LocaleKeys.InstructorCourseCurriculumEnterSectionName.tr()}',
                ),
                onSubmitted: (value) {
                  setState(() {
                    if(!value.isEmpty)
                      sections[index].sectionName = value;
                  });
                  Navigator.pop(context);
                },
              ),
              SizedBox(height: 16.0), // Add some spacing if needed

            ],
          ),
        );
      },
    );
  }
}
