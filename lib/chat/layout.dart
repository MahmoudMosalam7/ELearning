
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:iconsax/iconsax.dart';

import 'home/chat_home_screen.dart';
import 'home/contact_home_screen.dart';
import 'home/groube_home_screen.dart';
import 'home/setting_home_screen.dart';

class layout extends StatefulWidget{
  @override
  State<layout> createState() => _layoutState();
}

class _layoutState extends State<layout> {
  @override
  int currentindex=0;
  PageController pageController=PageController();

  Widget build(BuildContext context) {
List<Widget>screens=[
  
];
return Scaffold(
  body: PageView(
        onPageChanged: (value) {
          setState(() {
            currentindex = value;
          });
        },
        controller: pageController,
        children:  [
          ChatHomeScreen(email: '',),
          GroupHomeScreen(),
          ContactHomeScreen(),
          SettingHomeScreen()

    ],
  ),
  bottomNavigationBar: NavigationBar(
        elevation: 0,
        selectedIndex: currentindex,
        onDestinationSelected: (value) {
          setState(() {
            currentindex = value;
            pageController.jumpToPage(value);
          });
        },
        destinations: const [
          NavigationDestination(icon: Icon(Iconsax.message), label: "Chat"),
          NavigationDestination(icon: Icon(Iconsax.messages), label: "Group"),
          NavigationDestination(icon: Icon(Iconsax.user), label: "Contacts"),
          NavigationDestination(icon: Icon(Iconsax.setting), label: "Setting"),
        ],
      ),
    
);
  }
}