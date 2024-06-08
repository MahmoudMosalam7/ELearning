import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:learning/Modules/Account/become_an_instructor/Instructor_page/add_new_course/basic_information.dart';
import '../../../../translations/locale_keys.g.dart';
import 'add_new_course/add_price_publish.dart';
import 'add_new_course/advanced_information.dart';
import 'add_new_course/course_curriculum/course_curriculum.dart';
import 'package:easy_localization/easy_localization.dart';
class UpdateCourse extends StatelessWidget {
  UpdateCourse({super.key,required this.courseID});
  String courseID ;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(LocaleKeys.InstructorUpdateCourseTitle.tr(),style: TextStyle(
            fontWeight: FontWeight.bold
        ),),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: GestureDetector(
                onTap: () {
                  // Add your functionality here
                  Navigator.push(context, MaterialPageRoute(builder: (context){
                    return BasicInformation(fromUpdateCourse: true,courseId:courseID,);
                  }));
                },
                child: Container(
                  width: double.infinity,// تحديد العرض المطلوب للبطاقة
                  height: 70.h,
                  child: Card(
                    elevation: 5.r, // إضافة هامش
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.r), // تحديد شكل الزوايا
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Row(
                        children: [
                          Icon(Icons.info_outline_rounded), // إضافة الأيقونة في البداية
                          SizedBox(width: 10.w), // إضافة مسافة بين الأيقونة والنص
                          Text(LocaleKeys.InstructorUpdateCourseUpdateBasicInformation.tr(),
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 18.sp
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: GestureDetector(
                onTap: () {
                  // Add your functionality here
                  Navigator.of(context).push(MaterialPageRoute(builder: (context){
                    return AdvancedInformationScreen(fromUpdateCourse: true,courseId:courseID);
                  }));
                  /*
                  Get.to(PaymentByMethod(
                            courseId:courseID , coursePrice: coursePrice, numberOFMethod: '01147974226',));*/
                },
                child: Container(
                  width: double.infinity,// تحديد العرض المطلوب للبطاقة
                  height: 70.h,
                  child: Card(
                    elevation: 5.r, // إضافة هامش
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.r), // تحديد شكل الزوايا
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Row(
                        children: [
                          Icon(Icons.info_outline_rounded), // إضافة الأيقونة في البداية
                          SizedBox(width: 10.w), // إضافة مسافة بين الأيقونة والنص
                          Text(LocaleKeys.InstructorUpdateCourseUpdateAdvancedInformation.tr(),
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 18.sp
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: GestureDetector(
                onTap: () {
                  // Add your functionality here
                  Navigator.push(context, MaterialPageRoute(builder: (context){
                    return CourseCurriculum(fromUpdateCourse: true,courseId:courseID);
                  }));
                },
                child: Container(
                  width: double.infinity,// تحديد العرض المطلوب للبطاقة
                  height: 70.h,
                  child: Card(
                    elevation: 5.r, // إضافة هامش
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.r), // تحديد شكل الزوايا
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Row(
                        children: [
                          Icon(Icons.info_outline_rounded), // إضافة الأيقونة في البداية
                          SizedBox(width: 10.w), // إضافة مسافة بين الأيقونة والنص
                          Text(LocaleKeys.InstructorUpdateCourseUpdateCourseCurriculum.tr(),
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 18.sp
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: GestureDetector(
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context){
                    return AddPriceAndPublish(fromInstructor: true,courseId:courseID);
                  }));
                  },
                child: Container(
                  width: double.infinity,// تحديد العرض المطلوب للبطاقة
                  height: 70.h,
                  child: Card(
                    elevation: 5.r, // إضافة هامش
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.r), // تحديد شكل الزوايا
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Row(
                        children: [
                          Icon(Icons.payment), // إضافة الأيقونة في البداية
                          SizedBox(width: 10.w), // إضافة مسافة بين الأيقونة والنص
                          Text(LocaleKeys.InstructorUpdateCoursePriceORSpreadSheet.tr(),
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 18.sp
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      )
      ,
    );
  }
}
