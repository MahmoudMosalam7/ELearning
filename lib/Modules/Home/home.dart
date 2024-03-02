import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:learning/TColors.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../apis/http_service_get_user_data.dart';
import '../../network/local/cache_helper.dart';
import '../../shared/constant.dart';
import 'InformationOFCourses/CourseInformation.dart';
import 'Product.dart';
import 'listView_Courses.dart';
import 'listView_category.dart';

class HomeScreen extends StatefulWidget {
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final HttpServiceGetData httpServiceGetData = HttpServiceGetData();
  var im ;
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

      // Print or use the fetched data as needed
      print('Fetched Data: $getData');
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
  List<CategoryData> categoryData = [
    CategoryData(text: 'Devleopment', color: Colors.white),
    CategoryData(text: 'Design', color: Colors.white),
    CategoryData(text: 'Tech', color: Colors.white),
    CategoryData(text: 'Marketing', color: Colors.white),
    CategoryData(text: 'Business', color: Colors.white),
    CategoryData(text: 'Sports', color: Colors.white),
    CategoryData(text: 'IT Software', color: Colors.white),
    CategoryData(text: 'Chemical', color: Colors.white),
    CategoryData(text: 'Physices', color: Colors.white),
    // Add more button data with text and color
  ];

  Color _borderColor = Colors.grey;
  List<Product> products = [
    Product(
      imageURL: 'https://th.bing.com/th/id/OIP.ysp1ApXWE38vAgTymEFbvgHaEK?rs=1&pid=ImgDetMain',
      name: 'Flutter & Dart Complete Development [2023] ',
      isFavorite: true,
      price: 10.99,
      rating: 4.5,
    ),
    Product(
      imageURL: 'https://online.crbtech.in/wp-content/uploads/2020/06/Online-AI-Machine-Learning-Course.jpg',
      name: 'Learn AI from Zero To Hero [2022]',
      isFavorite: false,
      price: 29.99,
      rating: 3.8,
    ),
    // Add more products...
  ];
 String name = getData?['data']['name'];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
            icon: const CircleAvatar(
              radius: 15.0,
              backgroundColor: Colors.grey,
              child: Icon(
                Icons.notification_important,
                size: 20.0,
              ),
            ),
            onPressed: (){
             /* print()*/
            },
          ),
          IconButton(
            icon: const CircleAvatar(
              radius: 15.0,
              backgroundColor: Colors.grey,
              child: Icon(
                Icons.favorite,
                size: 20.0,
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
                getData?['data']['profileImage'] ?? 'assets/images/profile.jpg',
              ),
              child: getData?['data']['profileImage'] == null
                  ? ClipOval(
                child: Image.asset(
                  'assets/images/profile.jpg',
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
                Container(
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
                          final buttonData = this.categoryData[index];
                          return  ElevatedButton(

                          style: ElevatedButton.styleFrom(
                          backgroundColor: buttonData.color,
                            side: BorderSide(
                              color: Colors.white, // Border color
                              width: 2.0, // Border thickness
                              style: BorderStyle.solid, // Border style (solid, dashed, etc.)
                            ),
                          ),
                            onPressed: () {
                              setState(() {
                                _borderColor = Colors.green; // Change color on click
                              });
                            },
                          child: Text(buttonData.text,
                           style:TextStyle(
                             color: Colors.black,
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
            height: 650,
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
                    Get.to(const CourseInformation());
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