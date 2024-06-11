import 'dart:async';
import 'dart:io';

import 'package:accordion/accordion.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:learning/Modules/Home/InformationOFCourses/select_method_of_payment.dart';
import 'package:learning/Modules/Home/InformationOFCourses/video_preview.dart';
import 'package:learning/Modules/Home/InformationOFCourses/video_screen.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';
import 'package:video_player/video_player.dart';

import 'package:http/http.dart' as http;
import 'package:easy_localization/easy_localization.dart';
import '../../../TColors.dart';
import '../../../apis/courseInformation/http_service_courseInformation.dart';
import '../../../apis/update_instructor/http_service_courses.dart';
import '../../../apis/upload_course/add_price_compiler_delete_publish.dart';
import '../../../models/listView_Courses.dart';
import '../../../models/module_model.dart';
import '../../../models/review_model.dart';
import '../../../network/local/cache_helper.dart';
import '../../../shared/constant.dart';
import '../../../translations/locale_keys.g.dart';
import '../../Account/become_an_instructor/Instructor_page/update_course_information.dart';
import '../../Learn/TabBar/course_videos.dart';
import '../../WishList/wishlist.dart';
import 'instructor_information.dart';

class CourseInformation extends StatefulWidget {
  const CourseInformation({Key? key, required this.courseId, required this.fromInstructor});
  final String courseId;
  final bool fromInstructor;

  @override
  State<CourseInformation> createState() => _CourseInformationState();
}

class _CourseInformationState extends State<CourseInformation>  {
  HttpServiceCourse httpServiceCourse = HttpServiceCourse();
  HttpServiceCoursesOfInstructor httpServiceCoursesOfInstructor =HttpServiceCoursesOfInstructor();
  HttpServiceCoursePriceAndPublishAndDeleteAndCompiler httpCourse = HttpServiceCoursePriceAndPublishAndDeleteAndCompiler();
  Future<void> _publishCourse() async {
    try {
      // Fetch course data only if not already loading
      String id = CacheHelper.getData(key: 'courseId');
      if(widget.fromInstructor){
        id = widget.courseId;
        print('widget.fromInstructor id = $id');
      }
      print('id = $id');
      await httpCourse.publishCourse(
          CacheHelper.getData(key: 'token'),
          id);

      errorMessage = "";
      Fluttertoast.showToast(
        msg: "add publishCourse Success",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 5,
        backgroundColor: Colors.green,
        textColor: Colors.white,
        fontSize: 16.0,
      );

    } catch (e) {
      print('Error publishCourse : $e');
      setState(() {
        errorMessage = 'Error: $e';
        if (errorMessage.contains('422')) {
          errorMessage = "Check your Emails link !";
        } else {
          errorMessage = "Unexpected Error!";
        }
      });
      Fluttertoast.showToast(
        msg: errorMessage,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 5,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0,
      );
    }
  }


  bool _isLoading = true;
  late Map<String,dynamic> serverData ;
  String errorMessage = '';


