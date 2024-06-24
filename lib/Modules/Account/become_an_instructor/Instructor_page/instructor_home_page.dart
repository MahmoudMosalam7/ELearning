import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:learning/shared/constant.dart';
import 'package:easy_localization/easy_localization.dart';
import '../../../../apis/update_instructor/http_service_courses.dart';
import '../../../../apis/update_instructor/http_service_update_instructor.dart';
import '../../../../chat/home/chat_home_screen.dart';
import '../../../../network/local/cache_helper.dart';
import '../../../../shared/constant.dart';
import '../../../../translations/locale_keys.g.dart';
import 'instructor_dashboard.dart';

class InstructorHomeScreen extends StatefulWidget {
  const InstructorHomeScreen({super.key});

  @override
  State<InstructorHomeScreen> createState() => _InstructorHomeScreenState();
}

class _InstructorHomeScreenState extends State<InstructorHomeScreen> {
  int _currentIndex = 0;

  late Future<Map<String, dynamic>> _instructorInfoFuture;
  HttpServiceUpdateInstructor httpServiceInstructor = HttpServiceUpdateInstructor();
  HttpServiceCoursesOfInstructor httpServiceCoursesOfInstructor = HttpServiceCoursesOfInstructor();

  late Map<String, dynamic> serverData;

  @override
  void initState() {
    super.initState();
    _instructorInfoFuture = _instructorInfo();
  }

  String errorMessage = '';
  bool isLoading = false;

  Future<Map<String, dynamic>> _instructorInfo() async {
    print('id of instructors = ${getData!['data']['_id']}');
    try {
      serverData = await httpServiceInstructor.getInstructorInfo(
        getData!['data']['_id'],
        CacheHelper.getData(key: 'token'),
      );
      print('Get instructor info successful! $serverData');
      return serverData;
    } catch (e) {
      _handleError(e);
      throw e;
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
      body: FutureBuilder<Map<String, dynamic>>(
        future: _instructorInfoFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator(color: Colors.green,));
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (snapshot.hasData) {
            var data = snapshot.data!;
            double students = (data['data']['results']['enrolledUsers'] as num).toDouble();
            double rating = (data['data']['results']['ratings'] as num).toDouble();

            final List<Widget> _instructorScreens = [
              InstructorCourses(students: students, rating: rating),
              ChatHomeScreen()
            ];

            return IndexedStack(
              index: _currentIndex,
              children: _instructorScreens,
            );
          } else {
            return Center(child: Text('No data available'));
          }
        },
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.dashboard_customize_rounded),
            label: LocaleKeys.InstructorInstructorHomeScreenDashboard.tr(),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.chat),
            label: LocaleKeys.InstructorInstructorHomeScreenChats.tr(),
          ),
        ],
        selectedItemColor: Colors.green,
        unselectedItemColor: Colors.grey,
      ),
    );
  }
}
