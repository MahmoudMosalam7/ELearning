import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:learning/Layout/Login_Register_ForgetPassword/Login.dart';
import 'package:learning/Modules/Account/admin/admin_home.dart';
import 'package:learning/Modules/Account/setting/setting.dart';
import 'package:learning/Modules/Account/videoPlay.dart';
import 'package:learning/TColors.dart';
import 'package:learning/shared/constant.dart';

import '../../apis/user/http_service_logout.dart';
import '../../network/local/cache_helper.dart';
import 'become_an_instructor/Instructor_page/instructor_home_page.dart';
import 'become_an_instructor/onboarding_instructor/on_bording_instructor_screen.dart';
import 'download_option.dart';
import 'edit_profile/editAccount.dart';
import 'lerningreminder.dart';

class AccountScreen extends StatefulWidget {
  const AccountScreen({super.key});

  @override
  State<AccountScreen> createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> {
  HttpServiceLogout httpServiceLogout = HttpServiceLogout();
  bool isLoading = false;
  String errorMessage = '';
  void _logout() async {
    // Reset error message and loading state
    setState(() {
      errorMessage = '';
      isLoading = true;
    });

    try {


      // Check if _profileImage is not null before calling updateMe

      print(']]]]]]]]]]]]]]]]]]]]]from logout ');
      await httpServiceLogout.logoutUser(
        CacheHelper.getData(key: 'token'),
      );


      errorMessage = "";
      Fluttertoast.showToast(
        msg: "logout Success",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 5,
        backgroundColor: Colors.green,
        textColor: Colors.white,
        fontSize: 16.0.sp,
      );
      try{
        bool? token =  await CacheHelper.removeData(key: 'token');
        if(token){
          Navigator.of(context).push(MaterialPageRoute(builder: (context) => Login()));
        }
      }catch(e){
        print('error when sign out = ]]]]]]]]]]]]]$e');
      }
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
    return     Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text(
          "Account",
          style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 20.0
          ),
        ),
        actions: [
          MaterialButton(onPressed: (){},
            child:  CircleAvatar(
              radius: 25.0,
              backgroundColor: Colors.grey,
              child: Icon(
                Icons.shopping_cart,
                size: 30.0,
              ),
            ),

          )
        ],
      ),
      body: Center(
        child: Container(
          padding: EdgeInsets.all(20.0),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Column(
                  crossAxisAlignment:CrossAxisAlignment.center ,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(color: TColors.Ternary, width: 2.0),
                      ),
                      child: CircleAvatar(
                        backgroundColor: Colors.white,
                        radius: 70.0,
                        backgroundImage: NetworkImage( getData?['data']['profileImage'] ?? 'assets/images/profile.jpg',),
                        child: getData?['data']['profileImage'] == null
                            ? ClipOval(
                          child: Image.asset(
                            'assets/images/profile.jpg',
                            width: 140.0, // Set width to match the diameter of the CircleAvatar
                            height: 140.0, // Set height to match the diameter of the CircleAvatar
                            fit: BoxFit.cover,
                          ),
                        )
                            : null,
                      ),
                    ),
                    SizedBox(height: 15.0,),
                    Text(getData?['data']['name'],
                      maxLines: 1,
                      overflow:TextOverflow.ellipsis,
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize:25.0
                      ),
                    ),
                    SizedBox(height: 15.0,),
                    Row(
                      children: [
                        SizedBox(width: 40.0,),
                        Icon(Icons.email_sharp,size: 18,),
                        SizedBox(width: 2.0,),
                        Text(getData?['data']['email'],)
                      ],
                    ),
                  ],
                ),
                SizedBox(height: 15.0,),
                TextButton(onPressed: (){
                  Get.to(OnBordingInstructorScreen());
                },
                    child:
                    Text(
                      "Become an instructor ",
                      style: TextStyle(

                          color: TColors.Ternary
                      ),
                    )
                ),
                SizedBox(height: 15.0,),
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Video prefernce",
                      style: TextStyle(
                          fontSize: 13.0,
                          color: Colors.grey[600]
                      ),),
                    MaterialButton(
                      onPressed: (){
                        Get.to(Download_option());
                      },
                      child:
                      Container(
                        width: double.infinity,
                        child: Row(
                          children: [
                            Text("download option"
                              ,style: TextStyle(
                                  fontSize: 17.0
                              ),),
                            Spacer(flex: 1,),
                            Icon(Icons.keyboard_arrow_right),
                          ],
                        ),
                      ),

                    ),
                    SizedBox(height: 1.0,),
                    MaterialButton(
                      onPressed: (){
                        /**************************************** */
                        Navigator.push(context, MaterialPageRoute(builder: (context)=>VideoPlay()));
                      },
                      child:
                      Container(
                        width: double.infinity,
                        child: Row(/******************************************* */
                          children: [
                            Text("video play back option"
                              ,style: TextStyle(
                                  fontSize: 17.0
                              ),),
                            Spacer(flex: 1,),
                            Icon(Icons.keyboard_arrow_right),
                          ],
                        ),
                      ),

                    ),
                  ],
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("account setting ",
                      style: TextStyle(
                          fontSize: 13.0,
                          color: Colors.grey[600]
                      ),),
                    MaterialButton(
                      onPressed: (){
                        Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context)=>EditAccount()));
                      },
                      child:
                      Container(
                        width: double.infinity,
                        child: Row(
                          children: [
                            Text("edit profile"
                              ,style: TextStyle(
                                  fontSize: 17.0
                              ),
                            ),
                            Spacer(flex: 1,),
                            Icon(Icons.keyboard_arrow_right),
                          ],
                        ),
                      ),

                    ),

                    SizedBox(height: 1.0,),
                    MaterialButton(
                      onPressed: (){},
                      child:
                      Container(
                        width: double.infinity,
                        child: Row(
                          children: [
                            Text("email notfication"
                              ,style: TextStyle(
                                  fontSize: 17.0
                              ),),
                            Spacer(flex: 1,),
                            Icon(Icons.keyboard_arrow_right),
                          ],
                        ),
                      ),

                    ),
                    MaterialButton(
                      onPressed: (){
                        Get.to(LerningReminder());
                      },
                      child:
                      Container(
                        width: double.infinity,
                        child: Row(
                          children: [
                            Text("learnig reminders"
                              ,style: TextStyle(
                                  fontSize: 17.0
                              ),),
                            Spacer(flex: 1,),
                            Icon(Icons.keyboard_arrow_right),
                          ],
                        ),
                      ),

                    ),
                  ],
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("help and support ",
                      style: TextStyle(
                          fontSize: 13.0,
                          color: Colors.grey[600]
                      ),),
                    MaterialButton(
                      onPressed: (){},
                      child:
                      Container(
                        width: double.infinity,
                        child: Row(
                          children: [
                            Text("about E_Learning"
                              ,style: TextStyle(
                                  fontSize: 17.0
                              ),),
                            Spacer(flex: 1,),
                            Icon(Icons.keyboard_arrow_right),
                          ],
                        ),
                      ),

                    ),

                    MaterialButton(
                      onPressed: (){},
                      child:
                      Container(
                        width: double.infinity,
                        child: Row(
                          children: [
                            Text("share E_Learning app"
                              ,style: TextStyle(
                                  fontSize: 17.0
                              ),),
                            Spacer(flex: 1,),
                            Icon(Icons.keyboard_arrow_right),
                          ],
                        ),
                      ),

                    ),
                    MaterialButton(
                      onPressed: (){
                        Get.to(Setting());
                      },
                      child:
                      Container(
                        width: double.infinity,

                        child: Row(
                          children: [
                            Text("setting"
                              ,style: TextStyle(
                                  fontSize: 17.0
                              ),),
                            Spacer(flex: 1,),
                            Icon(Icons.keyboard_arrow_right),
                          ],
                        ),
                      ),

                    ),
                  ],
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("instructor",
                      style: TextStyle(
                          fontSize: 13.0,
                          color: Colors.grey[600]
                      ),),
                    MaterialButton(
                      onPressed: (){
                        Get.to(InstructorHomeScreen());
                      },
                      child:
                      Container(
                        width: double.infinity,
                        child: Row(

                          children: [
                            Text("Add Course"
                              ,style: TextStyle(
                                  fontSize: 17.0
                              ),),
                            Spacer(flex: 1,),
                            Icon(Icons.keyboard_arrow_right),
                          ],
                        ),
                      ),

                    ),
                    SizedBox(height: 5,),
                    MaterialButton(
                      onPressed: (){
                        Get.to(AdminHome());
                      },
                      child:
                      Container(
                        width: double.infinity,
                        child: Row(

                          children: [
                            Text("Admin"
                              ,style: TextStyle(
                                  fontSize: 17.0
                              ),),
                            Spacer(flex: 1,),
                            Icon(Icons.keyboard_arrow_right),
                          ],
                        ),
                      ),

                    ),
                  ],
                ),
                TextButton(onPressed: ()async{
                  _logout();
                },
                    child:
                    Text(
                      "sign out ",
                      style: TextStyle(
                          color: TColors.Ternary
                      ),
                    )
                ),
                SizedBox(height: 15.0,),
                Text("E_Learning v2.16.0",
                  style: TextStyle(

                      fontSize: 10.0
                  ),
                ),
              ],
            ),
          ),
        ),
      ) ,

    );
  }


}
