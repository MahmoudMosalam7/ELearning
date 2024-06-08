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

  Future<String> makeCoupon(String expireDate,String discount,
      String maxUser,String courseID,
      String token
      )async{
    try {
     print('from make coupone expireData= $expireDate');
     print('from make coupone discount= $discount');
     print('from make coupone maxUser= $maxUser');
     print('from make coupone courseID= $courseID');
     print('from make coupone token= $token');
      final response = await _dio.post(
        '/v1/coupons',
        data:{
          'expire':expireDate,
          'discount':discount,
          'maximumUses':maxUser,
          'course':courseID,
          'name':'woooow',
        },
        options: Options(headers: {'Authorization': 'Bearer $token'}),
      );

      print('from makeCoupon = ${response.data}');
      if (response.statusCode == 200) {

        try{
          print('save makeCoupon done ${response.data['data']} ');
        }catch(e){
          print('error when save makeCoupon /');
        }

        return '${response.data['data']['code']}';
      } else {
        // Registration failed

        print('from makeCoupon error = ${response.data}');
        throw ('get makeCoupon failed: ${response.data}');
      }
    } catch (e) {
      // Handle network or other errors

      print('from makeCoupon error = ${e}');
      throw ('Error during makeCoupon: $e');
    }
  }
}