import 'dart:async';

import 'package:flip_card/flip_card.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:learning/Modules/Learn/TabBar/result.dart';

import '../../../apis/courseInformation/http_service_courseInformation.dart';
import '../../../models/test_model.dart';
import '../../../network/local/cache_helper.dart';
import '../../../shared/constant.dart';
class FlashCardView extends StatelessWidget {
  final String text;

  const FlashCardView({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      color: Colors.cyan,
      child: Center(
        child: Text(text,
          textAlign: TextAlign.center,
          style: TextStyle(
              color: Colors.white
          ),
        ),
      ),
    );
  }
}

class TestScreen extends StatefulWidget {
  const TestScreen({super.key, required this.courseId});
  final String courseId;

  @override
  State<TestScreen> createState() => _TestScreenState();
}
List<TestModel> test = [];
class _TestScreenState extends State<TestScreen> {
  HttpServiceCourse httpServiceCourse = HttpServiceCourse();
  bool _isLoading = true;
  late Map<String,dynamic> serverData ;
  String errorMessage = '';
 int score = 0;

  Future<void> _getTest() async {
    try {
      // Fetch course data only if not already loading
      if (_isLoading) {
        // Simulating fetching data from a server
        await Future.delayed(Duration(seconds: 2));

        String? token = CacheHelper.getData(key: 'token');
        Map<String, dynamic> courseData = await httpServiceCourse.createTest(
            token!,widget.courseId);
        setState(() {
          data = courseData['data']['results'];
          print('drrrrrrrrrrrrrrro = ${ courseData['data']['results']}');
          test = TestModel.parseTestFromServer(courseData['data']['results']['test']);
          print('rrrrrrrrrrrrrrrrrrrrrrrviewa =$test ');
          _isLoading = false;
          startTimer();
            });}

    } catch (e) {
      print('Error fetching course data: $e');
      setState(() {
        _isLoading = false; // Set _isLoading to false in case of error
      });
    }
  }
  void initState(){
    super.initState();
    _getTest();
  }
  bool _correct = false;
  int _currentIndex = 0;
  int _selectedValue = 0;
  bool _onTouch = false;
  static const _maxSeconds = 180;
  int _seconds = _maxSeconds;
  Timer? _timer;
  GlobalKey<FlipCardState> cardKey = GlobalKey<FlipCardState>();

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return Center(child: CircularProgressIndicator());
    } else {
    return SingleChildScrollView(
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              width: 250,
              height: 250,
              child: FlipCard(
                key: cardKey,
                flipOnTouch: _onTouch,
                front: FlashCardView(text: test[_currentIndex].question),
                back: FlashCardView(text: test[_currentIndex].question),
              ),
            ),

            SizedBox(height: 10,),
            radioOptions(test[_currentIndex].choice1,
                test[_currentIndex].choice2,
                test[_currentIndex].choice3,
                test[_currentIndex].choice4,
            ),
            SizedBox(height: 10,),
            // to make next and previos
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                OutlinedButton.icon
                  (onPressed: previousCard,
                    icon: Icon(Icons.chevron_left
                      ,color: Colors.cyan,
                    ),
                    label: Text('Prev'
                      ,style: TextStyle(
                          color: Colors.cyan
                      ),
                    )),

                OutlinedButton.icon
                  (onPressed: nextCard,
                    icon: Icon(Icons.chevron_right
                      ,color: Colors.cyan,
                    ),
                    label: Text('Next',
                      style: TextStyle(
                          color: Colors.cyan
                      ),
                    )),
              ],
            ),
            SizedBox(height: 10,),
            buildTimer()
          ],
        ),
      ),
    );}
  }
  void startTimer() {
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      if(_seconds >0){
        setState(() {
          _seconds--;
        });
      }else{

        timer?.cancel();
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context){

          return Result(score: score,courseID: widget.courseId,);
        }));
      }

    });
  }
  void nextCard() {
    setState(() {
      _correct = false;
      _currentIndex = (_currentIndex + 1 < test.length) ? _currentIndex
          + 1 : test.length ;
      _selectedValue = 1;
      if(_onTouch){
        cardKey.currentState!.toggleCard();
      }
      if(_currentIndex == test.length){
        _currentIndex--;
       /* Navigator.pushReplacement(context, MaterialPageRoute(builder: (context){
          _timer?.cancel();
          return Result();
        }));*/
      }
    });
  }

  void previousCard() {
    setState(() {
      _correct = false;
      _currentIndex = (_currentIndex - 1 >= 0) ? _currentIndex - 1 : 0;
      _selectedValue = 1;
      if(_onTouch){
        cardKey.currentState!.toggleCard();

      }
    });
  }

  Widget radioOptions(String option1 ,String option2,String option3,String option4
      ){
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Select the Correct Answer:',
            style: TextStyle(fontSize: 18),
          ),
          SizedBox(height: 10),
          Row(
            mainAxisSize: MainAxisSize.max,
            children: [
              Radio(
                value: 0,
                activeColor: Colors.cyan,
                groupValue: _selectedValue,
                onChanged: (value) {
                  setState(() {
                    _selectedValue = value as int;
                    if(test[_currentIndex].correctAnswer == _selectedValue){
                      _onTouch = true;

                      _currentIndex = (_currentIndex + 1 < test.length) ?
                      _currentIndex + 1 : test.length ;
                      if(_currentIndex == test.length){
                        _currentIndex--;
                        _selectedValue = 1;
                        Navigator.pushReplacement(context,
                            MaterialPageRoute(builder: (context){
                              _timer?.cancel();
                              return Result(score: score,courseID: widget.courseId,);
                            }));
                      }
                      score++;
                   //   cardKey.currentState!.toggleCard();
                    }else{
                      _onTouch = false;
                      _currentIndex = (_currentIndex + 1 < test.length) ?
                      _currentIndex + 1 : test.length ;
                      if(_currentIndex == test.length){
                        _currentIndex--;

                        _selectedValue = 1;
                       Navigator.pushReplacement(context,
                            MaterialPageRoute(builder: (context){
                              _timer?.cancel();
                              return Result(score: score,courseID: widget.courseId,);
                            }));
                      }
                    }
                  });
                },
              ),
      Expanded(
        child: Text(
          option1,
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
        ),
      ),
            ],
          ),
          Row(
            mainAxisSize: MainAxisSize.max,
            children: [
              Radio(
                value: 1,
                activeColor: Colors.cyan,
                groupValue: _selectedValue,
                onChanged: (value) {
                  setState(() {
                    _selectedValue = value as int;
                    if(test[_currentIndex].correctAnswer == _selectedValue){
                      _onTouch = true;
                      score++;

                      _currentIndex = (_currentIndex + 1 < test.length) ?
                      _currentIndex + 1 : test.length ;
                      if(_currentIndex == test.length){

                        _selectedValue = 1;
                        _currentIndex--;
                        Navigator.pushReplacement(context,
                            MaterialPageRoute(builder: (context){
                              _timer?.cancel();
                              return Result(score: score,courseID: widget.courseId,);
                            }));
                      }
                     // cardKey.currentState!.toggleCard();
                    }else{
                      _onTouch = false;
                      _currentIndex = (_currentIndex + 1 < test.length) ?
                      _currentIndex + 1 : test.length ;
                      if(_currentIndex == test.length){
                        _currentIndex--;

                        _selectedValue = 1;
                        Navigator.pushReplacement(context,
                            MaterialPageRoute(builder: (context){
                              _timer?.cancel();
                              return Result(score: score,courseID: widget.courseId,);
                            }));
                      }
                    }
                  });
                },
              ),
              Expanded(
                child: Text(
                  option2,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
          Row(
            mainAxisSize: MainAxisSize.max,
            children: [
              Radio(
                value: 2,
                activeColor: Colors.cyan,
                groupValue: _selectedValue,
                onChanged: (value) {
                  setState(() {
                    _selectedValue = value as int;
                    if(test[_currentIndex].correctAnswer == _selectedValue){
                      score++;
                      _onTouch = true;

                      _currentIndex = (_currentIndex + 1 < test.length) ?
                      _currentIndex + 1 : test.length ;
                      if(_currentIndex == test.length){
                        _currentIndex--;

                        _selectedValue = 1;
                        Navigator.pushReplacement(context,
                            MaterialPageRoute(builder: (context){
                              _timer?.cancel();
                              return Result(score: score,courseID: widget.courseId,);
                            }));
                      }
                      //cardKey.currentState!.toggleCard();
                    }else{
                      _onTouch = false;
                      _currentIndex = (_currentIndex + 1 < test.length) ?
                      _currentIndex + 1 : test.length ;
                      if(_currentIndex == test.length){
                        _currentIndex--;

                        _selectedValue = 1;
                        Navigator.pushReplacement(context,
                            MaterialPageRoute(builder: (context){
                              _timer?.cancel();
                              return Result(score: score,courseID: widget.courseId,);
                            }));
                      }
                    }
                  });
                },
              ),
              Expanded(
                child: Text(
                  option3,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
          Row(
            mainAxisSize: MainAxisSize.max,
            children: [
              Radio(
                value: 3,
                activeColor: Colors.cyan,
                groupValue: _selectedValue,
                onChanged: (value) {
                  setState(() {
                    _selectedValue = value as int;
                    if(test[_currentIndex].correctAnswer == _selectedValue){
                      score++;
                      _onTouch = true;

                      _currentIndex = (_currentIndex + 1 < test.length) ?
                      _currentIndex + 1 : test.length ;
                      if(_currentIndex == test.length){
                        _currentIndex--;

                        _selectedValue = 1;
                        Navigator.pushReplacement(context,
                            MaterialPageRoute(builder: (context){
                              _timer?.cancel();
                              return Result(score: score,courseID: widget.courseId,);
                            }));
                      }
                     // cardKey.currentState!.toggleCard();
                    }else{
                      _onTouch = false;
                      _currentIndex = (_currentIndex + 1 < test.length) ?
                      _currentIndex + 1 : test.length ;
                      if(_currentIndex == test.length){
                        _currentIndex--;

                        _selectedValue = 1;
                        Navigator.pushReplacement(context,
                            MaterialPageRoute(builder: (context){
                              _timer?.cancel();
                              return Result(score: score,courseID: widget.courseId,);
                            }));
                      }
                    }
                  });
                },
              ),
              Expanded(
                child: Text(
                  option4,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
          // Add more rows for additional radio buttons as needed.
        ],
      ),
    );
  }

  Widget buildButtons(){
    return buttonWidget(
        text: 'Start Timer',
        onClicked: (){
          startTimer();
        }
    );
  }
  Widget buildTimer() => SizedBox(
    height: 100,
    width: 100,
    child: Stack(
      fit: StackFit.expand,
      children: [
        CircularProgressIndicator(
          value: _seconds / _maxSeconds,
          valueColor: AlwaysStoppedAnimation(Colors.greenAccent),
          strokeWidth: 8,
          backgroundColor: Colors.cyan,
        ),
        Center(
          child: buildTime(),
        ),
      ],
    ),
  );

  Widget buildTime(){
    return Text('$_seconds',style: TextStyle(

        fontSize: 40
    ),);
  }
}
