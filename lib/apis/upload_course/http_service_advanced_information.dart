// lib/http_service.dart
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import '../../network/local/cache_helper.dart';
import '../../network/notifications/Utils.dart';
import '../../network/notifications/notifications.dart';
import '../../shared/constant.dart';
class HttpServiceAdvancedInformation {

  final Dio _dio = Dio(BaseOptions(baseUrl: baseUrl));

  Future<void> advancedInformation(imageFilePath,videoFilePath,String courseDescription
      ,String whatWillBeTaught,String targetAudience,
      String requirements
      ,context ,String token) async {

    String videFileName = videoFilePath.split('/').last;
    String imageFileName = imageFilePath.split('/').last;
    debugPrint("File Path$videoFilePath");

    FormData formData =  FormData.fromMap({
      "thumbnail": await MultipartFile.fromFile(imageFilePath, filename: imageFileName),
      "videoTrailer": await MultipartFile.fromFile(videoFilePath, filename: videFileName),
      "courseDescription": courseDescription,
      "courseDescription": courseDescription,
      "whatWillBeTaught": whatWillBeTaught,
      "targetAudience": targetAudience,
      "requirements": requirements,
    });


    try {
      final response = await _dio.put('/v1/course/${CacheHelper.getData(key: 'courseId')}'
        ,data: formData,

        onSendProgress: (count, total) {
          uploadingNotification(total, count, true);
        },

        options: Options(headers: {'Authorization': 'Bearer $token'}),
      ).whenComplete(() {
        uploadingNotification(0, 0, false);
      });
      // ignore: use_build_context_synchronously
      buildShowSnackBar(context, "file uploaded");
      debugPrint('file : ${response.data}');
      if (response.statusCode == 200) {
        // Login successful
        try{
          print(response.data['data']['token']);
          print('save courseId is done ');
        }catch(e){
          print('error when save advnced $e /');
        }


        return;
      } else {
        // Registration failed

        print('from advanced error = ${response.data}');
        throw ('courseId failed: ${response.data}');
      }
    } catch (e) {
      print('from advanced error = ${e}');
      debugPrint('exception $e');
    }
  }

 /* Future<void> baicInformation( String title, String subTitle,String category,
      String language, String level,String token,String instructorId
      ) async {
    try {
      final response = await _dio.put(
        '/v1/course/:id',
        data: { 'title': title,'subTitle': subTitle,'category':
        category,'language': language,'level': level ,
          'instructor': instructorId},
        options: Options(headers: {'Authorization': 'Bearer $token'}),
      );
      print(response);
      print(response.data);
      if (response.statusCode == 200) {
        // Login successful
        try{
          print(response.data['data']['token']);
          await CacheHelper.saveData(key:'courseId',
              value:response.data['data']['_id']);
          print('save courseId is done ');
        }catch(e){
          print('error when save courseId /');
        }


        return;
      } else {
        // Registration failed

        print('from basicApi error = ${response.data}');
        throw ('courseId failed: ${response.data}');
      }
    } catch (e) {
      // Handle network or other errors

      print('from basicApi error = ${e}');
      throw ('Error during courseId: $e');
    }
  }*/
}