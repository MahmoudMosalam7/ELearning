import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../../../apis/admin/http_service_admin.dart';
import '../../../network/local/cache_helper.dart';
import 'package:easy_localization/easy_localization.dart';

import '../../../translations/locale_keys.g.dart';

class UpdateUserPassword extends StatefulWidget {
   final String userId;

  const UpdateUserPassword({super.key, required this.userId});
  @override
  State<UpdateUserPassword> createState() => _AddUserState();
}

class _AddUserState extends State<UpdateUserPassword> {

  final _passwordContoller = TextEditingController();

  final _confirmPasswordContoller = TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final HttpServiceAdmin httpServiceAdmin = HttpServiceAdmin();

  bool isLoading = false;

  String errorMessage = '';
  bool? darkMode = false;
  void initState(){
    super.initState();
    darkMode = CacheHelper.getData(key: 'darkMode');
    if (darkMode == null)
      darkMode = false ;
  }
  void _updateUserPassword() async {
    // Reset error message and loading state
    setState(() {
      errorMessage = '';
      isLoading = true;
    });

    try {
      // Add your validation logic here
      print('inside the function of update user id {{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{');
      if (_passwordContoller.text != _confirmPasswordContoller.text) {
        // Passwords don't match
        throw ('Passwords do not match');
      }


      // Add your add new user logic here, e.g., make API call
      await httpServiceAdmin.updateUserPassword(

        _passwordContoller.text,
        _confirmPasswordContoller.text,
        CacheHelper.getData(key: 'token'),
        widget.userId
      );
      // add new user successful, you can navigate to another screen or show a success message
      Fluttertoast.showToast(
        msg: "update user password successful!",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 5,
        backgroundColor: Colors.green,
        textColor: Colors.white,
        fontSize: 16.0,
      );
      print('update user password successful!');
    } catch (e) {
      // Handle validation errors or network errors
      setState(() {
        errorMessage = 'Error: $e';
        if (errorMessage.contains('400')) {
          // Your code here
          errorMessage ="All Fields are Required!";
        }
        else if (errorMessage.contains('409')) {
          // Your code here
          errorMessage ="This Email Already Used!";
        }
        else if (errorMessage.contains('500')) {
          // Your code here
          errorMessage =" Server Not Available Now !";
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

  bool obscureText1 = true;
  bool obscure1 = true;
  bool obscureText2 = true;
  bool obscure2 = true;
  Widget build(BuildContext context) {
    return Scaffold(
      body:ListView(
        children: [

          Padding(
            padding: const EdgeInsets.all(20.0),
            child: SingleChildScrollView(
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    const SizedBox(height: 40.0,),

                    const SizedBox(height: 20.0,),
                    // this text field for Password
                    TextFormField(
                      controller: _passwordContoller,
                      decoration:  InputDecoration(
                        labelText:'${LocaleKeys.AdminUpdateUserPasswordPassword.tr()}',
                        labelStyle: TextStyle(
                          fontSize: 25.0,
                        ),
                        prefixIcon: Icon(
                          Icons.lock,
                        ),
                        suffixIcon: IconButton(
                          icon: Icon(
                            obscureText1 ? Icons.visibility_off : Icons.visibility,
                            color: darkMode!?Colors.white:Colors.grey,
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
                          return '${LocaleKeys.RegisterPasswordisrequired.tr()}';
                        }
                        return null;
                      },

                    ),
                    const SizedBox(height: 20.0,),
                    // this text field for Confirm Password
                    TextFormField(
                      controller: _confirmPasswordContoller,
                      decoration: InputDecoration(
                        labelText:'${LocaleKeys.AdminUpdateUserPasswordConfirmPassword.tr()}',
                        labelStyle: TextStyle(
                          fontSize: 25.0,
                        ),
                        prefixIcon: Icon(
                          Icons.lock,
                        ),
                        suffixIcon: IconButton(
                          icon: Icon(
                            obscureText2 ? Icons.visibility_off : Icons.visibility,
                            color: darkMode!?Colors.white:Colors.grey,
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
                          return '${LocaleKeys.RegisterConfirmPasswordisrequired.tr()}';
                        }
                        return null;
                      },

                    ),
                    const SizedBox(height: 20.0,),
                    Container(
                        width: double.infinity,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20.0,),
                          color: const Color(0xff1A5D1A),
                        ),
                        child: MaterialButton(

                          child: Text(

                            '${LocaleKeys.AdminUpdateUserPasswordUpdateUserPassword.tr()}',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 20.0,
                            ),
                          ),

                          onPressed: isLoading ? null :() {
                            if (_formKey.currentState!.validate()) {
                              _updateUserPassword();
                            }
                          } ,

                        )
                    ),
                    const SizedBox(height: 10.0,),
                    if (isLoading) CircularProgressIndicator(),
                    if (errorMessage.isNotEmpty)
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          errorMessage,
                          style: TextStyle(color: Colors.red),
                        ),
                      ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
