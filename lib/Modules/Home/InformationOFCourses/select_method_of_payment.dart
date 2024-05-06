import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:learning/Modules/Home/InformationOFCourses/payment_by_method.dart';

class SelectPayment extends StatelessWidget {
   SelectPayment({super.key,required this.courseID,required this.coursePrice});
  String courseID ;
  String coursePrice ;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Select Payment Method',style: TextStyle(
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
                          Text("Etisalat Cash",
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
                    return PaymentByMethod(
                      courseId:courseID , coursePrice: coursePrice, numberOFMethod: '01147974226',);
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
                          Icon(Icons.payment), // إضافة الأيقونة في البداية
                          SizedBox(width: 10.w), // إضافة مسافة بين الأيقونة والنص
                          Text("Vodafone Cash",
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
                          Text("Orange Cash",
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
                          Text("InstaPay",
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
