
import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:learning/shared/constant.dart';
import 'package:easy_localization/easy_localization.dart';
import '../../../apis/courseInformation/http_service_courseInformation.dart';
import '../../../network/local/cache_helper.dart';
import '../../../translations/locale_keys.g.dart';

class PaymentByMethod extends StatefulWidget {
   PaymentByMethod({required this.courseId,required this.coursePrice,
     required this.numberOFMethod,this.coupon
   });
  String courseId;
  String coursePrice;
  String numberOFMethod;
  String? coupon;
  @override
  State<PaymentByMethod> createState() => _PaymentByMethodState();
}

class _PaymentByMethodState extends State<PaymentByMethod> {

  final _phoneContoller = TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  FilePickerResult? _selectedImage;
  HttpServiceCourse httpServiceCourse = HttpServiceCourse();
  bool isLoading = false;
  bool isWait = false;
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
      print('f1= ${_selectedImage!.files.single.path}');
      print('f2= ${getData?['data']['_id']}');
      print('f3= ${pohonePrice}');
      print('f4= ${_phoneContoller.text}');
      print('f5= ${widget.courseId}');
      print('f6= ${CacheHelper.getData(key: 'token')}');
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
      setState(() {
        isWait = true;
      });
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
        print(' error! = $e');
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
        title: Text(LocaleKeys.PaymentByMethodBuy.tr()),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('${LocaleKeys.PaymentByMethodPriceofCourse.tr()} ${widget.coursePrice}'),
              SizedBox(height: 10.h,),
              Text('${LocaleKeys.PaymentByMethodSendonThisNumber.tr()} ${widget.numberOFMethod}'),
              SizedBox(height: 10.h,),
              Text(LocaleKeys.PaymentByMethodEntertheSenderPhone.tr()),
              SizedBox(height: 10.h,),
              Form(child: Column(
                key: _formKey,
                children: [
                  TextFormField(
                    controller: _phoneContoller,
                    decoration:  InputDecoration(
                      labelText:'${LocaleKeys.PaymentByMethodSenderPhoneNumber.tr()}',
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
                        return '${LocaleKeys.PaymentByMethodPhoneisrequired.tr()}';
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
              Text( LocaleKeys.PaymentByMethodUploadImageofPaymentReceipt.tr(),
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 15.0.sp
                ),
              ),
              SizedBox(height: 10.h),
              Container(
                color: Colors.green,
                child: MaterialButton(
                  child:  Text(
                    LocaleKeys.PaymentByMethodEnrollNow.tr(),
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
                ),
              ),
              SizedBox(height: 10.h),
              if(isWait)
                Text(LocaleKeys.Pleasewait10minutestoverifyyourpurchase.tr())
          
            ],
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
                title: Text(LocaleKeys.PaymentByMethodPleaseUploadImage.tr()
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
                title: Text(LocaleKeys.PaymentByMethodGallery.tr()),
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
