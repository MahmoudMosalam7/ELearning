import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../../../apis/update_instructor/http_service_courses.dart';
import '../../../../models/listView_Courses.dart';
import '../../../../network/local/cache_helper.dart';
import '../../../Home/InformationOFCourses/CourseInformation.dart';
import '../../../Home/Product.dart';

class CoursesOfInstructor extends StatefulWidget {
  const CoursesOfInstructor({super.key});


  @override
  State<CoursesOfInstructor> createState() => _CoursesOfInstructorState();
}

class _CoursesOfInstructorState extends State<CoursesOfInstructor> {
  HttpServiceCoursesOfInstructor httpServiceCoursesOfInstructor = HttpServiceCoursesOfInstructor();
  late Map<String,dynamic> serverData ;
  String errorMessage = '';
  bool isLoading = false;

  List<Product> products = [];
  void _allCoursesOfInstructor() async {
    // Reset error message and loading state
    setState(() {
      errorMessage = '';
      isLoading = true;
    });

    try {
      // Add your login logic here, e.g., make API call
      serverData = await httpServiceCoursesOfInstructor.allCoursesOfInstructor(
          CacheHelper.getData(key: 'token')
      );

      print('get all course successful! $serverData');

      if (serverData != null) {
        print('serverdata = ${Product.parseProductsFromServer(serverData)}');
        products = Product.parseProductsFromServer(serverData);
        print('Products: $products');
      } else {
        throw Exception('Server data is null');
      }
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
          msg: "$errorMessage",
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
  void initState(){
    _allCoursesOfInstructor();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
     return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: ListView.separated(
          scrollDirection: Axis.vertical,
          physics: NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemCount: products.length,
          itemBuilder: (context, index) {
            final product = products[index];
            return InkWell(
              onTap: () {
                // Handle the tap event here

                Get.to(CourseInformation(courseId: products[index].id,fromInstructor: true,));

              },
              child: ProductListItem(product: product),
            );
          },
          separatorBuilder: (context, index) => Divider(height: 15.0),
        )
      ),
    );
  }
}
