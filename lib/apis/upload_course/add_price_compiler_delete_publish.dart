// lib/http_service.dart
import 'package:dio/dio.dart';

import '../../network/local/cache_helper.dart';
import '../../shared/constant.dart';
class HttpServiceCoursePriceAndPublishAndDeleteAndCompiler {

  final Dio _dio = Dio(BaseOptions(baseUrl: baseUrl));

  Future<void> addCoursePrice( String amount, String currency,String token,String courseId
      ) async {
    try {
      print('id = $amount');
      print('id = $currency');
      print('id = $token');
      print('id = $courseId');

      final response = await _dio.put(
        '/v1/course/$courseId',
        data: { 'price[amount]': amount,'price[currency]': currency},
        options: Options(headers: {'Authorization': 'Bearer $token'}),
      );
      print(response);
      print(response.data);
      if (response.statusCode == 200) {
        print(response.data);
        return;
      } else {
        // Registration failed

        print('from add price error = ${response.data}');
        throw ('courseId failed: ${response.data}');
      }
    } catch (e) {
      // Handle network or other errors

      print('from add price error = ${e}');
      throw ('Error during courseId: $e');
    }
  }

  Future<void> addCourseCompiler( String compiler,String token,String courseId
      ) async {
    try {
      print('compiler = $compiler');
      print('token = $token');
      print('courseId = $courseId');

      final response = await _dio.put(
        '/v1/course/$courseId',
        data: { 'compiler': compiler},
        options: Options(headers: {'Authorization': 'Bearer $token'}),
      );
      print(response);
      print(response.data);
      if (response.statusCode == 200) {
        print(response.data);
        return;
      } else {
        // Registration failed

        print('from add compiler error = ${response.data}');
        throw ('courseId failed: ${response.data}');
      }
    } catch (e) {
      // Handle network or other errors

      print('from add compiler error = ${e}');
      throw ('Error during courseId: $e');
    }
  }

  Future<void> publishCourse( String token,String courseId
      ) async {
    try {
      print('token = $token');
      print('courseId = $courseId');

      final response = await _dio.put(
        '/v1/course/setPublish',
        data: { 'courseId': courseId},
        options: Options(headers: {'Authorization': 'Bearer $token'}),
      );
      print(response);
      print(response.data);
      if (response.statusCode == 200) {
        print(response.data);
        return;
      } else {
        // Registration failed

        print('from  publishCourse error = ${response.data}');
        throw ('publishCourse failed: ${response.data}');
      }
    } catch (e) {
      // Handle network or other errors

      print('from publishCourse error = ${e}');
      throw ('Error during publishCourse: $e');
    }
  }
  Future<void> addSpreadSheetLinkOfCourse( String link,String token,String courseId
      ) async {
    try {
      print('spreadsheetlink = $link');
      print('token = $token');
      print('courseId = $courseId');

      final response = await _dio.put(
        '/v1/course/$courseId',
        data: { 'spreadsheetlink': link},
        options: Options(headers: {'Authorization': 'Bearer $token'}),
      );
      print(response);
      print(response.data);
      if (response.statusCode == 200) {
        print(response.data);
        return;
      } else {
        // Registration failed

        print('from  addSpreadSheetLinkOfCourse error = ${response.data}');
        throw ('addSpreadSheetLinkOfCourse failed: ${response.data}');
      }
    } catch (e) {
      // Handle network or other errors

      print('from addSpreadSheetLinkOfCourse error = ${e}');
      throw ('Error during addSpreadSheetLinkOfCourse: $e');
    }
  }
  Future<void> deleteCourse( String token,String courseId ) async {
    try {
      print('id = $courseId');
      print('id = $token');

      final response = await _dio.delete(
        '/v1/course/$courseId',
        options: Options(headers: {'Authorization': 'Bearer $token'}),
      );
      print(response);
      print(response.data);
      if (response.statusCode == 200) {
        // Login successful

        print('delete course success');
        //    print('Token]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]: ${loginModel.data!.token}');
        //
        return;
      } else {
        // Registration failed

        print('from delete course error = ${response.data}');
        throw ('courseId failed: ${response.data}');
      }
    } catch (e) {
      // Handle network or other errors

      print('from delete course error = ${e}');
      throw ('Error during delete course: $e');
    }
  }
}