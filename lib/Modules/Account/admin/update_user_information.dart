import 'package:drop_down_list/model/selected_list_item.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../../../Layout/Login_Register_ForgetPassword/DropDownList/dropDownList.dart';
import '../../../apis/admin/http_service_admin.dart';
import '../../../network/local/cache_helper.dart';
import 'package:easy_localization/easy_localization.dart';

import '../../../translations/locale_keys.g.dart';

class UpdateUser extends StatefulWidget {
   final String userId ;

  const UpdateUser({super.key, required this.userId});
  @override
  State<UpdateUser> createState() => _UpdateUserState();
}

class _UpdateUserState extends State<UpdateUser> {
  final _nameContoller = TextEditingController();

  final _emailContoller = TextEditingController();


  final _statusContoller = TextEditingController();


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
  void _updateUser(String userId) async {
    // Reset error message and loading state
    setState(() {
      errorMessage = '';
      isLoading = true;
    });

    try {
      // Add your validation logic here
      print('inside the function of register {{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{');

      // Add your add new user logic here, e.g., make API call
      await httpServiceAdmin.updateUser(
        _nameContoller.text,
        _emailContoller.text,
        _statusContoller.text,
        CacheHelper.getData(key: 'token'),
          userId
      );
      // add new user successful, you can navigate to another screen or show a success message
      Fluttertoast.showToast(
        msg: "update user successful!",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 5,
        backgroundColor: Colors.green,
        textColor: Colors.white,
        fontSize: 16.0,
      );
      print('update user successful!');
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
                    //this text field for name
                    TextFormField(
                      controller: _nameContoller,
                      decoration: InputDecoration(
                        labelText:'${LocaleKeys.AdminUpdataUserInformationName.tr()}',
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
                    AppTextField(
                      isFromInstructo: true,
                      data: [
                        SelectedListItem(name:'${LocaleKeys.AdminUpdataUserInformationRoles1.tr()}' ),
                        SelectedListItem(name:'${LocaleKeys.AdminUpdataUserInformationRoles2.tr()}' ),
                        SelectedListItem(name:'${LocaleKeys.AdminUpdataUserInformationRoles3.tr()}' ),
                      ],
                      textEditingController: _statusContoller,
                      title: 'Select Status',
                      hint: 'status',
                      isDataSelected: true,
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

                            '${LocaleKeys.AdminUpdataUserInformationUpdateUser.tr()}',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 20.0,
                            ),
                          ),

                          onPressed: isLoading ? null :() {
                            if (_formKey.currentState!.validate()) {
                            _updateUser(widget.userId);
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
