import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:learning/Modules/Account/become_an_instructor/Instructor_page/instructor_home_page.dart';
import '../../../../apis/user/http_service_get_user_data.dart';
import '../../../../translations/locale_keys.g.dart';
import 'add_new_course/basic_information.dart';
import 'coursesOFInstructor.dart';
import 'instructor_profites.dart';


class InstructorCourses extends StatelessWidget {
  final HttpServiceGetData httpService = HttpServiceGetData();
  final students;
  final rating;

   InstructorCourses({super.key, required this.students, required this.rating });
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
         /*   ElevatedButton(
                onPressed:()async{
                  try {
                    // Replace 'your_token_here' with the actual token
                    String token =  CacheHelper.getData(key:'token');
                    print("token = $token");
                    // Call the fetchData function
                    Map<String, dynamic> data = await httpService.getData(token);
                    // Now you can use 'data' to handle the response
                    print('Response data: $data');
                  } catch (error) {
                    // Handle any exceptions thrown during the API call
                    print('Error: $error');
                  }
                },
                child: Text('Add New Course'
                ,style:  TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.white
                    ),
                ),
              style: ElevatedButton.styleFrom(
                backgroundColor: TColors.primary,

              ),
            ),
            SizedBox(height: 20.h,),
            Center(
              child: Text('Courses'),
            ),*/
            SizedBox(height: 20.h,),
            Row(
              children: [
                GestureDetector(
                  onTap: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context){
                      return BasicInformation(courseId: '',fromUpdateCourse: false,);
                    }));
                  },
                  child: Card(
                    elevation: 5, // Add elevation for a shadow effect
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16.0.r), // Adjust the radius for a square shape
                    ),
                    child: Container(
                      width: 140.w,
                      height: 140.h,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16.0.r),
                        color: Color(0xff9F70FD), // Customize the background color
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.add,
                            size: 50.sp,
                            color: Colors.white, // Customize the icon color
                          ),
                          SizedBox(height: 10.h),
                          Text(
                            LocaleKeys.InstructorInstructorCoursesAddNewCourse.tr(),
                            style: TextStyle(
                              color: Colors.white, // Customize the text color
                              fontSize: 16.sp,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Spacer(),
                GestureDetector(
                  onTap: (){

                    Navigator.push(context, MaterialPageRoute(builder: (context){
                      return CoursesOfInstructor();
                    }));
                  },
                  child: Card(
                    elevation: 5, // Add elevation for a shadow effect
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16.0.r), // Adjust the radius for a square shape
                    ),
                    child: Container(
                      width: 140.w,
                      height: 140.h,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16.0.r),
                        color: Color(0xff64CCC5), // Customize the background color
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.book,
                            size: 50.sp,
                            color: Colors.white, // Customize the icon color
                          ),
                          SizedBox(height: 10.h),
                          Text(
                            LocaleKeys.InstructorInstructorCoursesCourses.tr(),
                            style: TextStyle(
                              color: Colors.white, // Customize the text color
                              fontSize: 16.sp,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 20.h,),
            Row(
              children: [
                Card(
                  elevation: 5, // Add elevation for a shadow effect
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16.0.r), // Adjust the radius for a square shape
                  ),
                  child: Container(
                    width: 140.w,
                    height: 140.h,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16.0.r),
                      color: Color(0xFFFFB0B0), // Customize the background color
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.content_paste_rounded,
                          size: 50.sp,
                          color: Colors.white, // Customize the icon color
                        ),
                        SizedBox(height: 10.h),
                        Text(
                          '$students',
                          style: TextStyle(
                            color: Colors.white, // Customize the text color
                            fontSize: 16.sp,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 10.h),
                        Text(
                          LocaleKeys.InstructorInstructorCoursesStudents.tr(),
                          style: TextStyle(
                            color: Color(0xFFEFECEC), // Customize the text color
                            fontSize: 16.sp,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Spacer(),
                Card(
                  elevation: 5, // Add elevation for a shadow effect
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16.0.r), // Adjust the radius for a square shape
                  ),
                  child: Container(
                    width: 140.w,
                    height: 140.h,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16.0.r),
                      color: Color(0xff86B6F6), // Customize the background color
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.star,
                          size: 50.sp,
                          color: Colors.yellowAccent, // Customize the icon color
                        ),
                        SizedBox(height: 10.h),
                        Text(
                          '$rating',
                          style: TextStyle(
                            color: Colors.white, // Customize the text color
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 10.h),
                        Text(
                          LocaleKeys.InstructorInstructorCoursesRateing.tr(),
                          style: TextStyle(
                            color: Color(0xFFEFECEC), // Customize the text color
                            fontSize: 16,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 20.h,),
            GestureDetector(
              onTap: (){

                Navigator.push(context, MaterialPageRoute(builder: (context){
                  return InstructorProfites();
                }));
              },
              child: Row(
                children: [
                  Card(
                    elevation: 5, // Add elevation for a shadow effect
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16.0.r), // Adjust the radius for a square shape
                    ),
                    child: Container(
                      width: 140.w,
                      height: 140.h,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16.0.r),
                        color: Colors.blueGrey, // Customize the background color
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.leaderboard,
                            size: 50.sp,
                            color: Colors.white, // Customize the icon color
                          ),
                          SizedBox(height: 10.h),
                          Text(
                            LocaleKeys.InstructorInstructorCoursesProfits.tr(),
                            style: TextStyle(
                              color: Colors.white, // Customize the text color
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Spacer(),
                  Card(
                    elevation: 5, // Add elevation for a shadow effect
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16.0.r), // Adjust the radius for a square shape
                    ),
                    child: Container(
                      width: 140.w,
                      height: 140.h,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16.0.r),
                        color: Color(0xffADA2FF), // Customize the background color
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.star,
                            size: 50.sp,
                            color: Colors.yellowAccent, // Customize the icon color
                          ),
                          SizedBox(height: 10.h),
                          Text(
                            '$rating',
                            style: TextStyle(
                              color: Colors.white, // Customize the text color
                              fontSize: 16.sp,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 10.h),
                          Text(
                            LocaleKeys.InstructorInstructorCoursesCoursesRateing.tr(),
                            style: TextStyle(
                              color: Color(0xFFEFECEC), // Customize the text color
                              fontSize: 12.sp,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
