import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';

import '../../../TColors.dart';
import '../../../apis/edit_profile/http_service_edit_profile.dart';
import '../../../apis/http_service_get_user_data.dart';
import '../../../network/local/cache_helper.dart';
import '../../../shared/constant.dart';

class EditAccount extends StatefulWidget{
  @override
  State<EditAccount> createState() => _EditAccountState();
}

class _EditAccountState extends State<EditAccount> {
  @override

  var usernameContoller = TextEditingController();

  var bioContoller = TextEditingController();

  var emailContoller = TextEditingController();

  var phoneContoller = TextEditingController();

  var genderContoller = TextEditingController();
  File? _selectedImage;
  XFile? _profileImage;
  final HttpServiceEditProfile httpService = HttpServiceEditProfile();

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
          usernameContoller.text,
          emailContoller.text,
          bioContoller.text,
          phoneContoller.text,
          genderContoller.text,
          _profileImage!, // Use _profileImage directly
          CacheHelper.getData(key: 'token'),
        );


      errorMessage = "";
      Fluttertoast.showToast(
        msg: "Update Success",
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
        if (errorMessage.contains('404')) {
          errorMessage = "Email Not Found!";
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
  final HttpServiceGetData httpServiceGetData = HttpServiceGetData();
  var im ;
  Future<void> fetchData() async {
    try {
      String? token = CacheHelper.getData(key:'token');
      // Call getData method with the authentication token
      Map<String, dynamic> data = await httpServiceGetData.getData(token!);

      // Update the state with the fetched data
      setState(() {
        getData = data;
        im = getData?['data']['profileImage'];
        print('im = $im');
      });

      // Print or use the fetched data as needed
      print('Fetched Data: $getData');
    } catch (e) {
      // Handle errors, if any
      print('Error fetching data: $e');
    }
  }

  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          leading:
          TextButton(

            onPressed: (){
              Navigator.pop(context);
            },
            child:Text("Cancel",
              style: TextStyle(
                  fontSize:9.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.red
              ),),
          ),
          title:
          Text(
            "Edit Profile",
            style: TextStyle(
              fontSize: 25.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          actions: [
            TextButton(
              onPressed: (){
                  _updateMe();
                  fetchData();
              },
              child:Text("Done",
                style: TextStyle(
                    fontSize:10.0 ,
                    fontWeight: FontWeight.bold,
                    color: TColors.Ternary
                ),),
            ),
          ],
        ),
        body:
        SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(

                  padding: EdgeInsets.all(20.0),
                  child: Center(
                    child: Column(
                      children: [
                        Center(
                          child: Stack(
                            alignment: AlignmentDirectional.bottomEnd,
                            children: [
                              CircleAvatar(
                                radius: 72.0.r,
                                backgroundColor: Colors.green,
                                child: CircleAvatar(
                                  radius: 70.0.r,
                                  backgroundColor: Colors.grey,
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
                                    color: Colors.grey[200],
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
                                  backgroundColor: Colors.grey,
                                  child: Icon(
                                    Icons.camera_alt,
                                                ),
                                ),
                              ),
                            ],
                          ),
                        ),

                        SizedBox(height: 20.0,),
                        Container(
                          decoration: BoxDecoration(

                              borderRadius: BorderRadius.circular(20)),
                          padding: EdgeInsets.all(.0),
                          child: TextFormField(

                            controller: usernameContoller,
                            decoration: InputDecoration(

                                labelText: "username",
                                border: OutlineInputBorder(
                                    borderRadius:BorderRadius.all(Radius.circular(20.0) )
                                )
                            ),

                          ),
                        ),
                        SizedBox(height: 20.0,),
                        Container(
                          decoration: BoxDecoration(

                              borderRadius: BorderRadius.circular(20)),
                          padding: EdgeInsets.all(.0),
                          child: TextFormField(
                            keyboardType: TextInputType.visiblePassword,
                            controller: bioContoller,
                            decoration: InputDecoration(
                                labelText: "Bio",
                                border: OutlineInputBorder(
                                    borderRadius:BorderRadius.all(Radius.circular(20.0) )
                                )
                            ),

                          ),
                        ),
                        SizedBox(height: 20.0,),
                        Container(
                          decoration: BoxDecoration(

                              borderRadius: BorderRadius.circular(20)),
                          padding: EdgeInsets.all(.0),
                          child: TextFormField(
                            keyboardType: TextInputType.emailAddress,
                            controller: emailContoller,
                            decoration: InputDecoration(
                                labelText: "email",
                                border: OutlineInputBorder(
                                    borderRadius:BorderRadius.all(Radius.circular(20.0) )
                                )
                            ),

                          ),
                        ),
                        SizedBox(height: 20.0,),
                        Container(
                          decoration: BoxDecoration(

                              borderRadius: BorderRadius.circular(20)),
                          padding: EdgeInsets.all(.0),
                          child: TextFormField(
                            keyboardType: TextInputType.phone,
                            controller: phoneContoller,
                            decoration: InputDecoration(
                                labelText: "phone",
                                border: OutlineInputBorder(
                                    borderRadius:BorderRadius.all(Radius.circular(20.0) )
                                )
                            ),
                          ),
                        ),
                        SizedBox(height: 20.0,),
                        Container(
                          decoration: BoxDecoration(

                              borderRadius: BorderRadius.circular(20)),
                          padding: EdgeInsets.all(.0),
                          child: TextFormField(
                            controller: genderContoller,
                            decoration: InputDecoration(
                                labelText: "Gender",
                                border: OutlineInputBorder(
                                    borderRadius:BorderRadius.all(Radius.circular(20.0) )
                                )
                            ),

                          ),
                        ),

                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        )


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
                leading: Icon(Icons.camera_alt),
                title: Text('Camera'),
                onTap: () {
                  // Handle edit action
                  _pickImageFromCamera();
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
  Future _pickImageFromGallery() async {
    final image = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (image == null) return;
      print('from pic image = $image');
    setState(() {
      _profileImage = image;
      _selectedImage = File(image.path);
    });
  }

  Future _pickImageFromCamera() async {
    final image = await ImagePicker().pickImage(source: ImageSource.camera);
    if (image == null) return;

    setState(() {
      _profileImage = image;
      _selectedImage = File(image.path);
    });
  }

}