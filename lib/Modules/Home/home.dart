import 'package:carousel_slider/carousel_slider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:learning/Modules/Home/searchBar/search_bar.dart';
import 'package:learning/TColors.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../apis/courseInformation/http_service_courseInformation.dart';
import '../../apis/user/http_service_get_user_data.dart';
import '../../chat/firebase/fire_auth.dart';
import '../../chat/home/chat_home_screen.dart';
import '../../network/local/cache_helper.dart';
import '../../shared/constant.dart';
import '../../shared/constant.dart';
import '../../shared/constant.dart';
import 'InformationOFCourses/CourseInformation.dart';
import 'Product.dart';
import '../../models/listView_Courses.dart';
import 'listView_category.dart';

class HomeScreen extends StatefulWidget {
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final HttpServiceGetData httpServiceGetData = HttpServiceGetData();
  var im ;
  bool? darkMode = false;
  void initState(){
    fetchData();
    _allCourses();
    fetchDataOfUser();
    darkMode = CacheHelper.getData(key: 'darkMode');
    if (darkMode == null)
      darkMode = false ;
    super.initState();
  }
  final HttpServiceGetData httpServiceGetDataOFUser = HttpServiceGetData();

  Future<void> fetchDataOfUser() async {
    try {
      String? token = CacheHelper.getData(key:'token');
      // Call getData method with the authentication token
      Map<String, dynamic> data = await httpServiceGetDataOFUser.getData(token!);

      // Update the state with the fetched data
      setState(() {
        getData = data;
        im = getData?['data']['profileImage'];
        print('im = $im');
      });

      // Print or use the fetched data as needed
      print('Fetched Data1: $getData');
    } catch (e) {
      // Handle errors, if any
      print('Error fetching data: $e');
    }
  }
  Future<void> fetchData() async {
    try {
      String? token = CacheHelper.getData(key:'token');
      // Call getData method with the authentication token
      Map<String, dynamic> data = await httpServiceGetData.getData(token!);

      // Update the state with the fetched data
      setState(() {
        getData = data;
        im = getData?['data']['profileImage'];
        print('im = $im');
      });
      await FirebaseAuth.instance.currentUser!.updateDisplayName(data['data']['name'])
          .then((value) {
        // تحديث اسم العرض ثم إعادة تحميل بيانات المستخدم
        FirebaseAuth.instance.currentUser!.reload().then((_) {
          // التحقق من تحديث اسم العرض بنجاح
          if (FirebaseAuth.instance.currentUser!.displayName == data['data']['name']) {
            // إنشاء ملف تعريف المستخدم
            FireAuth.createUser();
          }
        });
      });
      // Print or use the fetched data as needed
      print('Fetched Data2: $getData');
    } catch (e) {
      // Handle errors, if any
      print('Error fetching data: $e');
    }
  }
  final myImages = [
    Image.asset('assets/images/image_home_slider/photo1.jpg'),
    Image.asset('assets/images/image_home_slider/photo2.jpeg'),
    Image.asset('assets/images/image_home_slider/photo3.jpeg'),
  ];

  int imageIndex = 0;
  HttpServiceCourse httpServiceCourse = HttpServiceCourse();
   late Map<String,dynamic> serverData ;
  String errorMessage = '';
  bool isLoading = false;

