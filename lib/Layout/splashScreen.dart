import 'dart:async';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:learning/Layout/MainBottomNavigationBar.dart';
import 'package:learning/network/local/cache_helper.dart';
import 'package:lottie/lottie.dart';

import '../apis/edit_profile/http_service_edit_profile.dart';
import '../apis/user/http_service_get_user_data.dart';
import '../shared/constant.dart';
import 'Login_Register_ForgetPassword/Login.dart';

class Splash_Screen extends StatefulWidget {
  const Splash_Screen({super.key});

  @override
  State<Splash_Screen> createState() => _Splash_ScreenState();
}

class _Splash_ScreenState extends State<Splash_Screen> {
  final HttpServiceGetData httpService = HttpServiceGetData();

  Future<void> fetchData() async {
    try {
      String? token = CacheHelper.getData(key:'token');
      // Call getData method with the authentication token
      Map<String, dynamic> data = await httpService.getData(token!);

      // Update the state with the fetched data
      setState(() {
        getData = data;
      });

      // Print or use the fetched data as needed
      print('Fetched Data: $getData');
    } catch (e) {
      // Handle errors, if any
      print('Error fetching data: $e');
    }
  }

  @override
  void initState() {
    super.initState();
    initializeApp();
  }

  Future<void> initializeApp() async {
    Timer(
      const Duration(seconds: 3),
          () async {
        await CacheHelper.init();

        await fetchData(); // Wait for fetchData to complete

        print('from splash image = ${getData?['data']['profileImage']}');

        String? token = CacheHelper.getData(key: 'token');
        if (token != null) {
          Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => HomeLayout()));
        } else {
          Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => Login()));
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            const SizedBox( height: 70,),
            const Image(image: AssetImage('assets/images/app_icon/icons.png'),
              width: 100,
              height: 100,
            ),
            const SizedBox( height: 50,),
            Lottie.asset('assets/animation/animation_splash_screen/Animation.json'),
            const SizedBox( height: 50,),
            const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircularProgressIndicator(
                  color: Colors.blue,
                ),
                SizedBox( width: 30,),
                Text('Loading...',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 25.0,
                  color: Colors.blue,
                ),
                )
              ],
            ),



          ],

        ),
      ),

    );
  }
}
