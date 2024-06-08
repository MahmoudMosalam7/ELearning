import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:easy_localization/easy_localization.dart';
import '../../../apis/user/http_service_update_password.dart';
import '../../../network/local/cache_helper.dart';
import '../../../translations/locale_keys.g.dart';

class Acount_Security extends StatefulWidget{
  @override
  State<Acount_Security> createState() => _Acount_SecurityState();
}

class _Acount_SecurityState extends State<Acount_Security> {
  final _passwordContoller = TextEditingController();
  final _oldPasswordContoller = TextEditingController();

  final _confirmPasswordContoller = TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  bool obscureText1 = true;

  bool obscure1 = true;

  bool obscureText2 = true;

  bool obscure2 = true;

  bool obscureText3 = true;

  bool obscure3 = true;

  bool isLoading = false;
  bool darkMode = false;
  void initState(){
    super.initState();
    darkMode = CacheHelper.getData(key: 'darkMode');
  }
  String errorMessage = '';


  HttpServiceUpdatePassword httpServiceUpdatePassword = HttpServiceUpdatePassword();
  void _updatePassword() async {
    // Reset error message and loading state
    setState(() {
      errorMessage = '';
      isLoading = true;
    });

    try {


      // Check if _profileImage is not null before calling updateMe

      print(']]]]]]]]]]]]]]]]]]]]]from update ');
      await httpServiceUpdatePassword.updateUserPassword(
        _oldPasswordContoller.text,
        _passwordContoller.text,
        _confirmPasswordContoller.text,
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
        if (errorMessage.contains('422')) {
          // Your code here
          errorMessage ="Valdition Error!";
        }
        else if (errorMessage.contains('401')) {
          // Your code here
          errorMessage =" unauthorized access !";
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

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text(LocaleKeys.AcountSecurityTitle.tr()),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child:   SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                TextFormField(
                  controller: _oldPasswordContoller,
                  decoration:  InputDecoration(
                    labelText:'${LocaleKeys.AcountSecurityoldPassword.tr()}',
                    labelStyle: TextStyle(
                      fontSize: 25.0,
                    ),
                    prefixIcon: Icon(
                      Icons.lock,
                    ),
                    suffixIcon: IconButton(
                      icon: Icon(
                        obscureText3 ? Icons.visibility_off : Icons.visibility,
                        color: darkMode?Colors.white:Colors.grey,
                      ),
                      onPressed: () {
                        setState(() {
                          obscureText3 = !obscureText3;
                        });
                      },
                    ),
                    border: OutlineInputBorder(),
                  ),
                  keyboardType: TextInputType.visiblePassword,
                  obscureText: obscure2 ? obscureText3 : false,
                  onFieldSubmitted: (value){
                  },
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return '${LocaleKeys.AcountSecurityOldPasswordisrequired.tr()}';
                    }
                    return null;
                  },

                ),
                const SizedBox(height: 20.0,),
                // this text field for Password
                TextFormField(
                  controller: _passwordContoller,
                  decoration:  InputDecoration(
                    labelText:'${LocaleKeys.AcountSecurityNewPassword.tr()}',
                    labelStyle: TextStyle(
                      fontSize: 25.0,
                    ),
                    prefixIcon: Icon(
                      Icons.lock,
                    ),
                    suffixIcon: IconButton(
                      icon: Icon(
                        obscureText1 ? Icons.visibility_off : Icons.visibility,
                        color: darkMode?Colors.white:Colors.grey,
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
                      return '${LocaleKeys.AcountSecurityNewPasswordisrequired.tr()}';
                    }
                    return null;
                  },

                ),
                const SizedBox(height: 20.0,),
                // this text field for Confirm Password
                TextFormField(
                  controller: _confirmPasswordContoller,
                  decoration: InputDecoration(
                    labelText:'${LocaleKeys.AcountSecurityConfirmNewPassword.tr()}',
                    labelStyle: TextStyle(
                      fontSize: 25.0,
                    ),
                    prefixIcon: Icon(
                      Icons.lock,
                    ),
                    suffixIcon: IconButton(
                      icon: Icon(
                        obscureText2 ? Icons.visibility_off : Icons.visibility,
                        color: darkMode?Colors.white:Colors.grey,
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
                      return '${LocaleKeys.AcountSecurityConfirmNewPasswordisrequired.tr()}';
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

                      child:  Text(

                        '${LocaleKeys.AcountSecurityUpdatePassword.tr()}',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20.0,
                        ),
                      ),

                      onPressed: isLoading ? null :() {
                        if (_formKey.currentState!.validate()) {
                          _updatePassword();
                        }
                      } ,

                    )
                ),

              ],
            ),
          ),
        ),
      ),
    )
    ;
  }
}