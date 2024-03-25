// lib/http_service.dart
import 'package:dio/dio.dart';

import '../../shared/constant.dart';
class HttpServiceCourse {

  final Dio _dio = Dio(BaseOptions(baseUrl: baseUrl));

  Future< Map<String,dynamic> > allCourses( String token) async {
    try {

      final response = await _dio.get(
        '/v1/course/',
        options: Options(headers: {'Authorization': 'Bearer $token'}),
      );

      print('from all courses = ${response.data}');
      if (response.statusCode == 200) {

        try{
          print('save get all course is done ${response.data['data']['results']} ');
        }catch(e){
          print('error when save get all course /');
        }

        return response.data;
      } else {
        // Registration failed

        print('from get all course error = ${response.data}');
        throw ('get all course failed: ${response.data}');
      }
    } catch (e) {
      // Handle network or other errors

      print('from get all course error = ${e}');
      throw ('Error during get all course: $e');
    }
  }

  Future< Map<String,dynamic> > getCourse( String id,String token) async {
    try {
        print('from me id = $id');
        print('from me token = $token');
      final response = await _dio.get(
        '/v1/course/$id',
        options: Options(headers: {'Authorization': 'Bearer $token'}),
      );

      print('from get course = ${response.data}');
      if (response.statusCode == 200) {

        try{
          print(' get  course is done ${response.data['data']['results']} ');
        }catch(e){
          print('error when  get  course /');
        }

        return response.data;
      } else {
        // Registration failed

        print('from get  course error = ${response.data}');
        throw ('get  course failed: ${response.data}');
      }
    } catch (e) {
      // Handle network or other errors

      print('from get  course error = ${e}');
      throw ('Error during get  course: $e');
    }
  }
}