
import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';


import '../../TColors.dart';
import '../../apis/user/http_service_regstration.dart';
import '../../network/local/cache_helper.dart';
import '../../translations/locale_keys.g.dart';
import 'Login.dart';

class SignUp extends StatefulWidget {

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final _nameContoller = TextEditingController();

  final _emailContoller = TextEditingController();

  final _phoneContoller = TextEditingController();


  final _passwordContoller = TextEditingController();

  final _confirmPasswordContoller = TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final HttpServiceRegstration httpService = HttpServiceRegstration();

  bool isLoading = false;

  String errorMessage = '';
  bool? darkMode = false;
  void initState(){
    super.initState();
    darkMode = CacheHelper.getData(key: 'darkMode');
    if (darkMode == null)
      darkMode = false ;
  }
  void _registerUser() async {
    // Reset error message and loading state
    setState(() {
      errorMessage = '';
      isLoading = true;
    });

    try {
      // Add your validation logic here
      print('inside the function of register {{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{');
      if (_passwordContoller.text != _confirmPasswordContoller.text) {
        // Passwords don't match
        throw ('Passwords do not match');
      }


      // Add your registration logic here, e.g., make API call
      await httpService.registerUser(
          _nameContoller.text,
          _emailContoller.text,
          _phoneContoller.text,
          _passwordContoller.text,
          _confirmPasswordContoller.text
      );
      // Registration successful, you can navigate to another screen or show a success message
      Fluttertoast.showToast(
        msg: "Registration successful!",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 5,
        backgroundColor: Colors.green,
        textColor: Colors.white,
        fontSize: 16.0,
      );
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: _emailContoller.text,
          password:  _passwordContoller.text).then((value) => print("ok")).
      onError((error, stackTrace) => ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(error.toString())) ));

      Navigator.of(context).pushReplacement(MaterialPageRoute
        (builder: (context)=>Login()));
      print('Registration successful!');
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
          msg: "Registration Field!",
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
      backgroundColor:TColors.primary,
      body:ListView(
        children: [
          SizedBox(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height/8.0,
            child:  Column(
              children: [
                SizedBox(height: 30.0,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(LocaleKeys.RegisterSignUp.tr(),
                      style:TextStyle(
                        fontWeight: FontWeight.bold ,
                        fontSize: 40.0,
                        color: Colors.white,
                      ) ,)
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
                      //this text field for name
                      TextFormField(
                        controller: _nameContoller,
                        decoration:  InputDecoration(
                          labelText:'${LocaleKeys.RegisterName.tr()}',
                          labelStyle: TextStyle(
                            fontSize: 25.0,
                          ),
                          border: OutlineInputBorder(),
                          prefixIcon: Icon(
                            Icons.account_circle,
                          ),
                        ),
                        textAlign: TextAlign.start,
                        keyboardType: TextInputType.name,
                        onFieldSubmitted: (value){
                        },

                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return '${LocaleKeys.RegisterNameisrequired.tr()}';
                          }
                          return null;
                        },

                      ),
                      const SizedBox(height: 20.0,),
                      // this text field for email
                      TextFormField(
                        controller: _emailContoller,
                        decoration:  InputDecoration(
                          labelText:'${LocaleKeys.RegisterEmailAddress.tr()}',
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
                            return '${LocaleKeys.RegisterEmailisrequired.tr()}';
                          }
                          return null;
                        },

                      ),
                      const SizedBox(height: 20.0,),
                      // this text field for phone number
                      TextFormField(
                        controller: _phoneContoller,
                        decoration:  InputDecoration(
                          labelText:'${LocaleKeys.RegisterPhoneNumber.tr()}',
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
                            return '${LocaleKeys.RegisterPhoneisrequired.tr()}';
                          }
                          return null;
                        },

                      ),
                      const SizedBox(height: 20.0,),
                      // this text field for Password
                      TextFormField(
                        controller: _passwordContoller,
                        decoration:  InputDecoration(
                          labelText:'${LocaleKeys.RegisterPassword.tr()}',
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
                          labelText:'${LocaleKeys.RegisterConfirmPassword.tr()}',
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

                            child:  Text(

                              LocaleKeys.RegisterSignUp.tr(),
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 20.0,
                              ),
                            ),

                            onPressed: isLoading ? null :() {
                              if (_formKey.currentState!.validate()) {
                                _registerUser();
                              }
                            } ,

                          )
                      ),
                      const SizedBox(height: 10.0,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                           Text(LocaleKeys.RegisterAlreadyhaveanaccount.tr(),style:
                          TextStyle(
                            fontSize: 15.0,
                          ),),
                          GestureDetector(
                            onTap: (){

                              Navigator.push(context, MaterialPageRoute(builder: (context){
                                return Login();
                              }));
                            },
                            child:  Text(LocaleKeys.RegisterSignin.tr(),style:
                            TextStyle(
                                fontSize: 15.0,
                                color: Colors.blue
                            ),
                            ),
                          ),
                        ],
                      ),
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
    );
  }
}
