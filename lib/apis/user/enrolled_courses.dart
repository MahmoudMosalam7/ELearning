
import 'package:dio/dio.dart';

import '../../shared/constant.dart';
class HttpServiceEnrolledCourses {

  final Dio _dio = Dio(BaseOptions(baseUrl: baseUrl));

  Future< Map<String,dynamic> > allEnrolledCourses( String token) async {
    try {

      final response = await _dio.get(
        '/v1/course/enrolledCourses',
        options: Options(headers: {'Authorization': 'Bearer $token'}),
      );

      print('from all Enrolled courses = ${response.data}');
      if (response.statusCode == 200) {

        try{
          print('save get all Enrolled course is done ${response.data['data']['results']} ');
        }catch(e){
          print('error when save get all Enrolled course /');
        }

        return response.data;
      } else {
        // Registration failed

        print('from get all Enrolled course error = ${response.data}');
        throw ('get all Enrolled course failed: ${response.data}');
      }
    } catch (e) {
      // Handle network or other errors

      print('from get all Enrolled course error = ${e}');
      throw ('Error during get all Enrolled course: $e');
    }
  }
}