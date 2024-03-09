// lib/http_service.dart
import 'package:dio/dio.dart';

import '../../network/local/cache_helper.dart';
import '../../shared/constant.dart';
class HttpServiceBasicInformation {

  final Dio _dio = Dio(BaseOptions(baseUrl: baseUrl));

  Future<void> baicInformation( String title, String subTitle,String category,
      String language, String level,String token,String instructorId
      ) async {
    print('from basicApi');
    print('from title = ${title}');
    print('from subTitle = ${subTitle}');
    print('from category = ${category}');
    print('from language = ${language}');
    print('from level = ${level}');
    print('from token = ${token}');
    print('from instructorId = ${instructorId}');
    try {

      print('from title2 = ${title}');
      print('from subTitle2 = ${subTitle}');
      print('from category2 = ${category}');
      print('from language = ${language}');
      print('from level = ${level}');
      print('from token = ${token}');
      print('from instructorId = ${instructorId}');
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
          await CacheHelper.saveData(key:'courseId',
              value:response.data['data']['_id']);
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
}