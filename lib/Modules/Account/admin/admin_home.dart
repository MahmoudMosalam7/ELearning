import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:learning/Modules/Account/admin/admin_payment.dart';

import '../../../../apis/user/http_service_get_user_data.dart';
import 'add_users.dart';
import 'admin_profits.dart';
import 'allusers.dart';
import 'find_user_by_email.dart';


class AdminHome extends StatelessWidget {
  final HttpServiceGetData httpService = HttpServiceGetData();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [

            SizedBox(height: 20.h,),
            Row(
              children: [
                GestureDetector(
                  onTap: (){
                   Get.to(AddUser());
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
                            Icons.add,
                            size: 50.sp,
                            color: Colors.white, // Customize the icon color
                          ),
                          SizedBox(height: 10.h),
                          Text(
                            'Add New User',
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
                    Get.to(FindUserByEmail());
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
                        color:Color(0xff9F70FD) , // Customize the background color
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.search,
                            size: 50.sp,
                            color: Colors.white, // Customize the icon color
                          ),
                          SizedBox(height: 10.h),
                          Text(
                            'Find User',
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
                  child: GestureDetector(
                    onTap: (){
                      Get.to(AllUsers());
                    },
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
                            Icons.content_paste_rounded,
                            size: 50.sp,
                            color: Colors.white, // Customize the icon color
                          ),
                          SizedBox(height: 10.h),
                          Text(
                            'Users',
                            style: TextStyle(
                              color: Color(0xFFEFECEC), // Customize the text color
                              fontSize: 16.sp,
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
                    Get.to(AdminPayment());
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
                        color: Color(0xFFFFB0B0), // Customize the background color
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.payment,
                            size: 50.sp,
                            color: Colors.white, // Customize the icon color
                          ),
                          SizedBox(height: 10.h),
                          SizedBox(height: 10.h),
                          Text(
                            'Payment',
                            style: TextStyle(
                              color: Colors.white, // Customize the text color
                              fontSize: 16,
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
                GestureDetector(
                  onTap: (){
                    Get.to(AdminProfites());},
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
                        color: Color(0xffADA2FF), // Customize the background color
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
                            'Profits',
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
                ),
                Spacer(),
               /* Card(
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
                          Icons.star,
                          size: 50.sp,
                          color: Colors.yellowAccent, // Customize the icon color
                        ),
                        SizedBox(height: 10.h),
                        Text(
                          '4.8',
                          style: TextStyle(
                            color: Colors.white, // Customize the text color
                            fontSize: 16.sp,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 10.h),
                        Text(
                          'Courses Rateing',
                          style: TextStyle(
                            color: Color(0xFFEFECEC), // Customize the text color
                            fontSize: 12.sp,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),*/
              ],
            ),
          ],
        ),
      ),
    );
  }
}
