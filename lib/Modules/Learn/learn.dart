import 'package:flutter/material.dart';
import '../../translations/locale_keys.g.dart';
import 'TabBar/AllCoursesPayed.dart'; // Import the file where All widget is defined

import 'package:easy_localization/easy_localization.dart';
class LearnScreen extends StatefulWidget {
  @override
  _LearnScreenState createState() => _LearnScreenState();
}

class _LearnScreenState extends State<LearnScreen> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

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
                Icons.search,
                size: 20.0,
              ),
            ),
            onPressed: () {
              // Add functionality for search button here
            },
          ),
        ],

        title:  Text(
          LocaleKeys.LearnScreenMyCourses.tr(),
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: All(),
    );
  }
}
