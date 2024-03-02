import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../../TColors.dart';
import '../../../apis/forget_password/forget_password.dart';
import '../../../network/local/cache_helper.dart';
import 'ResetPassword.dart';
import 'checkEmail.dart';
class ForgetPassword extends StatefulWidget {


  @override
  State<ForgetPassword> createState() => _ForgetPasswordState();
}

class _ForgetPasswordState extends State<ForgetPassword> {
  final _emailContoller = TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final HttpServiceForgetPassword httpService = HttpServiceForgetPassword();

  bool isLoading = false;

  String errorMessage = '';
  bool darkMode = false;
  void initState(){
    super.initState();
    darkMode = CacheHelper.getData(key: 'darkMode');
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
        _emailContoller.text,
      );

      // Login successful, you can navigate to another screen or show a success message
      //Get.to(const HomeLayout());
      errorMessage = "";
      Fluttertoast.showToast(
        msg: "Valid Email",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 5,
        backgroundColor: Colors.green,
        textColor: Colors.white,
        fontSize: 16.0,
      );

      Get.to(CheckEmail(email: _emailContoller.text,));

      print(' successful!');
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
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:TColors.primary,
      body:  ListView(
        children: [
          SizedBox(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height/3.0,
            child: const Column(
              children: [
                SizedBox(height: 80.0,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Recover Password',
                      style:TextStyle(
                        fontWeight: FontWeight.bold ,
                        fontSize: 40.0,
                        color: Colors.white,
                      ) ,)

                  ],
                ),
                SizedBox(height: 10.0,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children:[
                    Text('Please enter your Email to Reset the Password',
                    style:TextStyle(
                      fontWeight: FontWeight.bold ,
                      fontSize: 15.0,
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
              color: darkMode?Colors.black:Colors.white,
              borderRadius: BorderRadius.circular(65.0,),
            ),
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: SingleChildScrollView(
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      const SizedBox(height: 40.0,),
                      // text field for phone number
                      TextFormField(
                        controller: _emailContoller,

                        decoration: const InputDecoration(
                          labelText:'Email Address',
                          labelStyle: TextStyle(
                            fontSize: 25.0,
                          ),
                          prefixIcon: Icon(
                            Icons.email,
                          ),
                          border: OutlineInputBorder(),
                        ),
                        textAlign: TextAlign.start,
                        keyboardType: TextInputType.emailAddress,
                        onFieldSubmitted: (value){
                        },
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Email is required';
                          }
                          return null;
                        },

                      ),
                      const SizedBox(height: 20.0,),
                      const SizedBox(height: 10.0,),
                      const SizedBox(height: 20.0,),
                      Container(
                          width: double.infinity,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20.0,),
                            color: const Color(0xff1A5D1A),
                          ),
                          child: MaterialButton(

                            child: const Text(

                              'Continue',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 20.0,
                              ),
                            ),

                            onPressed: (){
                              if (_formKey.currentState!.validate()) {
                                _forgetPassword();
                              }

                            },)),
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
