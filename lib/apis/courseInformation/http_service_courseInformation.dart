// lib/http_service.dart
import 'package:dio/dio.dart';

import '../../network/local/cache_helper.dart';
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
  Future< Map<String,dynamic> > allCoursesByCategories( String token,String
      categoryId
      ) async {
    try {

      final response = await _dio.get(
        '/v1/course/categoriesId/$categoryId',
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
  Future< String > getModule( String id,String token) async {
    try {
        print('from getModule id = $id');
        print('from getModule token = $token');
      final response = await _dio.get(
        '/v1/coursemodule/$id',
        options: Options(headers: {'Authorization': 'Bearer $token'}),
      );

      print('from getModule = ${response.data}');
      if (response.statusCode == 200) {

        try{
        }catch(e){
          print('error when  getModule /');
        }

        return response.data['data']['file']['path'];
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

  Future<void> paymentByMethod(imageFilePath,String userId,String CoursePrice
      ,String phoneNumber,String courseId ,String token) async {

    String imageFileName = imageFilePath.split('/').last;

    FormData formData =  FormData.fromMap({
      "paymentReceiptImage": await MultipartFile.fromFile(imageFilePath, filename: imageFileName),
      "courseId": courseId,
      "userId": userId,
      "CoursePrice": CoursePrice,
      "phoneNumber": phoneNumber,
    });


    try {
      print('from make transactons image = $imageFileName');
      print('from make transactons image = $userId');
      print('from make transactons image = $CoursePrice');
      print('from make transactons image = $phoneNumber');
      print('from make transactons image = $courseId');
      print('from make transactons image = $token');
      final response = await _dio.post
        ('/v1/transaction'
        ,data: formData,


        options: Options(headers: {'Authorization': 'Bearer $token'}),
      );
      // ignore: use_build_context_synchronously
       if (response.statusCode == 200) {
        // Login successful
        try{
          print(response.data);
          print('make transaction is done ');
        }catch(e){
          print('error when make transaction  $e /');
        }


        return;
      } else {
        // Registration failed

        print('from make transaction error = ${response.data}');
        throw ('make transaction  failed: ${response.data}');
      }
    } catch (e) {
      print('from make transaction error = ${e}');
    }
  }
}