// lib/http_service.dart
import 'package:dio/dio.dart';

import '../../../network/local/cache_helper.dart';
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
  Future<Map<String,dynamic>> updateSection( String sectionId,videoFilePath,String token)
  async {
    try {
      print('from update section courseId = $sectionId');
      print('from update section  token = $token');
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


      if (response.statusCode == 200) {

        int fileId = CacheHelper.getData(key:'fileId');

        print('from update section  fileId = $fileId');
        //  successful
        try{
          print(response.data['data']['_id']);
          CacheHelper.saveData(key:'fileId',value: fileId+1);
          print('create section successful');
        }catch(e){
          print('error when create section /');
        }
        return response.data['data'];
      } else {
        // Registration failed
        print('Login failed: ${response.data}');
        return {};
      }
    } catch (e) {
      // Handle network or other errors
      print ('Error during Login: $e');
      return {};
    }
  }
  Future<void> deleteSection( String sectionId,String token) async {
    try {
      print('from delete section courseId = $sectionId');
      print('from delete section  token = $token');
      final response = await _dio.delete(
          '/v1/section/$sectionId',
          options: Options(headers: {'Authorization': 'Bearer $token'})
      );
      print("from delete section response = $response");
      print(response.data);
      if (response.statusCode == 200) {
        //  successful
        try{
          print('delete section successful');
        }catch(e){
          print('error when delete section /');
        }
        return ;
      } else {
        // Registration failed
        print('Login failed: ${response.data}');
        throw('excption error ');
      }
    } catch (e) {
      // Handle network or other errors
      print ('Error during delete section: $e');
      throw('excption error $e');
    }
  }

  Future<void> deleteModuleOfSection( String fileId,String token) async {
    try {
      print('from delete module fileID = $fileId');
      final response = await _dio.delete(
          '/v1/coursemodule/$fileId',

          options: Options(headers: {'Authorization': 'Bearer $token'})
      );
      print("from delete module response = $response");
      print(response.data);
      if (response.statusCode == 200) {
        //  successful
        try{
          print('delete module successful');
        }catch(e){
          print('error when delete module /');
        }
        return ;
      } else {
        // Registration failed
        print('delete module failed: ${response.data}');
        throw('excption error ');
      }
    } catch (e) {
      // Handle network or other errors
      print ('Error during delete module: $e');
      throw('excption error $e');
    }
  }
  Future<String> changeSectionName( String courseId,String token,String name)
  async {
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
  Future<void> changeModuleName( String moduleId,String token,String name)
  async {
    try {
      print('from create section courseId = $moduleId');
      print('from create section  token = $token');
      final response = await _dio.put(
          '/v1/coursemodule/$moduleId',
          data: { 'name': name},
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

      } else {
        // Registration failed
        print('Login failed: ${response.data}');

      }
    } catch (e) {
      // Handle network or other errors
      print ('Error during Login: $e');

    }
  }
}