import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import '../../../../translations/locale_keys.g.dart';
import '../update_as_instructor/information_of_instructor.dart';
import 'package:easy_localization/easy_localization.dart';
class BoardingModel{
  final String image;
  final String title;
  final String body;

  BoardingModel({required this.image, required this.title, required this.body});
}
class OnBordingInstructorScreen extends StatefulWidget {
  @override
  State<OnBordingInstructorScreen> createState() => _OnBordingInstructorScreenState();
}

class _OnBordingInstructorScreenState extends State<OnBordingInstructorScreen> {
  var boardController = PageController();

  bool isLast = false;

  List<BoardingModel> boarding =[
    BoardingModel(
      image: 'assets/images/onboarding_instructor/instructor.jpeg',
      title: '${LocaleKeys.InstructorOnBordingInstructorScreenWelcome.tr()}',
      body: '${LocaleKeys.InstructorOnBordingInstructorScreenbody1.tr()}',
    ),
    BoardingModel(
      image: 'assets/images/onboarding_instructor/instructor1.jpeg',
      title: '${LocaleKeys.InstructorOnBordingInstructorScreenWelookforwardtoworkingwithyou.tr()}',
      body: '${LocaleKeys.InstructorOnBordingInstructorScreenbody2.tr()}',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          TextButton(onPressed: (){

            Navigator.push(context, MaterialPageRoute(builder: (context){
              return InstructorInformation();
            }));
            },
              child: Text(LocaleKeys.InstructorOnBordingInstructorScreenSKIP.tr()
              ,style: TextStyle(
                  color: Colors.green
                ),
              ))
        ],
      ),
      body:Padding(
        padding: const EdgeInsets.all(30.0),
        child: Column(
          children: [
            Expanded(
              child: PageView.builder(
                itemBuilder: (context,index) =>buildBordingItem(boarding[index]),
              itemCount: boarding.length,
              controller: boardController,
                physics: BouncingScrollPhysics(),
                onPageChanged: (index){
                  if(index == boarding.length -1){
                    setState(() {
                      isLast = true;
                    });
                  }else{
                    setState(() {
                      isLast = false;
                    });
                  }
                },
              ),
            ),
            SizedBox(height: 40.0,),
            Row(
              children: [
                SmoothPageIndicator
                  (controller: boardController,
                    count: boarding.length,
                    effect: ExpandingDotsEffect(
                      dotColor: Colors.grey,
                      activeDotColor: Colors.green,
                      dotHeight: 10,
                      dotWidth: 10.0,
                      expansionFactor: 2,
                      spacing: 5.0
                    ),
                ),
                Spacer(),
                FloatingActionButton(onPressed: (){
                  if(isLast){
                      Navigator.push(context, MaterialPageRoute(builder: (context){
                        return InstructorInformation();
                      }));
                     }
                 else {
                    boardController.nextPage(duration: Duration(
                      milliseconds: 750,
                    ),
                        curve: Curves.fastLinearToSlowEaseIn);
                  }
                 }
                ,child: Icon(Icons.arrow_forward_ios
                  ,
                    color: Colors.white,
                  ),
                  backgroundColor: Colors.green,
                )
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget buildBordingItem(BoardingModel model) =>  Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Expanded(
        child: Image(image : AssetImage(model.image),
        ),
      ),
      SizedBox(height: 30.0,),
      Text(model.title,
        style: TextStyle(
            fontSize: 24.0,
            fontWeight: FontWeight.bold,
        ),
      ),
      SizedBox(height: 15.0,),
      Text(model.body,
        style: TextStyle(
            fontSize: 14.0,
            fontWeight: FontWeight.bold,

        ),
      ),
      SizedBox(height: 30.0,),


    ],
  );
}
