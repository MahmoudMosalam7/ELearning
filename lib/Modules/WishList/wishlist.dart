import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../apis/courseInformation/http_service_courseInformation.dart';
import '../../models/wishlist_model.dart';
import '../../network/local/cache_helper.dart';

class WishListScreen extends StatefulWidget {
   WishListScreen({Key? key});

  @override
  State<WishListScreen> createState() => _WishListScreenState();
}

class _WishListScreenState extends State<WishListScreen> {
  HttpServiceCourse httpServiceCourse = HttpServiceCourse();

   late Map<String,dynamic> serverData ;

   String errorMessage = '';

   bool isLoading = false;

   List<WishList> coursesOfFav = [];

   void _allCoursesFromWishList() async {
     // Reset error message and loading state
     setState(() {
       errorMessage = '';
       isLoading = true;
     });

     try {
       // Add your login logic here, e.g., make API call
       serverData = await httpServiceCourse.getAllCoursesFromWishList(
           CacheHelper.getData(key: 'token')
       );

       print('get all course of favorites successful! $serverData');

       if (serverData != null) {
         print('serverdata = ${WishList.parseSectionFromServer(serverData['data'])}');
         coursesOfFav = WishList.parseSectionFromServer(serverData['data']);
         print('coursesOfFav: $coursesOfFav');
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
     super.initState();

       _allCoursesFromWishList();

   }

   @override
  Widget build(BuildContext context) {
    print('zzzzzzzzzzzzzzzzzzzzzzzzzzzzz');
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            color: Colors.black,
            icon: const CircleAvatar(
              radius: 15.0,
              backgroundColor: Colors.grey,
              child: Icon(
                Icons.search,
                size: 20.0,
              ),
            ),
            onPressed: () {},
          ),
        ],
        title: const Text(
          'WishList',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: ListView.separated(
          scrollDirection: Axis.vertical,
          physics: NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemCount: coursesOfFav.length,
          itemBuilder: (context, index) {
            final course = coursesOfFav[index];
            return InkWell(
              onTap: () {
                // Handle the tap event here

            //    Get.to(CourseInformation(courseId: products[index].id,fromInstructor: false,));

              },
              child: coursesOfWishList(course),
            );
          },
          separatorBuilder: (context, index) => Divider(height: 15.0),
        ),
      ),
    );
  }

  Widget coursesOfWishList(WishList course){
     int hourse = course.hours.round();
     int minutes = course.minutes.round();
     int seconds = course.seconds.round();
     String duration;
     String duration1='';
     String duration2='';
     String duration3='';
     if(hourse != 0 )
       duration1 = '$hourse h ';

     if(minutes != 0 )
       duration2= '$minutes m ';
     if(seconds != 0 )
       duration3 = '$seconds s';
     duration ='${duration1!}${duration2!}${duration3!}';
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: SingleChildScrollView(
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),

          ),
          child: Column(
            children: [
              Container(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Image(
                        image: NetworkImage(course.imageUrl),
                        width: 100, // Set the width of the image
                        height: 100, // Set the height of the image
                      ),
                      SizedBox(width: 8.0),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              course.title,
                              style: TextStyle(
                                fontSize: 15.0,
                                fontWeight: FontWeight.bold,
                              ),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                            SizedBox(height: 10.0),
                            Row(
                              children: [
                                Icon(Icons.nat),
                                SizedBox(width: 10.0),
                                Text("${course.noOfSections} lesson"),
                                SizedBox(width: 10.0),
                                CircleAvatar(backgroundColor: Colors.yellow, minRadius: 5.0),
                                SizedBox(width: 10.0),
                                Text("$duration"),
                              ],
                            ),
                            SizedBox(height: 10.0),
                            Row(
                              children: [
                                SizedBox(width: 20.0),
                                Text("${course.priceCurrency} ${course.priceAmount}"),
                                Spacer(),
                                TextButton(
                                  onPressed: () {},
                                  child: Text(
                                    "Enroll",
                                    style: TextStyle(color: Colors.white),
                                  ),
                                  style: TextButton.styleFrom(
                                    backgroundColor: Colors.green,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(25.0),
                                    ),
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
              // Add more content here
            ],
          ),
        ),
      ),
    );
  }
}
