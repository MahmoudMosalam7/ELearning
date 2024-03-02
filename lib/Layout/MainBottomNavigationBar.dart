import 'package:flutter/material.dart';
import 'package:learning/Modules/Account/account.dart';
import 'package:learning/Modules/Learn/learn.dart';
import 'package:learning/Modules/WishList/wishlist.dart';

import '../Modules/Home/home.dart';

class HomeLayout extends StatefulWidget
{
  const HomeLayout({super.key});

  @override
  _HomeLayout createState() => _HomeLayout();

}
// this class is main Layout for user
class _HomeLayout extends State<HomeLayout> {
  // this variable used to get the index of items and switch between them
  int _currentIndex = 0;
  // this list used to switch between the body of pages inside the
  //BottomNavigationBar
  final List<Widget> _screens = [
    HomeScreen(),
    LearnScreen(),
    const WishListScreen(),
    const AccountScreen(),
  ];


  // this list used to change the title of each page
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // we used this AppBar to contain the name of the page and tool of search

      //to switch between the body of each page
      body: _screens[_currentIndex],
      //this attribute used to create the BottomNavigationBar
      // and must take widget  BottomNavigationBar
      bottomNavigationBar: BottomNavigationBar(

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

          // this item for the home page
          BottomNavigationBarItem(
            // the icon of the home page
              icon: Icon( Icons.home),
              // to do the name of the home page
              label:'Home',
          ),
          // this item for the Learn page
          BottomNavigationBarItem(
            // the icon of the Learn page
            icon: Icon( Icons.collections_bookmark_outlined),
            // to do the name of the Learn page
            label:'Learn',
          ),
          // this item for the WishList page
          BottomNavigationBarItem(
            // the icon of the WishList page
            icon: Icon( Icons.favorite_border),
            // to do the name of the WishList page
            label:'WishList',
          ),
          // this item for the Account page
          BottomNavigationBarItem(
            // the icon of the Account page
            icon: Icon( Icons.account_circle),
            // to do the name of the Account page
            label:'Account',
          ),
        ],
        selectedItemColor: Colors.green, // Change this color to your preference
        unselectedItemColor: Colors.grey,
      ),
    );
  }
}
