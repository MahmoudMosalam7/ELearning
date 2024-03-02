import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import '../../../../TColors.dart';
import '../update_as_instructor/information_of_instructor.dart';

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
      title: 'Welcome',
      body: 'Thank You For Deciding To Work With US',
    ),
    BoardingModel(
      image: 'assets/images/onboarding_instructor/instructor1.jpeg',
      title: 'We look forward to working with you',
      body: ' let\'s get started',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          TextButton(onPressed: (){
            Get.to(InstructorInformation());
            },
              child: Text('SKIP'
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
                      Get.to(InstructorInformation());
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
