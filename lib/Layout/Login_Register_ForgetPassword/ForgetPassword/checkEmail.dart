import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:easy_localization/easy_localization.dart';
import '../../../TColors.dart';
import '../../../apis/forget_password/forget_password.dart';
import '../../../apis/forget_password/http_service_check_your_email.dart';
import '../../../network/local/cache_helper.dart';
import '../../../translations/locale_keys.g.dart';
import 'ResetPassword.dart';
class CheckEmail extends StatefulWidget {
  String email;
  CheckEmail({required this.email});
  @override
  State<CheckEmail> createState() => _CheckEmailState();
}

class _CheckEmailState extends State<CheckEmail> {
  final _codeContoller = TextEditingController();
  late String email;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final HttpServiceForgetPassword httpService = HttpServiceForgetPassword();
  final HttpServiceCheckEmail httpServiceCheckEmail = HttpServiceCheckEmail();
  bool isLoading = false;

  String errorMessage = '';
  bool? darkMode = false;
  void initState(){
    super.initState();
    darkMode = CacheHelper.getData(key: 'darkMode');
    if (darkMode == null)
      darkMode = false ;
  }
  void _forgetPassword() async {
    // Reset error message and loading state
    setState(() {
      errorMessage = '';
      isLoading = true;
    });

    try {

      // Add your login logic here, e.g., make API call
      await httpService.forgetPassword(
        widget.email,
      );

      // Login successful, you can navigate to another screen or show a success message
      //Get.to(const HomeLayout());
      errorMessage = "";
      Fluttertoast.showToast(
        msg: "Check your Email",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 5,
        backgroundColor: Colors.green,
        textColor: Colors.white,
        fontSize: 16.0,
      );

      //Get.to(CheckEmail(email: _emailContoller.text,));

      print(' successful!');
    } catch (e) {
      // Handle validation errors or network errors
      setState(() {
        errorMessage = 'Error: $e';
        if (errorMessage.contains('404')) {
          // Your code here
          errorMessage ="Email Not Found!";
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
  void _checkEmail() async {
    // Reset error message and loading state
    setState(() {
      errorMessage = '';
      isLoading = true;
    });
    int code = int.parse(_codeContoller.text);
     print('code = $code');
    try {

      // Add your login logic here, e.g., make API call
      await httpServiceCheckEmail.checkEmail(
        _codeContoller.text,
      );

      // Login successful, you can navigate to another screen or show a success message
      //Get.to(const HomeLayout());
      errorMessage = "";
      Fluttertoast.showToast(
        msg: "Valid Code",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 5,
        backgroundColor: Colors.green,
        textColor: Colors.white,
        fontSize: 16.0,
      );
      Navigator.push(context, MaterialPageRoute(builder: (context){
        return ResetPassword( email: email,);
      }));
      print(' successful!');
    } catch (e) {
      // Handle validation errors or network errors
      setState(() {
        errorMessage = 'Error: $e';
        if (errorMessage.contains('422')) {
          // Your code here
          errorMessage ="Reset Code Must be 6 number!";
        }
        else if(errorMessage.contains('400')){

          errorMessage ="Reset Code Not Valid!";
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
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:TColors.primary,
      body:  ListView(
        children: [
          SizedBox(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height/3.0,
            child:  Column(
              children: [
                SizedBox(height: 80.0.h,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(LocaleKeys.CheckEmailCheckyourEmail.tr(),
                      style:TextStyle(
                        fontWeight: FontWeight.bold ,
                        fontSize: 40.0.sp,
                        color: Colors.white,
                      ) ,)

                  ],
                ),
                SizedBox(height: 10.0.h,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children:[
                    Text(LocaleKeys.CheckEmailPleaseEntertheCodeofVerification.tr(),
                    style:TextStyle(
                      fontWeight: FontWeight.bold ,
                      fontSize: 15.0.sp,
                      color: Colors.white,
                    ) ,),
                 ],
                ),
              ],
            ),
          ),
          Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            decoration: BoxDecoration(
              color: darkMode!?Colors.black:Colors.white,
              borderRadius: BorderRadius.circular(65.0.r,),
            ),
            child: Padding(
              padding:  EdgeInsets.all(20.0.sp),
              child: SingleChildScrollView(
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      SizedBox(height: 40.0.h,),
                                              // text field for phone number
                      TextFormField(
                       controller: _codeContoller,

                       decoration:  InputDecoration(
                         labelText:'${LocaleKeys.CheckEmailVerificationCode.tr()}',
                         labelStyle: TextStyle(
                           fontSize: 25.0.sp,
                         ),
                         prefixIcon: Icon(
                           Icons.numbers,
                         ),
                         border: OutlineInputBorder(),
                       ),
                       textAlign: TextAlign.start,
                       keyboardType: TextInputType.number,
                       onFieldSubmitted: (value){
                       },
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return '${LocaleKeys.CheckEmailCodeisrequired.tr()}';
                          }
                          return null;
                          },

                      ),
                      SizedBox(height: 20.0.h,),
                      SizedBox(height: 10.0.h,),
                      SizedBox(height: 20.0.h,),
                      Container(
                         width: double.infinity,
                         decoration: BoxDecoration(
                           borderRadius: BorderRadius.circular(20.0.r,),
                           color: const Color(0xff1A5D1A),
                         ),
                         child: MaterialButton(

                           child:  Text(

                             LocaleKeys.CheckEmailContinue.tr(),
                             style: TextStyle(
                               color: Colors.white,
                               fontSize: 20.0.sp,
                             ),
                           ),

                           onPressed: (){
                             if (_formKey.currentState!.validate()) {
                               email = widget.email;
                               _checkEmail();
                             }

                           },)),
                      SizedBox(height: 10.0.h,),
                      Align(
                       alignment: Alignment.bottomRight,
                       child: GestureDetector(
                         onTap: (){
                           _forgetPassword();
                         },
                         child:  Text(LocaleKeys.CheckEmailsendcode.tr(),style:
                         TextStyle(
                           fontSize: 15.0.sp,
                           color:Colors.blue,
                         ),
                         ),
                       ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),

    );;
  }
}
