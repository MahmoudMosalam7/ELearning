
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:learning/Layout/Login_Register_ForgetPassword/Login.dart';

import '../../../TColors.dart';
import '../../../apis/forget_password/http_service_reset_password.dart';
import '../../../network/local/cache_helper.dart';

class ResetPassword extends StatefulWidget {
  String email;
  ResetPassword({required this.email});
  @override
  State<ResetPassword> createState() => _ResetPasswordState();
}

class _ResetPasswordState extends State<ResetPassword> {
  final _passwordContoller = TextEditingController();

  final _confirmPasswordContoller = TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final HttpServiceResetPassword httpService = HttpServiceResetPassword();
  bool isLoading = false;

  String errorMessage = '';
  bool darkMode = false;
  void initState(){
    super.initState();
    darkMode = CacheHelper.getData(key: 'darkMode');
  }
  void _resetPassword() async {
    // Reset error message and loading state
    setState(() {
      errorMessage = '';
      isLoading = true;
    });

    try {

      print('from api email = ${widget.email}');
      print('from api password = ${_passwordContoller.text}');
      print('from api passwordConfirm = ${_confirmPasswordContoller.text}');
      // Add your login logic here, e.g., make API call
      await httpService.resetPassword(
        _passwordContoller.text,
        _confirmPasswordContoller.text,
        widget.email,
      );

      // Login successful, you can navigate to another screen or show a success message
      //Get.to(const HomeLayout());
      errorMessage = "";
      Fluttertoast.showToast(
        msg: "Reset Successfully",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 5,
        backgroundColor: Colors.green,
        textColor: Colors.white,
        fontSize: 16.0,
      );

      Get.to(Login());

      print(' successful!');
    } catch (e) {
      // Handle validation errors or network errors
      setState(() {
        errorMessage = 'Error: $e';
        if (errorMessage.contains('404')) {
          // Your code here
          errorMessage ="Email Not Found!";
        }else if (errorMessage.contains('400')) {
          // Your code here
          errorMessage ="Code Expired!";
        }
        else if (errorMessage.contains('422')) {
          // Your code here
          errorMessage ="InValid Passwords!";
        }
        else{
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
  bool obscureText1 = true;

  bool obscure1 = true;

  bool obscureText2 = true;

  bool obscure2 = true;

  Widget build(BuildContext context) {
    return   Scaffold(
      backgroundColor:TColors.primary,
      body:  ListView(
        children: [
          SizedBox(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height/4.0,
            child: const Column(
              children: [
                SizedBox(height: 80.0,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Reset Password',
                      style:TextStyle(
                        fontWeight: FontWeight.bold ,
                        fontSize: 40.0,
                        color: Colors.white,
                      ) ,)
                  ],
                ),
                SizedBox(height: 10.0,),

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
                      const SizedBox(height: 50.0,),
                      // text field for email
                      // this text field for Password
                      TextFormField(
                        controller: _passwordContoller,
                        decoration: InputDecoration(
                          labelText:'New Password',
                          labelStyle: TextStyle(
                            fontSize: 25.0,
                          ),
                          prefixIcon: Icon(
                            Icons.lock,
                          ),
                          suffixIcon: IconButton(
                            icon: Icon(
                              obscureText1 ? Icons.visibility_off : Icons.visibility,
                              color: Colors.black,
                            ),
                            onPressed: () {
                              setState(() {
                                obscureText1 = !obscureText1;
                              });
                            },
                          ),
                          border: OutlineInputBorder(),
                        ),
                        keyboardType: TextInputType.visiblePassword,
                        obscureText: obscure1 ? obscureText1 : false,
                        onFieldSubmitted: (value){
                        },
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'New Password is required';
                          }
                          return null;
                        },


                      ),
                      const SizedBox(height: 30.0,),
                      // this text field for Confirm Password
                      TextFormField(
                        controller: _confirmPasswordContoller,
                        decoration:  InputDecoration(
                          labelText:'Confirm Password',
                          labelStyle: TextStyle(
                            fontSize: 25.0,
                          ),
                          prefixIcon: Icon(
                            Icons.lock,
                          ),
                          suffixIcon: IconButton(
                            icon: Icon(
                              obscureText2 ? Icons.visibility_off : Icons.visibility,
                              color: Colors.black,
                            ),
                            onPressed: () {
                              setState(() {
                                obscureText2 = !obscureText2;
                              });
                            },
                          ),
                          border: OutlineInputBorder(),
                        ),
                        keyboardType: TextInputType.visiblePassword,
                        obscureText: obscure2 ? obscureText2 : false,
                        onFieldSubmitted: (value){
                        },
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Confirm Password is required';
                          }
                          return null;
                        },


                      ),
                      const SizedBox(height: 40.0,),
                      Container(
                          width: double.infinity,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20.0,),
                            color: const Color(0xff1A5D1A),
                          ),
                          child: MaterialButton(

                            child: const Text(
                              'Reset',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 20.0,
                              ),
                            ),

                            onPressed: (){
                              if (_formKey.currentState!.validate()) {
                                _resetPassword();
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
