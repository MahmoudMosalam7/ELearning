import 'dart:async';
import 'package:easy_localization/easy_localization.dart';
import 'package:flip_card/flip_card.dart';
import 'package:flutter/material.dart';
import 'package:learning/Modules/Learn/TabBar/result.dart';
import '../../../apis/courseInformation/http_service_courseInformation.dart';
import '../../../models/test_model.dart';
import '../../../network/local/cache_helper.dart';
import '../../../shared/constant.dart';
import '../../../translations/locale_keys.g.dart';

class FlashCardView extends StatelessWidget {
  final String text;

  const FlashCardView({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      color: Colors.cyan,
      child: Center(
        child: Text(
          text,
          textAlign: TextAlign.center,
          style: TextStyle(color: Colors.white),
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
  late Map<String, dynamic> serverData;
  String errorMessage = '';
  int score = 0;
  Timer? _timer;
  Future<void> _getTest() async {
    try {
      // Fetch course data only if not already loading
      if (_isLoading) {
        // Simulating fetching data from a server
        await Future.delayed(Duration(seconds: 2));

        String? token = CacheHelper.getData(key: 'token');
        Map<String, dynamic> courseData = await httpServiceCourse.createTest(token!, widget.courseId);
        setState(() {
          data = courseData['data']['results'];
          print('drrrrrrrrrrrrrrro = ${courseData['data']['results']}');
          test = TestModel.parseTestFromServer(courseData['data']['results']['test']);
          print('rrrrrrrrrrrrrrrrrrrrrrrviewa =$test');
          _isLoading = false;
          startTimer();
        });
      }
    } catch (e) {
      print('Error fetching course data: $e');
      setState(() {
        _isLoading = false; // Set _isLoading to false in case of error
      });
    }
  }

  @override
  void initState() {
    super.initState();
    _getTest();
  }

  int _currentIndex = 0;
  int? _selectedValue;
  bool _onTouch = false;
  static const _maxSeconds = 180;
  int _seconds = _maxSeconds;
  GlobalKey<FlipCardState> cardKey = GlobalKey<FlipCardState>();

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return Center(
        child: CircularProgressIndicator(
          color: Colors.green,
        ),
      );
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
              SizedBox(
                height: 10,
              ),
              radioOptions(
                test[_currentIndex].choice1,
                test[_currentIndex].choice2,
                test[_currentIndex].choice3,
                test[_currentIndex].choice4,
              ),
              SizedBox(
                height: 10,
              ),
              // to make next and previous
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  OutlinedButton.icon(
                    onPressed: previousCard,
                    icon: Icon(
                      Icons.chevron_left,
                      color: Colors.cyan,
                    ),
                    label: Text(
                      LocaleKeys.LearnTestScreenPrev.tr(),
                      style: TextStyle(color: Colors.cyan),
                    ),
                  ),
                  OutlinedButton.icon(
                    onPressed: nextCard,
                    icon: Icon(
                      Icons.chevron_right,
                      color: Colors.cyan,
                    ),
                    label: Text(
                      LocaleKeys.LearnTestScreenNext.tr(),
                      style: TextStyle(color: Colors.cyan),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 10,
              ),
              buildTimer()
            ],
          ),
        ),
      );
    }
  }

  void startTimer() {
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      if(_seconds >0){
        setState(() {
          _seconds--;
        });
      }else{

        timer?.cancel();
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
          return Result(
            score: score,
            courseID: widget.courseId,
            colors: colors,
          );
        }));
      }
  }
    );}

  void nextCard() {
    setState(() {
      if (_currentIndex < test.length - 1) {
        _currentIndex++;
        _selectedValue = null;
        _onTouch = false;
        cardKey.currentState!.toggleCard();
      } else {
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
          return Result(
            score: score,
            courseID: widget.courseId,
            colors: colors,
          );
        }));
      }
    });
  }

  void previousCard() {
    setState(() {
      if (_currentIndex > 0) {
        _currentIndex--;
        _selectedValue = null;
        _onTouch = false;
        cardKey.currentState!.toggleCard();
      }
    });
  }
  int index =0;
  List<String> colors = ['red','red','red','red','red','red','red','red','red','red'];
  Widget radioOptions(String option1, String option2, String option3, String option4) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            LocaleKeys.LearnTestScreenSelecttheCorrectAnswer.tr(),
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
                    _selectedValue = value;
                    if (test[_currentIndex].correctAnswer == _selectedValue){
                      score++;
                      setState(() {
                        colors[index++]="green";
                      });
                    }
                    _onTouch = true; // Highlight the selected radio button
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
                    _selectedValue = value;
                    if (test[_currentIndex].correctAnswer == _selectedValue){
                      score++;
                      setState(() {
                        colors[index++]="green";
                      });

                    }
                    _onTouch = true; // Highlight the selected radio button
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
                    _selectedValue = value;
                    if (test[_currentIndex].correctAnswer == _selectedValue){
                      score++;
                      setState(() {
                        colors[index++]="green";
                      });
                    }
                    _onTouch = true; // Highlight the selected radio button
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
                    _selectedValue = value;
                    if (test[_currentIndex].correctAnswer == _selectedValue){
                      score++;
                      setState(() {
                        colors[index++]="green";
                      });
                    }
                    _onTouch = true; // Highlight the selected radio button
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
        ],
      ),
    );
  }

  Widget buildButtons() {
    return buttonWidget(
        text: '${LocaleKeys.LearnTestScreenStartTimer.tr()}',
        onClicked: () {
          startTimer();
        });
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

  Widget buildTime() {
    return Text(
      '$_seconds',
      style: TextStyle(fontSize: 40),
    );
  }
}
