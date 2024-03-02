import 'package:flutter/material.dart';
import 'TabBar/AllCoursesPayed.dart'; // Import the file where All widget is defined

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
        bottom: TabBar(
          controller: _tabController,
          indicatorColor: Colors.green,
        labelColor: Colors.green,
        // Set the color of the selected tab's text to black
          unselectedLabelColor: Colors.grey, // Set the color of unselected tabs' text to gray
          tabs: [
            Tab(
              text: 'All',
            ),
            Tab(
              text: 'Downloaded',
            ),
            Tab(
              text: 'Favorited',
            ),
          ],
        ),
        title: const Text(
          'My Courses',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          All(), // Assuming All widget is for the "All" tab
          Container(
            color: Colors.redAccent,
            child: const Icon(Icons.settings),
          ),
          Container(
            color: Colors.cyanAccent,
            child: const Icon(Icons.person),
          ),
        ],
      ),
    );
  }
}
