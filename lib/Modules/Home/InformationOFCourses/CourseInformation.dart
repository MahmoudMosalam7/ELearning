import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:learning/Modules/Home/InformationOFCourses/payment.dart';

import '../../../TColors.dart';

class CourseInformation extends StatelessWidget {
  const CourseInformation({super.key});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        title: Center(
            child: Text("Coures Details",
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),)),
        actions: [
          CircleAvatar(
            backgroundColor: Colors.grey,
              radius: 15.h,
              child: Icon(Icons.share)),
          SizedBox(width: 4,),
          CircleAvatar(
              backgroundColor: Colors.grey,
              radius: 15.h,
              child: Icon(Icons.shopping_cart)),
        ],
      ),
      body:Padding(
        padding: EdgeInsets.all(8.0.r),
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Container(
                  child: Column(
                    children: [
                      Image.network('https://th.bing.com/th/id/OIP.ysp1ApXWE38vAgTymEFbvgHaEK?rs=1&pid=ImgDetMain'),
                      Text(
                        "Flutter & Dart Complete Development Course [2023][Arabic]",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 25,
                        ),
                        maxLines: 3,
                        overflow: TextOverflow.ellipsis,
                      ),
                      SizedBox(height: 20),
                      Text(
                        "Flutter & Dart Complete Development Course [2023][Arabic]",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 25,
                        ),
                        maxLines: 3,
                        overflow: TextOverflow.ellipsis,
                      ),
                      SizedBox(height: 20),
                      Text(
                        "Flutter & Dart Complete Development Course [2023][Arabic]",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 25,
                        ),
                        maxLines: 3,
                        overflow: TextOverflow.ellipsis,
                      ),
                      SizedBox(height: 20),
                      Text(
                        "Flutter & Dart Complete Development Course [2023][Arabic]",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 25,
                        ),
                        maxLines: 3,
                        overflow: TextOverflow.ellipsis,
                      ),
                      SizedBox(height: 20),
                      Text(
                        "Flutter & Dart Complete Development Course [2023][Arabic]",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 25,
                        ),
                        maxLines: 3,
                        overflow: TextOverflow.ellipsis,
                      ),
                      SizedBox(height: 20),
                      Text(
                        "Flutter & Dart Complete Development Course [2023][Arabic]",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 25,
                        ),
                        maxLines: 3,
                        overflow: TextOverflow.ellipsis,
                      ),
                      SizedBox(height: 20),
                      Text(
                        "Flutter & Dart Complete Development Course [2023][Arabic]",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 25,
                        ),
                        maxLines: 3,
                        overflow: TextOverflow.ellipsis,
                      ),
                      SizedBox(height: 20),
                      Text(
                        "Flutter & Dart Complete Development Course [2023][Arabic]",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 25,
                        ),
                        maxLines: 3,
                        overflow: TextOverflow.ellipsis,
                      ),
                      SizedBox(height: 20),// Add some space between the image and the button
                    ],
                  ),
                ),
              ),
            ),
            Row(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("EGP 199",style: TextStyle(
                    fontSize: 20.h
                    ,fontWeight: FontWeight.bold),),
                    Text("EGP 999",style: TextStyle(fontWeight: FontWeight.bold),)
                  ],
                ),
                SizedBox(width: 15.w,),
                Container(
                  width: 230.w,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20.0.r,),
                    color: TColors.secondray,
                  ),
                  child: MaterialButton(
                    child: const Text(
                      'Enroll Now',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20.0,
                      ),
                    )  ,

                      onPressed: (){
                      Get.to(Payment());
                      },),
                )
    ],
            ),
          ],
        ),
      ),

    );
  }
}
