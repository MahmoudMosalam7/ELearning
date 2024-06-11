import 'dart:async';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import 'package:learning/network/local/cache_helper.dart';
import 'package:lottie/lottie.dart';

import '../apis/user/http_service_get_user_data.dart';
import '../translations/locale_keys.g.dart';
import 'Login_Register_ForgetPassword/onboarding.dart';

class Splash_Screen extends StatefulWidget {
  const Splash_Screen({super.key});

  @override
  State<Splash_Screen> createState() => _Splash_ScreenState();
}

class _Splash_ScreenState extends State<Splash_Screen> {
  final HttpServiceGetData httpService = HttpServiceGetData();


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

        Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => Onboarding()));



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
             Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircularProgressIndicator(
                  color: Colors.blue,
                ),
                SizedBox( width: 30,),
                Text( LocaleKeys.SplashScreenLoading.tr(),
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
