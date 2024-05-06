
import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:learning/shared/constant.dart';

import '../../../apis/courseInformation/http_service_courseInformation.dart';
import '../../../network/local/cache_helper.dart';

class PaymentByMethod extends StatefulWidget {
   PaymentByMethod({super.key,required this.courseId,required this.coursePrice,
     required this.numberOFMethod
   });
  String courseId;
  String coursePrice;
  String numberOFMethod;

  @override
  State<PaymentByMethod> createState() => _PaymentByMethodState();
}

class _PaymentByMethodState extends State<PaymentByMethod> {

  final _phoneContoller = TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  FilePickerResult? _selectedImage;
  HttpServiceCourse httpServiceCourse = HttpServiceCourse();
  bool isLoading = false;

  String errorMessage = '';
  void _paymentByMethod() async {
    // Reset error message and loading state
    //price is : ${widget.coursePrice} and phone of admin : ${widget.numberOFMethod}
    String pohonePrice = '${widget.coursePrice}';
    setState(() {
      errorMessage = '';
      isLoading = true;
    });

    try {


      print(']]]]]]]]]]]]]]]]]]]]]from edit');
      print('from payment');
      await httpServiceCourse.paymentByMethod(
          _selectedImage!.files.single.path,
          getData?['data']['_id'],
          pohonePrice,
          _phoneContoller.text,
          widget.courseId,

          // Use _profileImage directly
          CacheHelper.getData(key: 'token')
      );

      print('from payment');
      errorMessage = "";
      Fluttertoast.showToast(
        msg: "Payment  Success",
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
      appBar: AppBar(
        title: Text('Buy'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Price of Course : ${widget.coursePrice}'),
            SizedBox(height: 10.h,),
            Text('Send on This Number : ${widget.numberOFMethod}'),
            SizedBox(height: 10.h,),
            Text('Enter the Sender Phone : '),
            SizedBox(height: 10.h,),
            Form(child: Column(
              key: _formKey,
              children: [
                TextFormField(
                  controller: _phoneContoller,
                  decoration: const InputDecoration(
                    labelText:'Sender Phone Number',
                    labelStyle: TextStyle(
                      fontSize: 25.0,
                    ),
                    prefixIcon: Icon(
                      Icons.phone,
                    ),
                    border: OutlineInputBorder(),
                  ),
                  textAlign: TextAlign.start,
                  keyboardType: TextInputType.phone,
                  onFieldSubmitted: (value){
                  },

                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Phone is required';
                    }
                    return null;
                  },

                ),
              ],
            )),
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
            Text('Upload Image of Payment Receipt  ',
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 15.0.sp
              ),
            ),
            SizedBox(height: 10.h),
            MaterialButton(
              child: const Text(
                'Enroll Now',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20.0,
                ),
              ),
              onPressed: () {
                print('payment = ${getData?['data']['_id']}');
                print('payment = ${_phoneContoller.text}');
                print('payment = ${widget.courseId}');
                _paymentByMethod();
                /*
                if (_formKey.currentState!.validate()) {
                  print('from payment');
                  if (_selectedImage != null) {

                  } else {
                    // Handle case where no image is selected
                    Fluttertoast.showToast(
                      msg: "Please upload an image",
                      toastLength: Toast.LENGTH_SHORT,
                      gravity: ToastGravity.BOTTOM,
                      timeInSecForIosWeb: 5,
                      backgroundColor: Colors.red,
                      textColor: Colors.white,
                      fontSize: 16.0,
                    );
                  }
                }*/
              },
            )

          ],
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
