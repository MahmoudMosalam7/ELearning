
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:learning/Modules/Account/become_an_instructor/Instructor_page/add_new_course/course_curriculum/pick_file_and_video.dart';

import '../../../../../../models/file_and_video_of_section_model.dart';
import '../../../../../../models/section_model.dart';
import '../../../../../../shared/constant.dart';

class CourseCurriculum extends StatefulWidget {
  @override
  _CourseCurriculumState createState() => _CourseCurriculumState();
}

class _CourseCurriculumState extends State<CourseCurriculum> {
  final ImagePicker _imagePicker = ImagePicker();
  TextEditingController _sectionNameControllers = TextEditingController();
  TextEditingController _videoNameControllers = TextEditingController();
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
  Widget build(BuildContext context) {
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
                'Course Curriculum',
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
                        'Add Section',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 22.0.sp,
                        ),
                      ),
                      onPressed: () {
                        _addSection();
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
                        'Save & Next',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 22.0.sp,
                        ),
                      ),
                      onPressed: () {
                        // Handle Save & Next button press
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
          PickFileAndVideo(index: index,),
        ],
      ),
    );
  }

  Widget _buildVideoButton(int index) {
    return Container(
      padding: EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        color: Colors.grey[300],
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text('Videos ${index + 1}'),
          Row(
            children: [
              IconButton(
                icon: Icon(Icons.edit),
                onPressed: () {
                  _editSectionName(index);
                },
              ),
              IconButton(
                icon: Icon(Icons.add),
                onPressed: () async {
                  File? videoFile = await _pickVideo();
                  if (videoFile != null) {
                    setState(() {
                      sections[index].videos.add(PickFile(
                        fileName: '',
                      ));
                    });
                  }
                },
              ),
              IconButton(
                icon: Icon(Icons.delete),
                onPressed: () {

                },
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildVideoField(int sectionIndex, int videoIndex) {
    PickFile video = sections[sectionIndex].videos[videoIndex];
    return Row(
      children: [
        IconButton(
          icon: Icon(Icons.edit),
          onPressed: () {
            _editVideoName(sectionIndex, videoIndex);
          },
        ),
        IconButton(
          icon: Icon(Icons.add),
          onPressed: () async {
            File? videoFile = await _pickVideo();
            if (videoFile != null) {
              setState(() {
                sections[sectionIndex].videos.add(PickFile(
                  fileName: '',
                ));
              });
            }
          },
        ),
        IconButton(
          icon: Icon(Icons.delete),
          onPressed: () {
            _deleteVideo(sectionIndex, videoIndex);
          },
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: TextField(
              onChanged: (value) {
                setState(() {
                  sections[sectionIndex].videos[videoIndex].fileName = value;
                });
              },
              decoration: InputDecoration(
                hintText: 'Enter video name',
                suffixIcon: null,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Future<File?> _pickVideo() async {
    final pickedFile =
    await _imagePicker.pickVideo(source: ImageSource.gallery);
    if (pickedFile != null) {
      return File(pickedFile.path);
    } else {
      return null;
    }
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
      sections.removeAt(index);
    });
  }

  void _addSection() {
    setState(() {
      Section duplicatedCourse = Section(
        sectionName: 'Section ${sections.length + 1}',
        videos: [],
      );
      sections.add(duplicatedCourse);
    });
  }

  void _deleteVideo(int sectionIndex, int videoIndex) {
    setState(() {
      PickFile video = sections[sectionIndex].videos[videoIndex];
      video.videoController?.dispose();
      sections[sectionIndex].videos.removeAt(videoIndex);
    });
  }

  void _addVideo(int sectionIndex) {
    setState(() {
      sections[sectionIndex].videos.add(PickFile(
        fileName: 'file',
      ));
    });
  }

  void _editVideoName(int sectionIndex, int videoIndex) {
    // Implement video name editing logic here
    // For example, you can use a dialog or navigate to a new screen
    // to allow the user to edit the video name.
  }
  void showDialogg(int index){
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            'Please Change Section Name!',
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
                  hintText: 'Enter Section Name',
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
