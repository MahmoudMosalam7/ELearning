import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:learning/network/local/cache_helper.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:easy_localization/easy_localization.dart';
import '../../translations/locale_keys.g.dart';
import '../MainBottomNavigationBar.dart';
import 'Login.dart';

class Onboarding extends StatefulWidget{
  @override
  State<Onboarding> createState() => _OnboardingState();
}
//LocaleKeys.Settingupdatepassword.tr()

class _OnboardingState extends State<Onboarding> {
  @override
  PageController _controller=PageController();
  bool onlastpage =false;

  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
          children: [
            PageView(
              controller: _controller,
              onPageChanged: (index){
                setState(() {
                  onlastpage=(index==2);
                });
              },
              children: [

            Container(
            color: Color(0xff5b7763),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Center(
              child: DefaultTextStyle(
                style: TextStyle(
                  fontSize: 30.0,
                  color: Colors.white,
                ),
                child: AnimatedTextKit(
                  totalRepeatCount: 1,
                  animatedTexts: [
                    RotateAnimatedText(
                      LocaleKeys.OnBoardingHellotoElearning.tr(),
                      rotateOut: false,
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 20), // Add some space between the text and the image
            Image(image: AssetImage('assets/images/onboarding_new_account/Hi.png'),width: 300.h,height:300.h ,),
          ],
        ),
      ),
    ),

                Container(
                  color: Color(0xff5b7763),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      DefaultTextStyle(
                        style: TextStyle(
                          fontSize: 30.0,
                          color: Colors.white,
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(15.0),
                          child: Center(
                            child: AnimatedTextKit(
                              repeatForever: false,
                              totalRepeatCount: 1,
                              animatedTexts: [
                                TyperAnimatedText(
                                  LocaleKeys.OnBoardingWelcometoLearningInthisapp.tr(),
                                  speed: Duration(milliseconds: 50),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 20), // Add some space between the text and the image
                      Image(
                        image: AssetImage('assets/images/onboarding_new_account/Welcome.png'),
                        width: 300,
                        height: 300,
                      ),
                    ],
                  ),
                ),

                Container(
                  color: Color(0xff5b7763),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      AnimatedTextKit(
                        repeatForever: false,
                        totalRepeatCount: 1,
                        animatedTexts: [
                          WavyAnimatedText(
                            LocaleKeys.OnBoardingLetsGo.tr(),
                            textStyle: TextStyle(
                              color: Colors.white,
                              height: 0.8,
                              fontSize: 50.0,
                            ),
                            speed: Duration(milliseconds: 400),
                          ),
                        ],
                      ),
                      SizedBox(height: 20), // Add some space between the text and the image
                      Image(
                        image: AssetImage('assets/images/onboarding_new_account/letsgo.png'),
                        width: 150,
                        height: 150,
                      ),
                    ],
                  ),
                ),

              ],
            ),
            /**************************************************** */
            Container(
                alignment: Alignment(0,0.75),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [

                    GestureDetector(
                        onTap: () {

                          /*CacheHelper.saveData(key: 'onBoarding', value: true).
                          then((value) {
                            print('value when Save OnBoarding');
                            if(value){
                              Navigator.of(context).pushReplacement(MaterialPageRoute
                                (builder: (context)=>HomeLayout()));
                            }
                          });*/
                          String? token = CacheHelper.getData(key: 'token');
                          if (token != null) {
                            Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => HomeLayout()));
                          } else {
                            Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => Login()));
                          }
                        },
                        child: Text(LocaleKeys.OnBoardingskip.tr(),
                          style: TextStyle(
                              color: Colors.white
                          ),
                        )),

                    SmoothPageIndicator(
                      controller: _controller,
                      count: 3,
                      effect:SwapEffect(
                          activeDotColor: Colors.white
                      ) ,
                    ),
                    onlastpage?

                    GestureDetector(

                        onTap: (){
/*                          CacheHelper.saveData(key: 'onBoarding', value: true).
                          then((value) {
                            print('value when Save OnBoarding');
                            if(value){
                              Navigator.of(context).pushReplacement(MaterialPageRoute
                                (builder: (context)=>HomeLayout()));
                            }
                          });*/
                          String? token = CacheHelper.getData(key: 'token');
                          if (token != null) {
                            Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => HomeLayout()));
                          } else {
                            Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => Login()));
                          }

                        },
                        child: Text(LocaleKeys.OnBoardingsdone.tr(),
                          style: TextStyle(
                              color: Colors.white
                          ),))
                        : GestureDetector(
                        onTap: (){
                          _controller.nextPage(
                              duration: Duration(milliseconds: 500),
                              curve: Curves.easeIn
                          );
                        },
                        child: Text(LocaleKeys.OnBoardingsnext.tr(),
                          style: TextStyle(
                              color: Colors.white
                          ),)),

                  ],
                )
            )
          ],
        )
    );
  }
}