  List<Product> products = [];
  List<ReviewModel> reviews = [];
  void _allCoursesByCategory(String categoryId) async {
    // Reset error message and loading state
    setState(() {
      errorMessage = '';
     _isLoading = false;
    });

    try {
      // Add your login logic here, e.g., make API call
      serverData = await httpServiceCourse.allCoursesByCategories(
          CacheHelper.getData(key: 'token'),
          categoryId
      );
      _isLoading = false;
      print('get all course by category successful! $serverData');

      print('serverdata from category = ${Product.parseProductsFromServer(serverData)}');
      products = Product.parseProductsFromServer(serverData);
      print('Productshello: $products');
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
        _isLoading = false;
      });
    }
  }
  String codeOfCoupon = '';
  void _makeCoupon() async {
    // Reset error message and loading state
    setState(() {
      errorMessage = '';
      _isLoading = false;
    });

    try {
      String exp = _exContoller.text;
      exp+='T21:00:00';
      // Add your login logic here, e.g., make API call
      String code = await httpServiceCoursesOfInstructor.makeCoupon(
        exp,
          _discountContoller.text,
          _maximumUserContoller.text,
        data!['_id'],
        CacheHelper.getData(key: 'token'),
      );
      _isLoading = false;
      print('make coupon successful! $code');
      setState(() {
        print('add cob bef = $isAddCoubon');
        isAddCoubon = !isAddCoubon;
        print('add cob aft = $isAddCoubon');
        codeOfCoupon = code;
      });

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
        _isLoading = false;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    if (_isLoading) {
      _getCourse(); // Fetch course data only if _isLoading is true
    }
  }
  late Map<String, dynamic> courseData;
  Future<void> _getCourse() async {
    try {
      // Fetch course data only if not already loading
      if (_isLoading) {
        String? token = CacheHelper.getData(key: 'token');
         courseData = await httpServiceCourse.getCourse(widget.courseId, token!);
        _allCoursesByCategory(courseData['data']['results']['category']['_id']);
        setState(() {
          data = courseData['data']['results'];
          print('drrrrrrrrrrrrrrro = ${ courseData['data']['reviewsWithComments']}');
          reviews = ReviewModel.parseReviewsFromServer(courseData['data']['reviewsWithComments']);
          print('rrrrrrrrrrrrrrrrrrrrrrrviewa =$reviews ');


          _isLoading = false; // Set _isLoading to false after data is fetched
        });

         }
    } catch (e) {
      print('Error fetching course data: $e');
      setState(() {
        _isLoading = false; // Set _isLoading to false in case of error
      });
    }
  }
  Future<void> _addAndRemoveCourseFromWishList() async {
    try {
      // Fetch course data only if not already loading

        String? token = CacheHelper.getData(key: 'token');
        print('data = ${data!['_id']}');
        Map<String, dynamic> courseData = await httpServiceCourse.addAndRemoveCourseFromWishList(data!['_id'], token!);
        setState(() {

           if(courseData['data'] !=null){
             Fluttertoast.showToast(
               msg: " Course add to Wishlist",
               toastLength: Toast.LENGTH_SHORT,
               gravity: ToastGravity.BOTTOM,
               timeInSecForIosWeb: 5,
               backgroundColor: Colors.green,
               textColor: Colors.white,
               fontSize: 16.0,
             );
           }else{
             for(int i =0 ; i<coursesOfFav.length;i++){
               if(coursesOfFav[i].id == data!['_id'] ){
                setState(() {
                  coursesOfFav.removeAt(i);
                });
               }
             }
             Fluttertoast.showToast(
               msg: " Course removed from Wishlist",
               toastLength: Toast.LENGTH_SHORT,
               gravity: ToastGravity.BOTTOM,
               timeInSecForIosWeb: 5,
               backgroundColor: Colors.green,
               textColor: Colors.white,
               fontSize: 16.0,
             );
           }
          // Set _isLoading to false after data is fetched
        });
    } catch (e) {
      print('Error add or delete  course from wislist: $e');
      setState(() {
        _isLoading = false; // Set _isLoading to false in case of error
      });
    }
  }

  late String path;
  Future<void> _getModule(String moduleId) async {
    try {
       // Only fetch data if not already loading
        String? token = CacheHelper.getData(key: 'token');
        String courseData = await httpServiceCourse.getModule(moduleId, token!);
        setState(() {
          path = courseData;
          // _initializeController();
          _isLoading = false;
        });

    } catch (e) {
      print('Error fetching course data: $e');
      setState(() {
        _isLoading = false;
      });
    }
  }

  Future<void> _deleteCourse() async {
    try {
      // Fetch course data only if not already loading
        String id = CacheHelper.getData(key: 'courseId');
        if(widget.fromInstructor){
          id = widget.courseId;
        }
         await httpCourse.deleteCourse(CacheHelper.getData(key: 'token'),
             id);
        Navigator.pop(context);
        errorMessage = "";
        Fluttertoast.showToast(
          msg: "Delete Course Success",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 5,
          backgroundColor: Colors.green,
          textColor: Colors.white,
          fontSize: 16.0,
        );

    } catch (e) {
      print('Error while delete course data: $e');
      setState(() {
        errorMessage = 'Error: $e';
        if (errorMessage.contains('422')) {
          errorMessage = "Check your Emails link !";
        } else {
          errorMessage = "Unexpected Error!";
        }
      });
      Fluttertoast.showToast(
        msg: errorMessage,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 5,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0,
      );
    }
  }
  bool isAddCoubon = false;
  @override
  Widget build(BuildContext context) {

    print("hellllllllllllllllllllllllllllllllo1");
    if (data == null || data!.isEmpty) {
      //_getCourse(); // Fetch course data only if data is null or empty
    }
       // Ensure that super.build is called

    if (_isLoading) {
      return Scaffold(
        appBar: AppBar(
          title:  Text(LocaleKeys.CourseInformationTitleCourseDetails.tr()),
        ),
        body: const Center(child: CircularProgressIndicator(color: Colors.green,)),
      );
    } else {
      if (data != null && data!.isNotEmpty) {
        //data!['_id']
        List<dynamic> noOfStudents = data!['enrolledUsers'];
        List <dynamic> enrolledourses = getData?['data']['enrolledCourses'];
        print('enrolledourses = ${enrolledourses}');
        print('enrolledourses = ${enrolledourses.contains(data!['_id'])}');

        List<dynamic> reve =  courseData['data']['reviewsWithComments'];
        String videoURL = 'https://youtube.com/shorts/r9BGpTQzTjI?si=PRUUCiCHLPei7vIU' ;
        if(data?['videoTrailer'] != null){
          videoURL = data?['videoTrailer'];
        }
        int rating =  0 ;
        if(data?['ratingsAverage'] != null){
          rating = (data!['ratingsAverage']).round();
        }
        List<dynamic> listSections = data!['sections'];
        print('[[[[[[[[[[[[[');
        return Scaffold(
          appBar: AppBar(
            title:  Text(LocaleKeys.CourseInformationTitleCourseDetails.tr()),
            actions: widget.fromInstructor?[
              CircleAvatar(
                backgroundColor: Colors.grey,
                radius: 15.h,
                child:  IconButton(icon:Icon(Icons.delete), onPressed: () {
                  _deleteCourse();
                },),
              )
            ]:[
              IconButton(
                icon: Icon(Icons.share),
                onPressed: () async {
                  try {
                    // Fetch the image URL
                    final urlImage = data!['thumbnail'];
                    final url = Uri.parse(urlImage);

                    // Download the image
                    final response = await http.get(url);
                    if (response.statusCode == 200) {
                      final bytes = response.bodyBytes;

                      // Get the temporary directory and save the image
                      final temp = await getTemporaryDirectory();
                      final filePath = '${temp.path}/image.jpg';
                      await File(filePath).writeAsBytes(bytes);

                      // Share the image and text
                      await Share.shareFiles(
                        [filePath],
                        text: 'Let\'s Learn ${data!['title']} with instructor ${data!['instructor']['name']} #E_Learning',
                      );
                    } else {
                      // Handle error while downloading the image
                      Fluttertoast.showToast(
                        msg: "Failed to download the image.",
                        toastLength: Toast.LENGTH_SHORT,
                        gravity: ToastGravity.BOTTOM,
                        timeInSecForIosWeb: 5,
                        backgroundColor: Colors.red,
                        textColor: Colors.white,
                        fontSize: 16.0,
                      );
                    }
                  } catch (e) {
                    // Handle any errors during the process
                    Fluttertoast.showToast(
                      msg: "Error: $e",
                      toastLength: Toast.LENGTH_SHORT,
                      gravity: ToastGravity.BOTTOM,
                      timeInSecForIosWeb: 5,
                      backgroundColor: Colors.red,
                      textColor: Colors.white,
                      fontSize: 16.0,
                    );
                  }
                },
              ),
              const SizedBox(width: 4),

            ],
          ),
          body: Padding(
            padding: EdgeInsets.all(8.0.r),
            child: Column(
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        VideoPlayerScreen(videoUrl: videoURL,),
                        SizedBox(height: 20.h),
                        Text('${data!['title']}',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 25.sp,
                          ),
                        ),
                        SizedBox(height: 5.h),
                        Text('${data!['subTitle']}',
                          style: TextStyle(
                            fontSize: 20.sp,
                          ),),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            for (int i = 0; i <rating ; i++)
                              const Icon(Icons.star, color: Colors.yellow),
                            for (int i = rating; i < 5; i++)
                              const Icon(Icons.star_border, color: Colors.yellow),
                            SizedBox(width: 5.w),
                            Text('${data!['ratingsAverage']}'),
                            SizedBox(width: 5.w),
                          ],
                        ),
                        SizedBox(height: 5.h),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            SizedBox(width: 5.w),
                             Text('${noOfStudents.length} ${LocaleKeys.CourseInformationstudentsratings.tr()}'),
                            SizedBox(width: 5.w),
                          ],
                        ),
                        SizedBox(height: 10.h),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            SizedBox(width: 5.w),
                             Text(LocaleKeys.CourseInformationCreatedby.tr()),
                            TextButton(
                              child: Text(' ${data!['instructor']['name']}',
                              style: const TextStyle(
                                  color: Colors.blue
                              )), onPressed: () {
                                Navigator.push(context, MaterialPageRoute(builder: (ctx){
                                  return ProfilePage(id: data!['instructor']['_id'],);
                                }));
                            },
                            ),
                            SizedBox(width: 5.w),
                          ],
                        ),
                        SizedBox(height: 5.h),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                             Text( LocaleKeys.CourseInformationLanguage.tr()),
                            SizedBox(width: 5.w),
                            Text('${data!['language']}'),
                            SizedBox(width: 5.w),
                            const Icon(Icons.language),
                            SizedBox(width: 5.w),
                          ],
                        ),
                        SizedBox(height: 20.h),
                        Row(
                          children: [
                            const Spacer(),
                            GestureDetector(
                              onTap: (){
                                print('hhhhhhhhhhhhhhhhhhelo');
                                _addAndRemoveCourseFromWishList();
                              },
                              child: Container(
                                width: 160.w,
                                height: 40.h,
                                decoration:  BoxDecoration(
                                    color: Colors.green
                                ),
                                child:  Center(child: Text(LocaleKeys.CourseInformationAddtowishlist.tr())),
                              ),
                            ),
                            SizedBox (width: 2.w,),
                            GestureDetector(
                        onTap: () {
                          setState(() {
                            if(widget.fromInstructor){

                            _showBottomSheet(context);
                            }else{
                              Navigator.of(context).push(MaterialPageRoute(builder: (context){
                                return SelectPayment(courseID : widget.courseId,
                                  coursePrice: ' ${data!['price']['amount']}',);
                              }));
                            }
                          });
                        },
                        child: Container(
                          width: 160.w,
                          height: 40.h,
                          decoration:  BoxDecoration(
                            color: Colors.green,
                          ),
                          child: widget.fromInstructor? Center(child: Text(LocaleKeys.CourseInformationMakeCoupon.tr())):
                          Center(child: Text(LocaleKeys.CourseInformationAddCoupon.tr())),
                        ),
                      ),
                            const Spacer(),
                          ],
                        ),
                        if (isAddCoubon)
                          Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Row(
                              children: [
                                       Text('${LocaleKeys.CourseInformationyourcouponis.tr()} $codeOfCoupon'),
                              ],
                            ),
                          ),
                        SizedBox(height: 20.h),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            SizedBox(width: 5.w),
                            Text(LocaleKeys.CourseInformationWhatyoulearn.tr(),
                              style: TextStyle(
                                  fontSize: 20.sp,
                                  fontWeight: FontWeight.bold
                              ),
                            ),
                            SizedBox(width: 5.w),
                          ],
                        ),
                        SizedBox(height: 10.h),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            SizedBox(width: 5.w),
                            Flexible( // Wrap the Text widget with Flexible
                              child: Text('${data!['whatWillBeTaught']}',
                                style: TextStyle(
                                  fontSize: 15.sp,
                                ),
                                maxLines: 5,
                                overflow: TextOverflow.ellipsis,
                              )
                            ),

                            SizedBox(width: 5.w),
                            const Icon(Icons.done),
                            SizedBox(width: 5.w),
                          ],
                        ),
                        SizedBox(height: 10.h),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            SizedBox(width: 5.w),
                            Text(LocaleKeys.CourseInformationCurriculum.tr(),
                              style: TextStyle(
                                  fontSize: 20.sp,
                                  fontWeight: FontWeight.bold
                              ),
                            ),
                            SizedBox(width: 5.w),
                          ],
                        ),
                        SizedBox(height: 10.h),
                        SingleChildScrollView(
                          child: ListView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: listSections.length,
                            itemBuilder: (context, index) {
                              print('from info ${listSections.length}');
                              return Accordion(
                                rightIcon:  Padding(
                                  padding: EdgeInsets.all(8.0),
                                  child: Icon(Icons.keyboard_arrow_down_rounded,),
                                ),
                                headerBackgroundColor: Colors.green,
                                contentBackgroundColor: Colors.teal,
                                paddingListTop: 0,
                                paddingListBottom: 0,
                                children: [
                                  AccordionSection(
                                    header: SizedBox(
                                      height: MediaQuery.of(context).size.height * 0.05,
                                      child: Row(
                                        children: [
                                          Padding(
                                            padding: EdgeInsets.only(left: 10),
                                            child: Text(
                                              '${data!['sections'][index]['title']}',
                                              style: const TextStyle(
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    content:modules( data!['sections'][index]) ,
                                  ),
                                ],
                              );
                            },
                          ),
                        ),
                        SizedBox(height: 10.h),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            SizedBox(width: 5.w),
                            Text(LocaleKeys.CourseInformationRequirements.tr(),
                              style: TextStyle(
                                  fontSize: 20.sp,
                                  fontWeight: FontWeight.bold
                              ),
                            ),
                            SizedBox(width: 5.w),
                          ],
                        ),
                        SizedBox(height: 10.h),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            SizedBox(width: 5.w),
                            Flexible( // Wrap the Text widget with Flexible
                                child: Text('${data!['requirements']}',
                                  style: TextStyle(
                                    fontSize: 15.sp,
                                  ),
                                  maxLines: 10,
                                  overflow: TextOverflow.ellipsis,
                                )
                            ),

                          ],
                        ),
                        SizedBox(height: 10.h),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            SizedBox(width: 5.w),
                            Text(LocaleKeys.CourseInformationTargetAudience.tr(),
                              style: TextStyle(
                                  fontSize: 20.sp,
                                  fontWeight: FontWeight.bold
                              ),
                            ),
                            SizedBox(width: 5.w),
                          ],
                        ),
                        SizedBox(height: 10.h),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            SizedBox(width: 5.w),
                            Flexible( // Wrap the Text widget with Flexible
                                child: Text('${data!['targetAudience']}',
                                  style: TextStyle(
                                    fontSize: 15.sp,
                                  ),
                                  maxLines: 25,
                                  overflow: TextOverflow.ellipsis,
                                )
                            ),

                          ],
                        ),
                        SizedBox(height: 10.h),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            SizedBox(width: 5.w),
                            Text(LocaleKeys.CourseInformationDescription.tr(),
                              style: TextStyle(
                                  fontSize: 20.sp,
                                  fontWeight: FontWeight.bold
                              ),
                            ),
                            SizedBox(width: 5.w),
                          ],
                        ),
                        SizedBox(height: 10.h),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            SizedBox(width: 5.w),
                            Flexible( // Wrap the Text widget with Flexible
                                child: Text('${data!['courseDescription']}',
                                  style: TextStyle(
                                    fontSize: 15.sp,
                                  ),
                                  maxLines: 25,
                                  overflow: TextOverflow.ellipsis,
                                )
                            ),

                          ],
                        ), // Add other sections/widgets as needed
                        SizedBox(height: 10.h),
                        if(reve.isNotEmpty )
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            SizedBox(width: 5.w),
                            Text(LocaleKeys.CourseInformationReviews.tr(),
                              style: TextStyle(
                                  fontSize: 20.sp,
                                  fontWeight: FontWeight.bold
                              ),
                            ),
                            SizedBox(width: 5.w),
                          ],
                        ),
                        if(reve.isNotEmpty)
                        SizedBox(height: 10.h),
                        if(reve.isNotEmpty)
                        Container(
                      height: reviews.length > 3 ? 360.0:200.0,

                      child:ListView.separated(
                          itemCount: reviews.length,
                          scrollDirection: Axis.vertical,

                          itemBuilder: (context,index){
                            //Product prod = products[index];

                            ReviewModel review = reviews[index];
                            //final buttonData = categoryData[index];
                            return  Card(
                              margin: EdgeInsets.all(10),
                              elevation: 5,
                              child: Padding(
                                padding: EdgeInsets.all(15),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Row(
                                      children: <Widget>[
                                        CircleAvatar(
                                          backgroundImage: NetworkImage(review.imageUrl),
                                          radius: 20,
                                        ),
                                        SizedBox(width: 10),
                                        Text(
                                          review.name,
                                          style: TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        Spacer(),
                                        for (int i = 0; i <(review.rating).round() ; i++)
                                          const Icon(Icons.star, color: Colors.yellow),
                                        for (int i = (review.rating).round(); i < 5; i++)
                                          const Icon(Icons.star_border, color: Colors.yellow),
                                        Text(
                                          '${review.rating}',
                                          style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: 10),
                                    Text(
                                      review.comment,
                                      style: TextStyle(
                                        fontSize: 16,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            )
                            ;
                          },

                          separatorBuilder: (context,  index) =>SizedBox(
                            width: 20.0,
                          ),
                        )),
                        if(reve.isNotEmpty)
                        SizedBox(height: 10.h),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            SizedBox(width: 5.w),
                            Text(LocaleKeys.CourseInformationsuggestion.tr(),
                              style: TextStyle(
                                  fontSize: 20.sp,
                                  fontWeight: FontWeight.bold
                              ),
                            ),
                            SizedBox(width: 5.w),
                          ],
                        ),
                        SizedBox(height: 10.h),
                        Container(
                          height: 360.0,
                          child: ListView.separated(
                            itemCount: products.length,
                            scrollDirection: Axis.horizontal,

                            itemBuilder: (context,index){
                              Product prod = products[index];
                              //final buttonData = categoryData[index];
                              return InkWell(
                                onTap: () {
                                  // Handle the tap event here
                                  print('heloo prod = ${prod.id}');
                                 Navigator.push(context, MaterialPageRoute(builder: (ctx){
                                   return   CourseInformation(courseId: prod.id,fromInstructor: false,);
                                     //Get.to(CourseInformation(courseId: prod.id,fromInstructor: false,));

                                 }));
                                },
                                child: /*ProductListItem(product: product)*/Container(
                                  child: SingleChildScrollView(
                                    child: Column(
                                      mainAxisAlignment:MainAxisAlignment.start,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Image.network(prod.imageURL,width:300 ,)
                                       , SizedBox(height: 5.h)
                                        ,Text(
                                          prod.title,
                                          style: TextStyle(
                                            fontSize: 20.0,
                                            fontWeight: FontWeight.bold,
                                          ),
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                        SizedBox(height: 5.h),
                                        Row(
                                          children: [
                                            Text('${prod.price['currency']} ${prod.price['amount']}'
                                            ),
                                       SizedBox(width: 80.w,),
                                       //    Spacer(),
                                           for (int i = 0; i < prod.rating.round(); i++)
                                              Icon(Icons.star, color: Colors.yellow),
                                           for (int i = prod.rating.round(); i < 5; i++)
                                              Icon(Icons.star_border, color: Colors.yellow),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            },

                            separatorBuilder: (context,  index) =>SizedBox(
                              width: 20.0,
                            ),
                          ),
                        ),
                        SizedBox(height: 50.h),
                        /*
                       if(data!['category']!=null)
                         suggestion(data!['category'])*/
                      ],
                    ),
                  ),
                ),
               if(widget.fromInstructor)
                 Row(
                  children: [
                    Container(
                      width: 150.w,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20.0.r),
                        color: TColors.secondray,
                      ),
                      child: MaterialButton(
                        child:  Text(
                          LocaleKeys.CourseInformationUpdate.tr(),
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20.0,
                          ),
                        ),
                        onPressed: () {
                          print('');
                       Navigator.of(context).push(MaterialPageRoute(builder: (context){
                            return UpdateCourse(courseID:data!['_id'] ,);
                          }));
                        },
                      ),
                    ),
                    Spacer(),
                    Container(
                      width: 150.w,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20.0.r),
                        color: TColors.secondray,
                      ),
                      child: MaterialButton(
                        child:  Text(
                          LocaleKeys.CourseInformationPublish.tr(),
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20.0,
                          ),
                        ),
                        onPressed: () {
                             print('from courseInfo ${data}');
                             _publishCourse();
                          },
                      ),
                    )
                  ],
                ),
                if(widget.fromInstructor == false)
                  if(!enrolledourses.contains(data!['_id']))
                    Row(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "${data!['price']['currency']} ${data!['price']['amount']}",
                            style: TextStyle(
                                fontSize: 16.h,
                                fontWeight: FontWeight.bold),
                          ),
                                ],
                      ),
                      Spacer(),
                      Container(
                        width: 220.w,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20.0.r),
                          color: TColors.secondray,
                        ),
                        child: MaterialButton(
                          child:  Text(
                            LocaleKeys.CourseInformationEnrollNow.tr(),
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 20.0,
                            ),
                          ),
                          onPressed: () {
                            print('price ${ data!['price']['currency']} ${data!['price']['amount']}');
                            /*  Get.to(SelectPayment(courseID : widget.courseId,
                        /*${data!['price']['currency']}*/
                            coursePrice: '${data!['price']['currency']} ${data!['price']['amount']}',));
                        */ Navigator.of(context).push(MaterialPageRoute(builder: (context){
                              return SelectPayment(courseID : widget.courseId,
                                coursePrice: ' ${data!['price']['amount']}',);
                            }));
                          },
                        ),
                      )
                    ],
                  ),

                if(widget.fromInstructor == false)
                  if(enrolledourses.contains(data!['_id']))
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [

                        Expanded(
                          child: Container(
                            width: 300.w,
                          
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20.0.r),
                              color: TColors.secondray,
                            ),
                            child: MaterialButton(
                              child:  Text(
                                "Get Started",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20.0,
                                ),
                              ),
                              onPressed: () {


                                Navigator.of(context).push(MaterialPageRoute(builder: (context){
                                  return CourseContent(courseId: data!['_id'], );
                                }));
                              },
                            ),
                          ),
                        )
                      ],
                    ),
              ],
            ),
          ),
        );
      } else {
        return Scaffold(
          appBar: AppBar(
            title:  Text(LocaleKeys.CourseInformationTitleCourseDetails.tr()),
          ),
          body:  Center(
            child: Text(LocaleKeys.CourseInformationNodataavailable.tr()),
          ),
        );
      }
    }
  }

  Widget modules(dynamic serverData){
    List<ModuleModel> module = ModuleModel.parseModuleFromServer(serverData!);

    print('modulessss]]]]]]]]]]sssssss = ${module}');
    return ListView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: module.length ,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween, // Aligns children at the start and end of the row
              children: [
                Flexible(
                  child: Text(
                    '${module[index].name}',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                TextButton(onPressed: ()async{
                  //VideoPreview
                  if(module[index].isFree){
                    await _getModule(module[index].id );
                    Navigator.of(context).push(MaterialPageRoute(builder: (context){
                      return VideoPreview(videoUrl:path,) ;
                    }));
                    //Get.to(VideoPreview(videoUrl:path,));
                  }
                }, child: module[index].isFree?Text('Preview',
                 style: TextStyle(
                   color: Colors.white
                 ),
                ):Container()
                )
              ],
            )
            ,
          )
          ;
        }
    );
  }
  Widget suggestion(String categoryId){
    print('category id = $categoryId');
    //_allCoursesByCategory(categoryId);
    //print('category id = $products');
    return Container(
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        physics: NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemCount: 5,
        itemBuilder: (context, index) {
          return InkWell(
            onTap: () {
              // Handle the tap event here

             // Get.to(CourseInformation(courseId: products[index].id,fromInstructor: false,));

            },
            child: /*ProductListItem(product: product)*/Container(
              child: Text('mosalam'),
            ),
          );
        },
        separatorBuilder: (context, index) => Divider(),
      ),
    );
  }

  final _exContoller = TextEditingController();
  final _discountContoller = TextEditingController();
  final _maximumUserContoller = TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  void _showBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
          // You can customize the content of your bottom sheet here
          padding: EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                ListTile(
                  title: Text(LocaleKeys.CourseInformationMakeCoupon.tr()
                    ,style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  onTap: () {
                    // Handle share action
                    Navigator.pop(context); // Close the bottom sheet
                  },
                ),
                Expanded(
                  child: TextFormField(
                    controller: _exContoller,
                    decoration:  InputDecoration(
                      labelText: '${LocaleKeys.EnterExYYYYmmdd.tr()}',
                      labelStyle: TextStyle(
                        fontSize: 25.0,
                      ),
                      border: OutlineInputBorder(),
                      prefixIcon: Icon(
                        Icons.date_range,
                      ),
                    ),
                    textAlign: TextAlign.start,
                    keyboardType: TextInputType.datetime,
                    onFieldSubmitted: (value) {},
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return '${LocaleKeys.Expireisrequired.tr()}';
                      }
                      return null;
                    },
                  ),
                ),
                Expanded(
                  child: TextFormField(
                    controller: _discountContoller,
                    decoration:  InputDecoration(
                      labelText: '${LocaleKeys.PercentageofDiscount1100.tr()}',
                      labelStyle: TextStyle(
                        fontSize: 25.0,
                      ),
                      border: OutlineInputBorder(),
                      prefixIcon: Icon(
                        Icons.percent,
                      ),
                    ),
                    textAlign: TextAlign.start,
                    keyboardType: TextInputType.number,
                    onFieldSubmitted: (value) {},
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return '${LocaleKeys.Discountisrequired.tr()}';
                      }
                      return null;
                    },
                  ),
                ),
                Expanded(
                  child: TextFormField(
                    controller: _maximumUserContoller,
                    decoration:  InputDecoration(
                      labelText: '${LocaleKeys.EnterMaxnumberofusers.tr()}',
                      labelStyle: TextStyle(
                        fontSize: 25.0,
                      ),
                      border: OutlineInputBorder(),
                      prefixIcon: Icon(
                        Icons.numbers,
                      ),
                    ),
                    textAlign: TextAlign.start,
                    keyboardType: TextInputType.number,
                    onFieldSubmitted: (value) {},
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return '${LocaleKeys.Maxisrequired.tr()}';
                      }
                      return null;
                    },
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    if(_formKey.currentState!.validate()){
                      _makeCoupon();
                      Navigator.pop(context);
                    }
                  },
                  child: Container(
                    width: 240.w,
                    height: 40.h,
                    decoration: const BoxDecoration(
                      color: Colors.green,
                    ),
                    child: Center(child: Text(LocaleKeys.CourseInformationApply.tr())),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class VideoPlayerScreen extends StatefulWidget {
  final String videoUrl;

  const VideoPlayerScreen({Key? key, required this.videoUrl}) : super(key: key);

  @override
  _VideoPlayerScreenState createState() => _VideoPlayerScreenState();
}

class _VideoPlayerScreenState extends State<VideoPlayerScreen> {
  late VideoPlayerController _controller;
  bool _isPlaying = false;
  bool _isVertical = false;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.network(widget.videoUrl)
      ..initialize().then((_) {
        setState(() {});
      });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return _controller.value.isInitialized
        ? Center(
      child: AspectRatio(
        aspectRatio: _controller.value.aspectRatio,
        child: Stack(
          alignment: Alignment.bottomCenter,
          children: [
            RotatedBox(
              quarterTurns: _isVertical ? 3 : 0,
              child: VideoPlayer(_controller),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  icon: Icon(_isPlaying ? Icons.pause : Icons.play_arrow),
                  onPressed: () {
                    setState(() {
                      _isPlaying ? _controller.pause() : _controller.play();
                      _isPlaying = !_isPlaying;
                    });
                  },
                ),
                IconButton(
                  icon: Icon(Icons.fast_rewind),
                  onPressed: () {
                    _controller.seekTo(_controller.value.position - Duration(seconds: 10));
                  },
                ),
                IconButton(
                  icon: Icon(Icons.fast_forward),
                  onPressed: () {
                    _controller.seekTo(_controller.value.position + Duration(seconds: 10));
                  },
                ),
                IconButton(
                  icon: Icon(_isVertical ? Icons.rotate_90_degrees_ccw : Icons.rotate_90_degrees_cw),
                  onPressed: () {
                    _controller.pause();
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => VideoPlayFullScreenRotated(videoUrl: widget.videoUrl),
                      ),
                    );
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    )
        : Center(
      child: CircularProgressIndicator(),
    );
  }

}