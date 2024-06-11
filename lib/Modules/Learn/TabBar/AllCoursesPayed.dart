import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:shimmer/shimmer.dart';

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

      print('datatttttttttttttt= ${serverData['data']['results']}');
      products = EnrolledCourses.parseProductsFromServer(serverData['data']['results']);
      print('Products: $products');
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

  Widget buildShimmerEffect(){
    return ListView.builder(
        itemCount: 10,
        itemBuilder: (context,index){
          return Shimmer.fromColors(
            baseColor: Color(0xFFE0E0E0),
            highlightColor: Color(0xFFF5F5F5),
            child: ListTile(
              leading: Container(
                width: 48,
                height: 48,
                color: Colors.white,
              ),
              title: Container(
                height: 14,
                color: Colors.white,
              ),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    height: 14,
                    color: Colors.white,
                    margin: EdgeInsets.only(top: 5),
                  ),

                  Container(
                    height: 14,
                    width: 100,
                    color: Colors.white,
                    margin: EdgeInsets.only(top: 5),
                  )

                ],
              ),
            ),
          );
        });
  }
  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return Scaffold(
        body:  buildShimmerEffect(),
      );
    } else{

      if (products.isNotEmpty)
        {  return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: SingleChildScrollView(
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
      ),
    );}
      else{
        return Scaffold(

          body: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [

              Lottie.asset('assets/animation/animation2/Animation2.json'),

              Center(child: Text("No data available")),
            ],
          ),
        );
      }
    }
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
        subtitle:  Text(product.instructorName),
        leading: Stack(
          children: [
            Image.network((product.imageURL)),
            /*Positioned(
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
            ),*/
          ],
        ),
        trailing: SizedBox(
          width: 50, // Constrain the width of the CircularPercentIndicator
          height: 50, // Constrain the height of the CircularPercentIndicator
          child: CircularPercentIndicator(
            radius: 25.0,
            lineWidth: 4.0,
            percent: ((product.progress).toInt())/100,
            center: Text("${(product.progress).toInt()}%"),
            progressColor: Colors.green,
          ),
        ),
      ),
    );
  }
}
