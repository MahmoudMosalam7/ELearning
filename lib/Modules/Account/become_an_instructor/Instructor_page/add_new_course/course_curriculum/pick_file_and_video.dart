
import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:video_player/video_player.dart';

import '../../../../../../apis/upload_course/section/http_service_create_section.dart';
import '../../../../../../models/file_and_video_of_section_model.dart';
import '../../../../../../network/local/cache_helper.dart';
import '../../../../../../shared/constant.dart';
import 'file_and_video_container.dart';

class PickFileAndVideo extends StatefulWidget {
  final int index;

  const PickFileAndVideo({super.key, required this.index});
  @override
  _PickFileAndVideoState createState() => _PickFileAndVideoState();
}

class _PickFileAndVideoState extends State<PickFileAndVideo> {
  int containerCount = 0; // Set an initial number of containers
  String videoName = 'Videos';
  VideoPlayerController? _videoController;
  FilePickerResult? _videoFile;
 // _pickVideo
  TextEditingController _videoNameControllers = TextEditingController();
  HttpServiceSection httpServiceSection = HttpServiceSection();

  bool isLoading = false;

  String errorMessage = '';
  dynamic fileId;
  void _updateSection() async {
    // Reset error message and loading state
    setState(() {
      errorMessage = '';
      isLoading = true;
    });

    try {

      // Add your login logic here, e.g., make API call
       fileId = await httpServiceSection.updateSection(
          sections[widget.index].sectionId,
          _videoFile!.files.single.path!,
          CacheHelper.getData(key: 'token')
      );

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
      if(fileId != -1)
       print(fileId);
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
  void _deleteModules(String id) async {
    // Reset error message and loading state
    setState(() {
      errorMessage = '';
      isLoading = true;
    });

    try {

      // Add your login logic here, e.g., make API call
     await httpServiceSection.deleteModuleOfSection(
        id,
         CacheHelper.getData(key: 'token')
      );

      errorMessage = "";
      Fluttertoast.showToast(
        msg: "delete module success",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 5,
        backgroundColor: Colors.lightBlueAccent,
        textColor: Colors.white,
        fontSize: 16.0,
      );


        print(' delete module successful!');
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
  void _updateModuleName(String id,String name)async{
    setState(() {
      errorMessage = '';
      isLoading = true;
    });

    try {

      // Add your login logic here, e.g., make API call
      await httpServiceSection.changeModuleName(
            id,
          CacheHelper.getData(key: 'token'),
          name
      );

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
      if(fileId != -1)
        print(fileId);
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


  @override
  void initState() {
    super.initState();
    // Initialize containerCount in initState
    containerCount = 0;
    _videoController = VideoPlayerController.asset('assets/placeholder_video.mp4');
    _videoController!.addListener(() {
      if (!_videoController!.value.isPlaying &&
          _videoController!.value.isInitialized &&
          (_videoController!.value.position == _videoController!.value.duration)) {
        // Video has reached the end, pause and seek to the beginning
        _videoController!.pause();
        _videoController!.seekTo(Duration.zero);
      }

    });

  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListView.builder(
          shrinkWrap: true,
          itemCount: containerCount,
          itemBuilder: (context, index) {
            CacheHelper.saveData(key:'fileId',value: index);
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 10.0),
              child: FileAndVideoContainer(
                index: index,
                sectionIndex: widget.index,
                onEdit: _editViedoName,
                onAdd: _addVideo,
                onDelete: _deleteFileContainer,
                onDuplicate: _duplicateFileContainer,
              ),
            );
          },
        ),

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
                  'Add File',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 22.0.sp,
                  ),
                )  ,

                onPressed: (){
                  _duplicateFileContainer();
                  //Get.to(Payment());
                },),
            ),
          ],
        ),
      ],
    );
  }

  void _editViedoName(int index) {
    // Implement section name editing logic here
    print("inside dynamic video index = $index");
    print("inside dynamic section index = $index");
    setState(() {
      showDialogg(index);
    });
  }

  void _deleteFileContainer(int index) {
    setState(() {
      containerCount--;
      setState(() {
        String _id = fileId['modules'][index];
        print('from delte file = $_id');
        _deleteModules(_id);
        sections[widget.index].videos.removeAt(index);
      });
    });
  }

  void _duplicateFileContainer() {
    setState(() {

      setState(() {
        sections[widget.index].videos.add(PickFile(
          fileName: 'file OR Video Name $containerCount',
        ));
      });
      containerCount++;
    });
  }

  void _addVideo(int index ) {
    // Implement logic to add a video
    setState(() {
      _showBottomSheet(context,index );
    });
    print("inside dynamic video index = $index");
    print("inside dynamic section index = ${widget.index}");
    print("courses = ${sections.toString()}");
  }

  void showDialogg(int index) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            'Edit Video OR File Name',
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: _videoNameControllers,
                onSubmitted: (value) {
                  // Set the instance variable, not the local one
                  setState(() {
                    if(!value.isEmpty){
                      videoName = value;
                      sections[widget.index].videos[index].fileName = value;
                      _updateModuleName(fileId['modules'][index],videoName);
                    }

                  });
                  Navigator.pop(context);
                },
                decoration: InputDecoration(
                  hintText: 'Enter Video Name',
                ),
              ),
              SizedBox(height: 16.0), // Add some spacing if needed
            ],
          ),
        );
      },
    );
  }
  void _showBottomSheet(BuildContext context,int index ) {
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
                title: Text('Please Upload File OR Video!'
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
                leading: Icon(Icons.file_upload),
                title: Text('File'),
                onTap: () {
                  // Handle delete action
                  // _pickImageFromGallery();
                  openPDFViewer(index);
                  Navigator.pop(context); // Close the bottom sheet
                },
              ),
              ListTile(
                leading: Icon(Icons.ondemand_video_outlined),
                title: Text('Video'),
                onTap: () {
                  // Handle delete action
                  // _pickImageFromGallery();
                  setState(() {
                   //zzzz
                    _pickVideo(index);
                  });
                  Navigator.pop(context); // Close the bottom sheet
                },
              ),
            ],
          ),
        );
      },
    );
  }

  Future<void> _pickVideo(int index) async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
    );

    if (result != null && result.files.isNotEmpty) {

      setState(() {
        _videoFile = result;
        _updateSection();
        sections[widget.index].videos[index].id = index;
        _videoController = VideoPlayerController.file(File(
            result.files.first.path!!!));
        if(sections[widget.index].videos[index].pdfFilePath != null){
          sections[widget.index].videos[index].pdfFilePath = null;
          sections[widget.index].videos[index].pdfViewer = null;
        }
        sections[widget.index].videos[index].addFile(File(
            result.files.first.path!!!));
        _videoController!.initialize().then((_) {
          _videoController!.pause();
        });
        print('file id from pick = ${
            sections[widget.index].videos[index].id = index}');
      });
    }
  }////////==================================================================
  Future<void> openPDFViewer(int index) async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf'],
    );

    if (result != null && result.files.isNotEmpty) {
      File pickedFile = File(result.files.first.path!);
      setState(() {
        if(sections[widget.index].videos[index].videoController != null)
          sections[widget.index].videos[index].videoController = null;
        sections[widget.index].videos[index].addFile(pickedFile);
      });
      // await launchPDFViewer(pickedFile);
    } else {
      // User canceled the file picking
      print('User canceled the file picking.');
    }
  }

  void _removeVideo() {
    setState(() {
      _videoFile = null;
//      _controller = VideoPlayerController.asset('assets/placeholder_video.mp4');
      _videoController!.initialize().then((_) {
        _videoController!.pause();
      });
    });
  }

}
