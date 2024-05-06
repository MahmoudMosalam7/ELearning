// lib/http_service.dart
import 'package:dio/dio.dart';

import '../../network/local/cache_helper.dart';
import '../../shared/constant.dart';
class HttpServiceBasicInformation {

  final Dio _dio = Dio(BaseOptions(baseUrl: baseUrl));

  Future<void> baicInformation( String title, String subTitle,String category,
      String language, String level,String token,String instructorId
      ) async {
    try {
      print('id = $instructorId');
      print('id = $title');
      print('id = $subTitle');
      print('id = $category');
      print('id = $language');
      print('id = $level');
      print('id = $token');

      final response = await _dio.post(
        '/v1/course/',
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
          print(response.data['data']['_id']);
          print(response.data['data']['category']);
          String _category = response.data['data']['category'];
          await CacheHelper.saveData(key:'courseId',
              value:response.data['data']['_id']);
          // 65ccf45dc5878a651ba20c6b , 65ecd14c271787e0f6fd07bb , 65ecd179271787e0f6fd07bf ,65ecd1b5271787e0f6fd07c7 , 66046eaf698d7afd28450d0c
          if(_category == '65ccf45dc5878a651ba20c6b' ||
              _category == '65ecd14c271787e0f6fd07bb' ||
              _category == '65ecd179271787e0f6fd07bf' ||
              _category == '65ecd1b5271787e0f6fd07c7' ||
              _category == '66046eaf698d7afd28450d0c'
          ){
            await CacheHelper.saveData(key:'compiler',
                value:true);

          }
          print('save courseId is done ');
        }catch(e){
          print('error when save courseId /');
        }

        //    print('Token]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]: ${loginModel.data!.token}');
        //
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
  }
  Future<void> updateBaicInformation( String title, String subTitle,String category,
      String language, String level,String token,String instructorId,String courseId
      ) async {
    try {
      print('id = $instructorId');
      print('id = $courseId');
      print('id = $title');
      print('id = $subTitle');
      print('id = $category');
      print('id = $language');
      print('id = $level');
      print('id = $token');

      final response = await _dio.put(
        '/v1/course/$courseId',
        data: { 'title': title,'subTitle': subTitle,'category':
        category,'language': language,'level': level ,
          'instructor': instructorId},
        options: Options(headers: {'Authorization': 'Bearer $token'}),
      );
      print(response);
      print(response.data);
      if (response.statusCode == 200) {
        // Login successful

        print('update basicinfo success');
        //    print('Token]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]: ${loginModel.data!.token}');
        //
        return;
      } else {
        // Registration failed

        print('from update basicinfo error = ${response.data}');
        throw ('courseId failed: ${response.data}');
      }
    } catch (e) {
      // Handle network or other errors

      print('from update basicinfo error = ${e}');
      throw ('Error during update basicinfo: $e');
    }
  }
}