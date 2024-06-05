import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:learning/shared/constant.dart';

import '../../../../chat/home/chat_home_screen.dart';
import 'instructor_dashboard.dart';
import 'instructors_chats.dart';

class InstructorHomeScreen extends StatefulWidget {
  const InstructorHomeScreen({super.key});

  @override
  State<InstructorHomeScreen> createState() => _InstructorHomeScreenState();
}

class _InstructorHomeScreenState extends State<InstructorHomeScreen> {
  int _currentIndex = 0;
  final List<Widget> _instructorScreens = [
    InstructorCourses(),
    ChatHomeScreen(email: getData!['data']['email'],)
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _instructorScreens[_currentIndex],
      bottomNavigationBar:  BottomNavigationBar(

        // to make the size of each item in the items list fixid
        type: BottomNavigationBarType.fixed,
        currentIndex: _currentIndex,
        // to switch between the button of BottomNAvigatioBar
        //Notes not switch between the body of each page inside the
        // BottomNAvigatioBar
        onTap: (index){
          setState(() {
            _currentIndex = index;
          });
        },
        //this list of all page that we want to switch between them
        items: const [

          // this item for the Courses page
          BottomNavigationBarItem(
            // the icon of the Courses page
            icon: Icon( Icons.dashboard_customize_rounded),
            // to do the name of the Courses page
            label:'Dashboard',
          ),
          // this item for the Chats page
          BottomNavigationBarItem(
            // the icon of the Chats page
            icon: Icon( Icons.chat),
            // to do the name of the Chats page
            label:'Chats',
          ),

        ],
        selectedItemColor: Colors.green, // Change this color to your preference
        unselectedItemColor: Colors.grey,
      ),
    );
  }
}
