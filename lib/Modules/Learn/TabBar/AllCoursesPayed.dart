import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

import '../../../apis/user/enrolled_courses.dart';
import '../../../models/enrolled_courses.dart';
import '../../../network/local/cache_helper.dart';
import 'course_videos.dart';

class All extends StatefulWidget {
  const All({super.key});

  @override
  _AllState createState() => _AllState();
}

class _AllState extends State<All> {
  bool isFavorite = false;

  HttpServiceEnrolledCourses httpServiceEnrolledCourses = HttpServiceEnrolledCourses();
  late Map<String,dynamic> serverData ;
  String errorMessage = '';
  bool isLoading = false;

  List<EnrolledCourses> products = [];
  void _allCourses() async {
    // Reset error message and loading state
    setState(() {
      errorMessage = '';
      isLoading = true;
    });

    try {
      // Add your login logic here, e.g., make API call
      serverData = await httpServiceEnrolledCourses.allEnrolledCourses(
          CacheHelper.getData(key: 'token')
      );

      print('get all course successful! $serverData');

      if (serverData != null) {
        print('serverdata = ${EnrolledCourses.parseProductsFromServer(serverData)}');
        products = EnrolledCourses.parseProductsFromServer(serverData);
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
    _allCourses();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            ListView.separated(
              scrollDirection: Axis.vertical,
              physics: NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: products.length,
              itemBuilder: (context, index) {
                final product = products[index];
                return InkWell(
                  onTap: () {
                    // Handle the tap event here

                   Get.to(CourseContent(courseId: products[index].id, ));

                  },
                  child: containerOFEnrolledCourses(product: product),
                );
              },
              separatorBuilder: (context, index) => Divider(height: 15.0),
            ),

          ],
        ),
      ),
    );
  }
  Widget containerOFEnrolledCourses({required EnrolledCourses? product}){
    print('list of enrolled = $product');
    return Card(
      elevation: 4, // Adds a shadow effect
      child: ListTile(
        title:  Text(product!.title,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
        subtitle:  Text(product!.instructorName),
        leading: Stack(
          children: [
            if(product.imageURL != null)
              Image.network((product!.imageURL)),
            if(product.imageURL == null)
              Image.asset(''),
            Positioned(
              top: 0,
              right: 0,
              child: CircleAvatar(
                radius: 9,
                child: InkWell(
                  onTap: () {
                    setState(() {
                      isFavorite = !isFavorite;
                    });
                  },
                  child: Icon(
                    isFavorite ? Icons.favorite : Icons.favorite_border,
                    size: 15,
                    color: isFavorite ? Colors.green : Colors.green,
                  ),
                ),
              ),
            ),
          ],
        ),
        trailing: SizedBox(
          width: 50, // Constrain the width of the CircularPercentIndicator
          height: 50, // Constrain the height of the CircularPercentIndicator
          child: CircularPercentIndicator(
            radius: 25.0,
            lineWidth: 4.0,
            percent: ((product!.progress).toInt())/100,
            center: Text("${(product!.progress).toInt()}%"),
            progressColor: Colors.green,
          ),
        ),
      ),
    );
  }
}
