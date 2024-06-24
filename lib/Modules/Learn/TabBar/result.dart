
import 'dart:io';
import 'package:http/http.dart' as http;

import 'package:flutter/material.dart';
import 'package:learning/Modules/Learn/TabBar/testScreen.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:easy_localization/easy_localization.dart';
import '../../../apis/courseInformation/http_service_courseInformation.dart';
import '../../../network/local/cache_helper.dart';
import '../../../shared/constant.dart';
import '../../../translations/locale_keys.g.dart';

class Result extends StatefulWidget {
   Result({super.key, required this.score,required this.courseID,required this.colors});
  final int score;
  final String  courseID;
  final List<String>  colors;

  @override
  State<Result> createState() => _ResultState();
}

class _ResultState extends State<Result> {
  HttpServiceCourse httpServiceCourse = HttpServiceCourse();
  bool _isLoading = true;
  String errorMessage = '';
  String? certificate = '';

  /*@override
  void initState() {
    super.initState();
    if (_isLoading) {
      ; // Fetch course data only if _isLoading is true
    } // Fetch course data only if _isLoading is true

  }*/
  Future<void> _getCertificate() async {
    try {
      // Set _isLoading to true before fetching data
      setState(() {
        _isLoading = true;
      });
        int score = widget.score *10;
      String? token = CacheHelper.getData(key: 'token');
       Map<String,dynamic> cert = await httpServiceCourse.getCertificate(
      widget.courseID
      ,score,
      token!);
      setState(() {

        certificate = cert['data']['url'];
        _downloadPDF((cert['data']['url'])!.trim());
        _isLoading = false; // Set _isLoading to false after data is fetched
      });
      print('certificate 2= ${certificate}');
      //['data']['results']['url']
    } catch (e) {
      print('Error fetching certificate : $e');
      setState(() {
        _isLoading = false; // Set _isLoading to false in case of error
      });
    }
  }
  String _statusMessage = '';

  Future<void> _downloadPDF(String url) async {
    setState(() {
      _statusMessage = 'Downloading...';
    });

    try {
      // Request permission
      if (await Permission.storage.request().isGranted) {
        // Get the external storage directory
        Directory? directory = await getExternalStorageDirectory();
        if (directory != null) {
          String filePath = '${directory.path}/downloaded.pdf';

          // Fetch the PDF file
          var response = await http.get(Uri.parse(url));

          if (response.statusCode == 200) {
            // Write the file
            File file = File(filePath);
            await file.writeAsBytes(response.bodyBytes);

            setState(() {
              _statusMessage = 'Downloaded to $filePath';
            });
          } else {
            setState(() {
              _statusMessage = 'Error: Failed to download PDF';
            });
          }
        } else {
          setState(() {
            _statusMessage = 'Error: External storage not available';
          });
        }
      } else {
        setState(() {
          _statusMessage = 'Permission denied';
        });
      }
    } catch (e) {
      setState(() {
        _statusMessage = 'Error: $e';
      });
    } finally {
      setState(() {
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    print("colors = ${widget.colors}");
    return Scaffold(
      backgroundColor: Colors.cyan,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  '${LocaleKeys.LearnResultHello.tr()} ${getData?['data']['name']}',
                  style: TextStyle(
                    fontSize: 25,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 10),
                Text(
                  LocaleKeys.LearnResultYourScoreis.tr(),
                  style: TextStyle(
                    fontSize: 25,
                    color: Colors.white,
                  ),
                ),
                SizedBox(height: 10),
                Text(
                  '${widget.score}/10',
                  style: TextStyle(
                    fontSize: 50,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 10),
                if(widget.score >= 7)
                ElevatedButton(
                  onPressed: () {
                    print('certificate  =$certificate');

                    _getCertificate();

                  },
                  child: Text(LocaleKeys.LearnResultDownloadPDF.tr()),
                ),
                if(widget.score >= 7)
                SizedBox(height: 20),
                if(widget.score >= 7)
                Text(
                  _statusMessage,
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 10),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Text(
                      LocaleKeys.LearnResultQuestionsandAnswers.tr(),
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 10),
                ListView.separated(
                  padding: EdgeInsets.symmetric(horizontal: 16.0),
                  scrollDirection: Axis.vertical,
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: test.length,
                  itemBuilder: (context, index) {

                    bool isGreen = widget.colors[index] == "green";
                    String correctAnswer ='';
                    if(test[index].correctAnswer == 0.0){
                      correctAnswer = test[index].choice1;
                    }else if(test[index].correctAnswer == 1.0){
                      correctAnswer = test[index].choice2;
                    }
                    else if(test[index].correctAnswer == 2.0){
                      correctAnswer = test[index].choice3;
                    }
                    else if(test[index].correctAnswer == 3.0){
                      correctAnswer = test[index].choice4;
                    }
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '${index + 1} - ${test[index].question}',
                          maxLines: 3,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 5),
                        Text(
                          '${LocaleKeys.LearnResultCorrectAnswer.tr()} ${correctAnswer}',
                          style: TextStyle(
                            fontSize: 14,
                            color: isGreen ? Colors.green : Colors.red,
                          ),
                        ),
                        SizedBox(height: 5),
                      ],
                    );
                  },
                  separatorBuilder: (context, index) => Divider(
                    color: Colors.white54,
                    height: 15.0,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
