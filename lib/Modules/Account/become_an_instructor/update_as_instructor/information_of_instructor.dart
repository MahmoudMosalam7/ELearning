import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:easy_localization/easy_localization.dart';
import '../../../../apis/update_instructor/http_service_update_instructor.dart';
import '../../../../network/local/cache_helper.dart';
import '../../../../translations/locale_keys.g.dart';

class InstructorInformation extends StatefulWidget {
  @override
  State<InstructorInformation> createState() => _InstructorInformationState();
}

class _InstructorInformationState extends State<InstructorInformation> {
  File? _selectedImage;
  final _jobTitleContoller = TextEditingController();
  final _jobDescriptionContoller = TextEditingController();
  final _faceAccountContoller = TextEditingController();
  final _linkedinAccountContoller = TextEditingController();
  final _instagramAccountContoller = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  XFile? _profileImage;
  final HttpServiceUpdateInstructor httpService = HttpServiceUpdateInstructor();

  bool isLoading = false;

  String errorMessage = '';
  void _updateMe() async {
    // Reset error message and loading state
    setState(() {
      errorMessage = '';
      isLoading = true;
    });

    try {


      // Check if _profileImage is not null before calling updateMe

      print(']]]]]]]]]]]]]]]]]]]]]from edit');
      await httpService.updateMe(
        _jobTitleContoller.text,
        _jobDescriptionContoller.text,
        _faceAccountContoller.text,
        _linkedinAccountContoller.text,
        _instagramAccountContoller.text,
        _profileImage!, // Use _profileImage directly
        CacheHelper.getData(key: 'token'),
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
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(LocaleKeys.InstructorInstructorInformationPleaseCompleteThisInformation.tr(),
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16.0.sp
                ),
                ),
                SizedBox(height: 20.h,),
                Center(
                  child: Stack(
                    alignment: AlignmentDirectional.bottomEnd,
                    children: [
                      CircleAvatar(
                        radius: 72.0.r,
                        backgroundColor: Colors.green,
                        child: CircleAvatar(
                          radius: 70.0.r,
                          child: _selectedImage != null
                              ? ClipOval(
                            clipBehavior: Clip.antiAlias,
                            child: Image.file(
                              _selectedImage!,
                              fit: BoxFit.cover,
                              width: 140.0.w, // Set width to be twice the radius
                              height: 140.0.h, // Set height to be twice the radius
                            ),
                          )
                              : Icon(
                            Icons.person,
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
                            Icons.camera_alt,
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 20.h,),
                TextFormField(
                  keyboardType: TextInputType.visiblePassword,
                  obscureText: false,
                  controller: _jobTitleContoller,
                  decoration: InputDecoration(
                      labelText: "${LocaleKeys.InstructorInstructorInformationJobTitle.tr()}",
                      border: OutlineInputBorder(
                          borderRadius:BorderRadius.all(Radius.circular(20.0.r) )
                      )
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return '${LocaleKeys.InstructorInstructorInformationJobTitleisrequired.tr()}';
                    }
                    return null;
                  },


                ),
                SizedBox(height: 10.h,),
                TextFormField(
                  keyboardType: TextInputType.visiblePassword,
                  obscureText: false,
                  controller: _jobDescriptionContoller,
                  decoration: InputDecoration(
                      labelText: "${LocaleKeys.InstructorInstructorInformationJobDescription.tr()}",
                      border: OutlineInputBorder(
                          borderRadius:BorderRadius.all(Radius.circular(20.0.r) )
                      )
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return '${LocaleKeys.InstructorInstructorInformationJobDescriptionisrequired.tr()}';
                    }
                    return null;
                  },


                ),
                SizedBox(height: 10.h,),
                TextFormField(
                  keyboardType: TextInputType.visiblePassword,
                  obscureText: false,
                  controller: _faceAccountContoller,
                  decoration: InputDecoration(
                      labelText: "${LocaleKeys.InstructorInstructorInformationFaceBookAccountUrl.tr()}",
                      border: OutlineInputBorder(
                          borderRadius:BorderRadius.all(Radius.circular(20.0.r) )
                      )
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return '${LocaleKeys.InstructorInstructorInformationFaceBookAccountisrequired.tr()}';
                    }
                    return null;
                  },


                ),
                SizedBox(height: 10.h,),
                TextFormField(
                  keyboardType: TextInputType.visiblePassword,
                  obscureText: false,
                  controller: _linkedinAccountContoller,
                  decoration: InputDecoration(
                      labelText: "${LocaleKeys.InstructorInstructorInformationLinkedinAccountUrl.tr()}",
                      border: OutlineInputBorder(
                          borderRadius:BorderRadius.all(Radius.circular(20.0.r) )
                      )
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return '${LocaleKeys.InstructorInstructorInformationLinkedinAccountisrequired.tr()}';
                    }
                    return null;
                  },


                ),
                SizedBox(height: 10.h,),
                TextFormField(
                  keyboardType: TextInputType.visiblePassword,
                  obscureText: false,
                  controller: _instagramAccountContoller,
                  decoration: InputDecoration(
                      labelText: "${LocaleKeys.InstructorInstructorInformationInstagramAccountUrl.tr()}",
                      border: OutlineInputBorder(
                          borderRadius:BorderRadius.all(Radius.circular(20.0.r) )
                      )
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return '${LocaleKeys.InstructorInstructorInformationInstagramAccountisrequired.tr()}';
                    }
                    return null;
                  },


                ),
                SizedBox(height: 15.h,),
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
                          '${LocaleKeys.InstructorInstructorInformationsave.tr()}',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 22.0.sp,
                          ),
                        )  ,

                        onPressed: (){
                          if (_formKey.currentState!.validate()) {
                            _updateMe();
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
                title: Text('${LocaleKeys.EditAccountPleaseUploadImage.tr()}'
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
                leading: Icon(Icons.camera_alt),
                title: Text('${LocaleKeys.EditAccountCamera.tr()}'),
                onTap: () {
                  // Handle edit action
                  _pickImageFromCamera();
                  Navigator.pop(context); // Close the bottom sheet
                },
              ),
              ListTile(
                leading: Icon(Icons.store),
                title: Text('${LocaleKeys.EditAccountGallery.tr()}'),
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
    final image = await ImagePicker().pickImage(source: ImageSource.gallery);
    if( image == null) return;
    setState(() {
      _profileImage = image;
      _selectedImage = File(image.path);
    });

  }
  Future _pickImageFromCamera()async{
    final image = await ImagePicker().pickImage(source: ImageSource.camera);
    if( image == null) return;
    setState(() {
      _profileImage = image;
      _selectedImage = File(image.path);
    });

  }
}
