// lib/http_service.dart
import 'package:dio/dio.dart';

import '../../../network/notifications/notifications.dart';
import '../../../shared/constant.dart';
class HttpServiceSection {

  final Dio _dio = Dio(BaseOptions(baseUrl: baseUrl));

  Future<String> createSection( String courseId,String token) async {
    try {
      print('from create section courseId = $courseId');
      print('from create section  token = $token');
      final response = await _dio.post(
        '/v1/section/',
        data: { 'courseId': courseId},
        options: Options(headers: {'Authorization': 'Bearer $token'})
      );
      print("from create section response = $response");
      print(response.data);
      if (response.statusCode == 200) {
        //  successful
        try{
          print(response.data['data']['_id']);
          print('create section successful');
         }catch(e){
          print('error when create section /');
        }
   return response.data['data']['_id'];
      } else {
        // Registration failed
        print('Login failed: ${response.data}');
        return 'error';
      }
    } catch (e) {
      // Handle network or other errors
      print ('Error during Login: $e');
      return 'error';
    }
  }
  Future<String> updateSection( String sectionId,videoFilePath,String token) async {
    try {
      print('from create section courseId = $sectionId');
      print('from create section  token = $token');

      String videFileName = videoFilePath.split('/').last;
      FormData formData =  FormData.fromMap({
         "file": await MultipartFile.fromFile(videoFilePath, filename: videFileName),

      });


      final response = await _dio.put(
          '/v1/section/$sectionId',
          data: formData,
          onSendProgress: (count, total) {
            uploadingNotification(total, count, true);
          },
          options: Options(headers: {'Authorization': 'Bearer $token'})
      );
      print("from upload video of section response = $response");
      print(response.data);
      if (response.statusCode == 200) {
        //  successful
        try{
          print(response.data['data']['_id']);
          print('create section successful');
        }catch(e){
          print('error when create section /');
        }
        return response.data['data']['_id'];
      } else {
        // Registration failed
        print('Login failed: ${response.data}');
        return 'error';
      }
    } catch (e) {
      // Handle network or other errors
      print ('Error during Login: $e');
      return 'error';
    }
  }
}