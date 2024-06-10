import 'package:firebase_auth/firebase_auth.dart';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:learning/Layout/MainBottomNavigationBar.dart';
import 'package:learning/TColors.dart';
import 'package:learning/shared/constant.dart';
import '../../apis/user/http_service_get_user_data.dart';
import '../../apis/user/http_service_login.dart';
import '../../chat/firebase/fire_auth.dart';
import '../../chat/firebase/fire_database.dart';
import '../../network/local/cache_helper.dart';
import '../../translations/locale_keys.g.dart';
import 'ForgetPassword/ForgetPassword.dart';
import 'Register.dart';
import 'onboarding.dart';
const Color kPrimaryColor = Color(0x001c7c44);
class Login extends StatefulWidget {
  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final _emailContoller = TextEditingController();

  final _passwordContoller = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final HttpServiceLogin httpService = HttpServiceLogin();
  final HttpServiceGetData httpServiceGetData = HttpServiceGetData();

  bool isLoading = false;
  bool? darkMode = false;
  void initState(){
    super.initState();
    darkMode = CacheHelper.getData(key: 'darkMode');
    if (darkMode == null)
      darkMode = false ;
  }
  String errorMessage = '';
  void _loginUser() async {
    // Reset error message and loading state
    setState(() {
      errorMessage = '';
      isLoading = true;
    });

    try {
      // Add your login logic here, e.g., make API call
      await httpService.loginUser(
        _emailContoller.text,
        _passwordContoller.text,
      );

      // Login successful, you can navigate to another screen or show a success message
      // ...

      // Fetch data and wait for it to complete
      await fetchData();
      Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => HomeLayout()));

      // Now navigate to the appropriate screen based on the fetched data
     // bool? onBoarding = CacheHelper.getBool(key: 'onBoarding');
      /*if (onBoarding != null && onBoarding) {
        Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => HomeLayout()));
      } else {
        Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => Onboarding()));
      }
*/
      print('Login successful!');
    } catch (e) {
      // Handle validation errors or network errors
      setState(() {
        errorMessage = 'Error: $e';
        if (errorMessage.contains('422')) {
          // Your code here
          errorMessage ="Email and Password are Required!";
        }
        else if (errorMessage.contains('401')) {
          // Your code here
          errorMessage =" Invalid Email or Password!";
        }
        else if (errorMessage.contains('500')) {
          // Your code here
          errorMessage =" Server Not Available Now !";
        }
        else{
          errorMessage ="Unexpected Error!";
        }
        Fluttertoast.showToast(
          msg: "Login Field!",
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

  Future<void> fetchData() async {
    try {
      String? token = CacheHelper.getData(key:'token');
      // Call getData method with the authentication token
      Map<String, dynamic> data = await httpServiceGetData.getData(token!);

      if (mounted) {
        // Update the state with the fetched data
        setState(() {
          getData = data;
        });
      }
      // Print or use the fetched data as needed

    } catch (e) {
      // Handle errors, if any
      print('Error fetching data: $e');
    }
  }
  @override
  bool obscureText = true;
  bool obscure = true;
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: TColors.primary,
      body: SafeArea(
        child: ListView(
          children: [
            SizedBox(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height / 2.5,
              child: Expanded(
                child:  Column(
                  children: [
                    CircleAvatar(
                      radius: 65.0,
                      backgroundColor: darkMode!?Colors.black:Colors.white,
                      child: Image(
                        image: AssetImage('assets/images/app_icon/icons.png'),
                        height: 100.0,
                        width: 100.0,
                      ),
                    ),
                    SizedBox(height: 20.0,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          LocaleKeys.LoginLetslearn.tr(),
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 40.0,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 10.0,),
                    Text(
                      LocaleKeys.LoginSignintocontinue.tr(),
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20.0,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              decoration: BoxDecoration(
                color: darkMode!?Colors.black:Colors.white,
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
                        TextFormField(
                          controller: _emailContoller,
                          decoration:  InputDecoration(
                            labelText: '${LocaleKeys.LoginEmailAddress.tr()}',
                            labelStyle: TextStyle(
                              fontSize: 25.0,
                            ),
                            prefixIcon: Icon(
                              Icons.email,
                            ),
                            border: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors.blue,
                              ),
                            ),
                          ),
                          textAlign: TextAlign.start,
                          keyboardType: TextInputType.emailAddress,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return '${LocaleKeys.LoginEmailisrequired.tr()}';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 20.0,),
                        TextFormField(
                          controller: _passwordContoller,
                          decoration: InputDecoration(
                            labelText: '${LocaleKeys.LoginPassword.tr()}',
                            labelStyle: TextStyle(
                              fontSize: 25.0,
                            ),
                            prefixIcon: Icon(
                              Icons.lock,
                            ),
                            suffixIcon: IconButton(
                              icon: Icon(
                                obscureText
                                    ? Icons.visibility_off
                                    : Icons.visibility,
                                color: darkMode!?Colors.white:Colors.grey,
                              ),
                              onPressed: () {
                                setState(() {
                                  obscureText = !obscureText;
                                }

                                );
                              },
                            ),
                            border: OutlineInputBorder(),
                          ),
                          keyboardType: TextInputType.visiblePassword,
                          obscureText: obscure ? obscureText : false,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return '${LocaleKeys.RegisterPasswordisrequired.tr()}';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 10.0,),
                        Align(
                          alignment: Alignment.bottomRight,
                          child: GestureDetector(
                            onTap: () {
                              errorMessage = "";
                              _emailContoller.text = "";
                              _passwordContoller.text = "";

                              Navigator.push(context, MaterialPageRoute(builder: (context){
                                return ForgetPassword();
                              }));
                            },
                            child:  Text(
                              LocaleKeys.LoginForgetPassword.tr(),
                              style: TextStyle(
                                fontSize: 15.0,
                                color: Colors.blue,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 20.0,),
                        Container(
                          width: double.infinity,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20.0,),
                            color: TColors.secondray,
                          ),
                          child: MaterialButton(
                            child:  Text(
                              LocaleKeys.LoginSignin.tr(),
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 20.0,
                              ),
                            ),
                            onPressed: isLoading
                                ? null
                                : () {
                              if (_formKey.currentState!.validate()) {
                                _loginUser();
                              }
                            },
                          ),
                        ),
                        const SizedBox(height: 10.0,),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                             Text(
                               LocaleKeys.LoginDonthaveanaccount.tr(),
                              style: TextStyle(
                                fontSize: 15.0,
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                _emailContoller.text = "";
                                _passwordContoller.text = "";

                                Navigator.push(context, MaterialPageRoute(builder: (context){
                                  return SignUp();
                                }));
                                errorMessage = "";
                              },
                              child:  Text(
                                LocaleKeys.RegisterSignUp.tr(),
                                style: TextStyle(
                                  fontSize: 15.0,
                                  color: Colors.blue,
                                ),
                              ),
                            ),
                          ],
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
            ),
          ],
        ),
      ),
    );
  }
}
