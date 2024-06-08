import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:learning/Modules/Home/InformationOFCourses/CourseInformation.dart';
import 'package:lottie/lottie.dart';

import 'package:easy_localization/easy_localization.dart';
import 'package:shimmer/shimmer.dart';
import '../../apis/courseInformation/http_service_courseInformation.dart';
import '../../models/wishlist_model.dart';
import '../../network/local/cache_helper.dart';
import '../../translations/locale_keys.g.dart';

bool isInsideW = false;

class WishListScreen extends StatefulWidget {
  WishListScreen({Key? key});

  @override
  State<WishListScreen> createState() => _WishListScreenState();
}

List<WishList> coursesOfFav = [];

class _WishListScreenState extends State<WishListScreen> {
  HttpServiceCourse httpServiceCourse = HttpServiceCourse();

  late Map<String, dynamic> serverData;

  String errorMessage = '';

  bool isLoading = true;

  void _allCoursesFromWishList() async {
    try {
      serverData = await httpServiceCourse.getAllCoursesFromWishList(
          CacheHelper.getData(key: 'token'));

      print('get all course of favorites successful! $serverData');
      setState(() {
        errorMessage = '';
        isLoading = false;
      });
      if (serverData != null) {
        print(
            'serverdata = ${WishList.parseSectionFromServer(serverData['data'])}');
        coursesOfFav = WishList.parseSectionFromServer(serverData['data']);
        print('coursesOfFav: $coursesOfFav');
      } else {
        throw Exception('Server data is null');
      }
    } catch (e) {
      setState(() {
        errorMessage = 'Error: $e';
        if (errorMessage.contains('422')) {
          errorMessage = "Valdition Error!";
        } else if (errorMessage.contains('401')) {
          errorMessage = " unauthorized access !";
        } else if (errorMessage.contains('500')) {
          errorMessage = " Server Not Available Now !";
        } else {
          errorMessage = "Unexpected Error!";
        }

      });
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    _allCoursesFromWishList();
  }

  Future<void> _refreshCourses() async {
     _allCoursesFromWishList();
  }

  @override
  Widget build(BuildContext context) {
    print('zzzzzzzzzzzzzzzzzzzzzzzzzzzzz');
    print('course = $coursesOfFav');
    if (isLoading) {
      return Scaffold(
        appBar: AppBar(
          title:  Text(LocaleKeys.WishListScreenWishList.tr()),
        ),
        body:  buildShimmerEffect(),
      );
    } else {
      if (coursesOfFav != null && coursesOfFav!.isNotEmpty) {
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
            title:  Text(
              LocaleKeys.WishListScreenWishList.tr(),
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          body: RefreshIndicator(
            onRefresh: _refreshCourses,
            child: ListView.separated(
              scrollDirection: Axis.vertical,
              physics: AlwaysScrollableScrollPhysics(),
              itemCount: coursesOfFav.length,
              itemBuilder: (context, index) {
                final course = coursesOfFav[index];
                return InkWell(
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) {
                          return CourseInformation(
                              courseId: course.id, fromInstructor: false);
                        }));
                  },
                  child: coursesOfWishList(course),
                );
              },
              separatorBuilder: (context, index) => Divider(height: 15.0),
            ),
          ),
        );
      } else {
        return Scaffold(
          appBar: AppBar(
            title:  Text(LocaleKeys.WishListScreenWishList.tr()),
          ),
          body: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [

              Lottie.asset('assets/animation/animation1/Animation5.json'),

              Center(child: Text(LocaleKeys.CourseInformationNodataavailable.tr())),
            ],
          ),
        );
      }
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

  Widget coursesOfWishList(WishList course) {
    int hourse = course.hours.round();
    int minutes = course.minutes.round();
    int seconds = course.seconds.round();
    String duration;
    String duration1 = '';
    String duration2 = '';
    String duration3 = '';
    if (hourse != 0) duration1 = '$hourse h ';
    if (minutes != 0) duration2 = '$minutes m ';
    if (seconds != 0) duration3 = '$seconds s';
    duration = '${duration1}${duration2}${duration3}';
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: SingleChildScrollView(
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
          ),
          child: Column(
            children: [
              GestureDetector(
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) {
                        return CourseInformation(
                            courseId: course.id, fromInstructor: false);
                      }));
                },
                child: Container(
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
                                  CircleAvatar(
                                      backgroundColor: Colors.yellow,
                                      minRadius: 5.0),
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
                                        borderRadius:
                                        BorderRadius.circular(25.0),
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
              ),
              // Add more content here
            ],
          ),
        ),
      ),
    );
  }
}
