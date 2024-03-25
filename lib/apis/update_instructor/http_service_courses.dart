// lib/http_service.dart
import 'package:dio/dio.dart';

import '../../shared/constant.dart';
class HttpServiceCoursesOfInstructor {

  final Dio _dio = Dio(BaseOptions(baseUrl: baseUrl));

  Future< Map<String,dynamic> > allCoursesOfInstructor( String token) async {
    try {

      final response = await _dio.get(
        '/v1/course/getInstructorCourse',
        options: Options(headers: {'Authorization': 'Bearer $token'}),
      );

      print('from all courses of Instructor = ${response.data}');
      if (response.statusCode == 200) {

        try{
          print('save get all course is done ${response.data['data']} ');
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


}