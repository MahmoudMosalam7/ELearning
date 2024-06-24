import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../../../apis/update_instructor/http_service_courses.dart';
import '../../../apis/update_instructor/http_service_update_instructor.dart';
import '../../../models/listView_Courses.dart';
import '../../../network/local/cache_helper.dart';
import '../../../translations/locale_keys.g.dart';
import '../Product.dart';
import 'CourseInformation.dart';

import 'package:easy_localization/easy_localization.dart';
class ProfilePage extends StatefulWidget {
  final String id;

  const ProfilePage({super.key, required this.id});
  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  HttpServiceUpdateInstructor httpServiceInstructor = HttpServiceUpdateInstructor();
  HttpServiceCoursesOfInstructor httpServiceCoursesOfInstructor = HttpServiceCoursesOfInstructor();

  late Map<String, dynamic> serverData;
  late Map<String, dynamic> serverData2;

  String errorMessage = '';
  bool isLoading = false;

  List<Product> products = [];

  @override
  void initState() {
    super.initState();
    _fetchData();
  }

  void _fetchData() async {
    setState(() {
      isLoading = true;
    });

    await _instructorInfo();
    //await _allCoursesOfInstructor();

    setState(() {
      isLoading = false;
    });
  }

  Future<void> _instructorInfo() async {
    try {
      serverData = await httpServiceInstructor.getInstructorInfo(
        widget.id,
        CacheHelper.getData(key: 'token'),
      );

      products = Product.parseProductsFromServer2(serverData);
      print('Products: $products');
          print('Get instructor info successful! $serverData');
    } catch (e) {
      _handleError(e);
    }
  }

  void _handleError(dynamic e) {
    setState(() {
      errorMessage = 'Error: $e';
      if (errorMessage.contains('422')) {
        errorMessage = "Validation Error!";
      } else if (errorMessage.contains('401')) {
        errorMessage = "Unauthorized access!";
      } else if (errorMessage.contains('500')) {
        errorMessage = "Server Not Available Now!";
      } else {
        errorMessage = "Unexpected Error!";
      }
      Fluttertoast.showToast(
        msg: errorMessage,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 5,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(LocaleKeys.ProfilePageTitle.tr()),
      ),
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
        child: Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Padding(
                padding: EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    CircleAvatar(
                      radius: 50.0,
                      backgroundImage: NetworkImage(
                        serverData['data']['results']['profile'] ?? 'https://via.placeholder.com/150',
                      ),
                    ),
                    SizedBox(height: 10.0),
                    Text(
                      '${serverData['data']['results']['name']}',
                      style: TextStyle(
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 5.0),
                    Text(
                      '${serverData['data']['results']['email']}',
                      style: TextStyle(
                        fontSize: 12.0,
                      ),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 5.0),
                        Text(
                          '${LocaleKeys.ProfilePageJobTitle.tr()} ${serverData['data']['results']['jobTitle']}',
                          style: TextStyle(
                            fontSize: 12.0,
                          ),
                        ),
                        SizedBox(height: 5.0),

                        Text(
                          '${LocaleKeys.ProfilePageJobDescription.tr()} ${serverData['data']['results']['jobDescription']}',
                          style: TextStyle(
                            fontSize: 12.0,
                          ),
                        ),
                        SizedBox(height: 5.0),
                        if(serverData['data']['results']['linkedinUrl']!=null)
                         Text(
                          '${LocaleKeys.ProfilePageLinkedIn.tr()} ${serverData['data']['results']['linkedinUrl']}',
                          style: TextStyle(
                            fontSize: 12.0,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          '${serverData['data']['results']['enrolledUsers']}',
                          style: TextStyle(
                            fontSize: 18.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          LocaleKeys.ProfilePageStudents.tr(),
                          style: TextStyle(
                            fontSize: 16.0,
                          ),
                        ),
                      ],
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Row(
                          children: [
                            for (int i = 0; i < serverData['data']['results']['ratings'].round(); i++)
                              Icon(Icons.star, color: Colors.yellow),
                            for (int i = serverData['data']['results']['ratings'].round(); i < 5; i++)
                              Icon(Icons.star_border, color: Colors.yellow),
                            Text(
                              '${serverData['data']['results']['ratings'].round()}',
                              style: TextStyle(
                                fontSize: 20.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                        Text(
                          LocaleKeys.ProfilePageCourseRatings.tr(),
                          style: TextStyle(
                            fontSize: 16.0,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              SingleChildScrollView(
                child: ListView.separated(
                  scrollDirection: Axis.vertical,
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: products.length,
                  itemBuilder: (context, index) {
                    final product = products[index];
                    return InkWell(
                      onTap: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context){
                          return CourseInformation(
                            courseId: products[index].id,
                            fromInstructor: false,
                          );
                        }));

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
    );
  }
}
