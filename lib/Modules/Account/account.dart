import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'package:http/http.dart' as http;
import 'package:learning/Layout/Login_Register_ForgetPassword/Login.dart';
import 'package:learning/Modules/Account/admin/admin_home.dart';
import 'package:learning/Modules/Account/qualty.dart';
import 'package:learning/Modules/Account/setting/setting.dart';
import 'package:learning/TColors.dart';
import 'package:learning/shared/constant.dart';
import 'package:lottie/lottie.dart';

import 'package:easy_localization/easy_localization.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';
import 'package:shimmer/shimmer.dart';
import '../../apis/user/http_service_get_user_data.dart';
import '../../apis/user/http_service_logout.dart';
import '../../network/local/cache_helper.dart';
import '../../translations/locale_keys.g.dart';
import 'become_an_instructor/Instructor_page/instructor_home_page.dart';
import 'become_an_instructor/onboarding_instructor/on_bording_instructor_screen.dart';
import 'edit_profile/editAccount.dart';

class AccountScreen extends StatefulWidget {
  const AccountScreen({super.key});

  @override
  State<AccountScreen> createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> {
  HttpServiceLogout httpServiceLogout = HttpServiceLogout();
  bool isLoading = true;
  String errorMessage = '';
  void initState(){
    fetchDataOfUser();
    super.initState();
  }
  final HttpServiceGetData httpServiceGetDataOFUser = HttpServiceGetData();
  late String im;
  Future<void> fetchDataOfUser() async {
    try {
      String? token = CacheHelper.getData(key:'token');
      // Call getData method with the authentication token
      Map<String, dynamic> data = await httpServiceGetDataOFUser.getData(token!);

      // Update the state with the fetched data
      setState(() {
        getData = data;
        im = getData?['data']['profileImage'];
        print('im = $im');
        isLoading  = false;
      });

      // Print or use the fetched data as needed
      print('Fetched Data: $getData');
    } catch (e) {
      // Handle errors, if any
      print('Error fetching data: $e');
    }finally{
      setState(() {
        isLoading = false;
      });
    }
  }
  Widget buildShimmerEffect() {
    return ListView.builder(
      itemCount: 10,
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.all(20.0),
          child: Shimmer.fromColors(
            baseColor: Color(0xFFE0E0E0),
            highlightColor: Color(0xFFF5F5F5),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                color: Colors.white, // Add a background color
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: 100,
                      height: 100,
                      color: Colors.white,
                    ),
                    SizedBox(width: 8.0),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            height: 20,
                            color: Colors.white,
                            margin: EdgeInsets.only(bottom: 10.0),
                          ),
                          Row(
                            children: [
                              Container(
                                width: 20,
                                height: 20,
                                color: Colors.white,
                              ),
                              SizedBox(width: 10.0),
                              Container(
                                width: 100,
                                height: 20,
                                color: Colors.white,
                              ),
                              SizedBox(width: 10.0),
                              CircleAvatar(
                                backgroundColor: Colors.yellow,
                                minRadius: 5.0,
                              ),
                              SizedBox(width: 10.0),
                              Container(
                                width: 50,
                                height: 20,
                                color: Colors.white,
                              ),
                            ],
                          ),
                          SizedBox(height: 10.0),
                          Row(
                            children: [
                              SizedBox(width: 20.0),
                              Container(
                                width: 100,
                                height: 20,
                                color: Colors.white,
                              ),
                              Spacer(),
                              Container(
                                width: 60,
                                height: 30,
                                decoration: BoxDecoration(
                                  color: Colors.green,
                                  borderRadius: BorderRadius.circular(25.0),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return Scaffold(
        body: buildShimmerEffect(),
      );
    } else{
      if (getData != null && getData!.isNotEmpty)
      {
    return  Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text(
          LocaleKeys.AccountScreenTitle.tr(),
          style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 20.0
          ),
        ),

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
                        backgroundImage: NetworkImage( getData?['data']['profileImage'] ?? 'assets/images/profile.jpg',
                        ),
                        child: getData?['data']['profileImage'] == null
                            ? ClipOval(
                          child: Image.asset(
                            'assets/images/profile.png',
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


                  Navigator.push(context, MaterialPageRoute(builder: (context){
                    return OnBordingInstructorScreen();
                  }));
                },
                    child:
                    Text(
                      LocaleKeys.AccountScreenBecomeaninstructor.tr(),
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
                    Text(LocaleKeys.AccountScreenVideoprefernce.tr(),
                      style: TextStyle(
                          fontSize: 13.0,
                          color: Colors.grey[600]
                      ),),
                    MaterialButton(
                      onPressed: (){
                        Navigator.push(context,
                          MaterialPageRoute(builder: (context)=> Quality()),);
                      },
                      child:
                      Container(
                        width: double.infinity,
                        child: Row(
                          children: [
                            Text(LocaleKeys.AccountScreendownloadoption.tr()
                              ,style: TextStyle(
                                  fontSize: 17.0
                              ),),
                            Spacer(),
                            Icon(Icons.keyboard_arrow_right),
                          ],
                        ),
                      ),

                    ),
                    SizedBox(height: 1.0,),
          /*          MaterialButton(
                      onPressed: (){
                        *//**************************************** *//*
                        Navigator.push(context, MaterialPageRoute(builder: (context)=>VideoPlay()));
                      },
                      child:
                      Container(
                        width: double.infinity,
                        child: Row(*//******************************************* *//*
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

                    ),*/
                  ],
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(LocaleKeys.AccountScreenaccountsetting.tr(),
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

                            Text(LocaleKeys.AccountScreeneditprofile.tr()
                              ,style: TextStyle(
                                  fontSize: 17.0
                              ),
                            ),
                            Spacer(),
                            Icon(Icons.keyboard_arrow_right),
                          ],
                        ),
                      ),

                    ),

                    SizedBox(height: 1.0,),
                   /* MaterialButton(
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
               */   ],
                ),
                 Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(LocaleKeys.AccountScreenhelpandsupport.tr(),
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
                            Expanded(
                              child: Flexible(
                                child: Text(
                                  LocaleKeys.AccountScreenaboutELearning.tr(),
                                  style: TextStyle(
                                    fontSize: 17.0,
                                  ),
                                  maxLines: 1, // Limit to one line
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ),
                            Spacer(),
                            Icon(Icons.keyboard_arrow_right),
                          ],
                        ),
                      ),

                    ),

                    MaterialButton(
                      onPressed: ()async {
                        try {
                          // Fetch the image URL
                          final urlImage = 'https://res.cloudinary.com/djcwvsuw1/image/upload/v1717855988/course/user-c62c1546-f2da-4b56-8e6b-d6591a76a554-1717855985477.jpeg.jpg';
                          final url = Uri.parse(urlImage);

                          // Download the image
                          final response = await http.get(url);
                          if (response.statusCode == 200) {
                            final bytes = response.bodyBytes;

                            // Get the temporary directory and save the image
                            final temp = await getTemporaryDirectory();
                            final filePath = '${temp.path}/image.jpg';
                            await File(filePath).writeAsBytes(bytes);

                            // Share the image and text
                            await Share.shareFiles(
                              [filePath],
                              text: 'Download E_learning From here https://drive.google.com/drive/folders/1MS5oJA6GG8pR9eRRReh7CLr8B0gpgvea?usp=sharing '
                                  '#E_Learning',
                            );
                          } else {
                            // Handle error while downloading the image
                            Fluttertoast.showToast(
                              msg: "Failed to download the image.",
                              toastLength: Toast.LENGTH_SHORT,
                              gravity: ToastGravity.BOTTOM,
                              timeInSecForIosWeb: 5,
                              backgroundColor: Colors.red,
                              textColor: Colors.white,
                              fontSize: 16.0,
                            );
                          }
                        } catch (e) {
                          // Handle any errors during the process
                          Fluttertoast.showToast(
                            msg: "Error: $e",
                            toastLength: Toast.LENGTH_SHORT,
                            gravity: ToastGravity.BOTTOM,
                            timeInSecForIosWeb: 5,
                            backgroundColor: Colors.red,
                            textColor: Colors.white,
                            fontSize: 16.0,
                          );
                        }
                      },
                      child:
                      Container(
                        width: double.infinity,
                        child: Row(
                          children: [
                            Expanded(
                              child: Flexible(
                                child: Text(
                                  LocaleKeys.AccountScreenshareELearningapp.tr(),
                                  style: TextStyle(
                                    fontSize: 17.0,
                                  ),
                                  maxLines: 1, // Limit to one line
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ),

                            Spacer(),
                            Icon(Icons.keyboard_arrow_right),
                          ],
                        ),
                      ),

                    ),
                    MaterialButton(
                      onPressed: (){

                        Navigator.push(context, MaterialPageRoute(builder: (context){
                          return Setting();
                        }));
                      },
                      child:
                      Container(
                        width: double.infinity,

                        child: Row(
                          children: [
                            Expanded(
                              child: Flexible(
                                child: Text(
                                  LocaleKeys.AccountScreensetting.tr(),
                                  style: TextStyle(
                                    fontSize: 17.0,
                                  ),
                                  maxLines: 1, // Limit to one line
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ),

                            Spacer(),
                            Icon(Icons.keyboard_arrow_right),
                          ],
                        ),
                      ),

                    ),
                  ],
                ),
                (getData?['data']['roles'] == 'Admin' || getData?['data']['roles'] == 'Instructor')?Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(LocaleKeys.AccountScreeninstructor.tr(),
                      style: TextStyle(
                          fontSize: 13.0,
                          color: Colors.grey[600]
                      ),),
                    MaterialButton(
                      onPressed: (){


                        Navigator.push(context, MaterialPageRoute(builder: (context){
                          return InstructorHomeScreen();
                        }));
                      },
                      child:
                      Container(
                        width: double.infinity,
                        child: Row(

                          children: [
                            Text(LocaleKeys.AccountScreenAddCourse.tr()
                              ,style: TextStyle(
                                  fontSize: 17.0
                              ),),
                            Spacer(),
                            Icon(Icons.keyboard_arrow_right),
                          ],
                        ),
                      ),

                    ),
                  ],
                ):Container(),
                SizedBox(height: 10.sp,),
                getData?['data']['roles'] == 'Admin'?Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(LocaleKeys.AccountScreenAdmin.tr(),
                      style: TextStyle(
                          fontSize: 13.0,
                          color: Colors.grey[600]
                      ),),

                    MaterialButton(
                      onPressed: (){

                        Navigator.push(context, MaterialPageRoute(builder: (context){
                          return AdminHome();
                        }));
                      },
                      child:
                      Container(
                        width: double.infinity,
                        child: Row(

                          children: [
                            Text(
                            LocaleKeys.AccountScreenAdmin.tr()
                              ,style: TextStyle(
                                  fontSize: 17.0
                              ),),
                            Spacer(),
                            Icon(Icons.keyboard_arrow_right),
                          ],
                        ),
                      ),

                    ),
                  ],
                ):Container(),
                TextButton(onPressed: ()async{

                  try{
                    bool? token =  await CacheHelper.removeData(key: 'token');
                    if(token){
                      Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => Login()));
                    }
                  }catch(e){
                    print('error when sign out = ]]]]]]]]]]]]]$e');
                  }
                },
                    child:
                    Text(

                      LocaleKeys.AccountScreensignout.tr(),
                      style: TextStyle(
                          color: TColors.Ternary
                      ),
                    )
                ),
                SizedBox(height: 15.0,),
                Text(
                  LocaleKeys.AccountScreenELearning.tr(),
                  style: TextStyle(

                      fontSize: 10.0
                  ),
                ),
              ],
            ),
          ),
        ),
      ) ,

    );}
      else{
        return Scaffold(
          appBar: AppBar(
            title: Text(
                LocaleKeys.AccountScreenTitle.tr()),
          ),
          body: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [

              Lottie.asset('assets/animation/animation2/Animation2.json'),

              Center(child: Text(
                  LocaleKeys.CourseInformationNodataavailable.tr())),
            ],
          ),
        );
      }

    }
  }


}