  List<Product> products = [];
  void _allCourses() async {
    // Reset error message and loading state
    setState(() {
      errorMessage = '';
      isLoading = true;
    });

    try {
      // Add your login logic here, e.g., make API call
      serverData = await httpServiceCourse.allCourses(
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
  void _allCoursesByCategory(String categoryId) async {
    // Reset error message and loading state
    setState(() {
      errorMessage = '';
      isLoading = true;
    });

    try {
      // Add your login logic here, e.g., make API call
      serverData = await httpServiceCourse.allCoursesByCategories(
          CacheHelper.getData(key: 'token'),
        categoryId
      );

      print('get all course by category successful! $serverData');

      if (serverData != null) {
        print('serverdata from category = ${Product.parseProductsFromServer(serverData)}');
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

  //List<Product> products = []; //products = Product.parseProductsFromServer(serverData!);
 String name = getData?['data']['name'];
  @override
  Widget build(BuildContext context) {
    print('hooooooooooooooooooooooooooooooooooooommmmmmmmmmmm');
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
            icon:  CircleAvatar(
              radius: 15.0,
              backgroundColor: Colors.grey,
              child: Icon(
                Icons.chat,
                size: 20.0,
                color:darkMode! ?Colors.white:Colors.black,
              ),
            ),
            onPressed: (){
             /* print()*/
              Get.to(ChatHomeScreen(email: getData!['data']['email'],));
            },
          ),
          IconButton(
            icon:  CircleAvatar(
              radius: 15.0,
              backgroundColor: Colors.grey,
              child: Icon(
                Icons.favorite,
                size: 20.0,
                color: darkMode! ?Colors.white:Colors.black,
              ),
            ),
            onPressed: (){
              fetchData();
              print('image = ${getData?['data']['profileImage']}');
            },
          ),
        ],

        title: Row(
          children: [
            CircleAvatar(
              radius: 20.0,
              backgroundImage: NetworkImage(
                getData?['data']['profileImage'] ?? 'assets/images/profile.png',
              ),
              child: getData?['data']['profileImage'] == null
                  ? ClipOval(
                child: Image.asset(
                  'assets/images/profile.png',
                  width: 40.0, // Set width to match the diameter of the CircleAvatar
                  height: 40.0, // Set height to match the diameter of the CircleAvatar
                  fit: BoxFit.cover,
                ),
              )
                  : null,
            ),
            const SizedBox(width: 15.0,),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Welcome,',
                    style: TextStyle(
                      fontSize: 15.0,
                      color: Colors.grey[400],
                    ),
                  ),
                  const SizedBox(height: 5.0,),
                   Text(
                     getData?['data']['name'],
                    style: TextStyle(
                      fontSize: 15.0,

                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),

      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // Search bar
                GestureDetector(
                  onTap: (){
                    Get.to(SearchBarContainer());
                  },
                  child: Container(
                    padding: EdgeInsets.all(5.0),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.0,),
                      color: Colors.grey,
                    ),
                    child: Row(
                      children: [
                        Icon(
                          Icons.search,
                        ),
                        SizedBox(width: 15.0,),
                        Text('Search'),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 20.0,),
                // Image Carousel
                CarouselSlider(
                  options: CarouselOptions(
                    // ... Carousel options ...
                    autoPlay: true,
                    autoPlayInterval: Duration(seconds: 2),
                    autoPlayAnimationDuration: Duration(milliseconds: 600),
                    autoPlayCurve: Curves.fastOutSlowIn,

                    onPageChanged: (index, reason) {
                      setState(() {
                        imageIndex = index;
                      });
                    },
                  ),
                  items: myImages,
                ),
                // Image Indicator
                AnimatedSmoothIndicator(
                  activeIndex: imageIndex,
                  count: myImages.length,
                  effect: WormEffect(
                    dotHeight: 8,
                    dotWidth: 8,
                    spacing: 5,
                    dotColor: Colors.grey.shade200,
                    activeDotColor: Colors.grey.shade500,
                    paintStyle: PaintingStyle.fill,
                  ),
                ),
                SizedBox(height: 20.0,),
                 Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Categories',
                      style:TextStyle(
                        fontSize: 25.0,
                        fontWeight: FontWeight.bold,

                      ) ,
                    ),
                    Spacer(),
                    TextButton(onPressed: (){
                      print("");
                    }, child:Text(
                      'See All',
                      style:TextStyle(
                        fontSize: 25.0,
                        color: Colors.grey,
                      ) ,
                    ),),
                  ],
                ),
                SizedBox(height: 20.0,),
                Container(
                  height: 40.0,
                  child: ListView.separated(
                        itemCount: categoryData.length,
                        scrollDirection: Axis.horizontal,

                        itemBuilder: (context,index){
                          final buttonData = categoryData[index];
                          return  ElevatedButton(

                          style: ElevatedButton.styleFrom(
                            side: BorderSide(
                              color: Colors.white, // Border color
                              width: 2.0, // Border thickness
                              style: BorderStyle.solid, // Border style (solid, dashed, etc.)
                            ),
                          ),
                            onPressed: () {
                              setState(() {// Change color on click
                                print('buttonData = $buttonData , ${buttonData.id}');
                                _allCoursesByCategory(buttonData.id);
                              });
                            },
                          child: Text(buttonData.text,
                           style:TextStyle(
                             color: Colors.green
                           ) ,
                          ),
                          );
                          },

                    separatorBuilder: (context,  index) =>SizedBox(
                      width: 20.0,
                    ),
                  ),
                ),
                SizedBox(height: 20.0,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Feature Courses',
                      style:TextStyle(
                        fontSize: 25.0,
                        fontWeight: FontWeight.bold,

                      ) ,
                    ),
                  ],
                ),
                SizedBox(height: 20.0,),
          Container(
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

                    Get.to(CourseInformation(courseId: products[index].id,fromInstructor: false,));

                  },
                  child: ProductListItem(product: product),
                );
              },
              separatorBuilder: (context, index) => Divider(height: 15.0),
            ),
          ),


          ],
            ),
          ),
        ),
      ),
    );
  }

}