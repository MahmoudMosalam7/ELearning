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
  Future< Map<String,dynamic> >createTest(String token,String courseId)async {
    try {
      print('token = $token');
      print('courseId = $courseId');

      final response = await _dio.post(
        '/v1/tests/$courseId',
       // data:{'courseId':courseId},
        options: Options(headers: {'Authorization': 'Bearer $token'}),
      );
      print(response);
      print(response.data);
      if (response.statusCode == 200) {
        print(response.data);
        return response.data;
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
  Future< Map<String,dynamic> > addAndRemoveCourseFromWishList( String id,String token) async {
    try {
      print('from addAndRemoveCourseFromWishList id = $id');
      print('from addAndRemoveCourseFromWishList token = $token');
      final response = await _dio.put(
        '/v1/course/wishlist',
        data: {'courseId':id},
        options: Options(headers: {'Authorization': 'Bearer $token'}),
      );

      print('from addAndRemoveCourseFromWishList  = ${response.data}');
      if (response.statusCode == 200) {

        try{
          print(' get  addAndRemoveCourseFromWishList is done ${response.data['data']['results']} ');
        }catch(e){
          print('error when  addAndRemoveCourseFromWishList  course /');
        }

        return response.data;
      } else {
        // Registration failed

        print('from addAndRemoveCourseFromWishList error = ${response.data}');
        throw ('addAndRemoveCourseFromWishListfailed: ${response.data}');
      }
    } catch (e) {
      // Handle network or other errors

      print('from addAndRemoveCourseFromWishList error = ${e}');
      throw ('Error addAndRemoveCourseFromWishList course: $e');
    }
  }
  Future< Map<String,dynamic> > getAllCoursesFromWishList( String token) async {
    try {
      print('from getAllCoursesFromWishList token = $token');
      final response = await _dio.get(
        '/v1/course/wishlist',
        options: Options(headers: {'Authorization': 'Bearer $token'}),
      );

      print('from getAllCoursesFromWishList  = ${response.data}');
      if (response.statusCode == 200) {

        try{
          print(' get  getAllCoursesFromWishList is done ${response.data['data']['results']} ');
        }catch(e){
          print('error when  getAllCoursesFromWishList  course /');
        }

        return response.data;
      } else {
        // Registration failed

        print('from getAllCoursesFromWishList error = ${response.data}');
        throw ('getAllCoursesFromWishList: ${response.data}');
      }
    } catch (e) {
      // Handle network or other errors

      print('from getAllCoursesFromWishList error = ${e}');
      throw ('Error getAllCoursesFromWishList course: $e');
    }
  }
  Future<void> paymentByMethod(imageFilePath,String userId,String CoursePrice
      ,String phoneNumber,String courseId ,String token,{String? coupon}) async {
    String imageFileName = '';
    FormData formData;
    if( coupon != null ){
       if(coupon.length == 11){

         print('from transaction copuon free');
         formData =  FormData.fromMap({

           "courseId": courseId,
           "userId": userId,
           "CoursePrice": CoursePrice,
           "phoneNumber": phoneNumber,
           "couponCode":coupon
         });
       }else{
         formData =  FormData.fromMap({
           "paymentReceiptImage": await MultipartFile.fromFile(imageFilePath, filename: imageFileName),
           "courseId": courseId,
           "userId": userId,
           "CoursePrice": CoursePrice,
           "phoneNumber": phoneNumber,
           "couponCode":coupon
         });
       }
    }else{
       imageFileName = imageFilePath.split('/').last;


        print('last last last');
        formData =  FormData.fromMap({
          "paymentReceiptImage": await MultipartFile.fromFile(imageFilePath, filename: imageFileName),
          "courseId": courseId,
          "userId": userId,
          "CoursePrice": CoursePrice,
          "phoneNumber": phoneNumber,
        });

    }



    try {
      print('from make transactons image = $imageFileName');
      print('from make transactons image = $userId');
      print('from make transactons image = $CoursePrice');
      print('from make transactons image = $phoneNumber');
      print('from make transactons image = $courseId');
      print('from make transactons image = $token');
      print('from make transactons formdata = ${formData.fields}');
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
  Future< Map<String,dynamic>> getCertificate( String courseId,int sore,String token) async {
    try {
      print('from getCertificate courseId = $courseId');
      print('from getCertificate sore = $sore');
      print('from getCertificate token = $token');
      final response = await _dio.post(
        '/v1/certificate',
        data: {
          'courseId':courseId,
          'score':sore,
        },
        options: Options(headers: {'Authorization': 'Bearer $token'}),
      );

      print('from getCertificate = ${response.data}');
      if (response.statusCode == 200) {

        try{
          print(' getCertificateis done ${response.data['data']['results']} ');
        }catch(e){
          print('error when getCertificate /');
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
  Future<void> progress(String courseId,String moduleId ,String token)async{
    try {
      print('from progress courseId = $courseId');
      print('from progress sore = $moduleId');
      print('from progress token = $token');
      final response = await _dio.post(
        '/v1/progress',
        data: {
          'courseId':courseId,
          'moduleId':moduleId,
        },
        options: Options(headers: {'Authorization': 'Bearer $token'}),
      );

      print('from progress = ${response.data}');
      if (response.statusCode == 200) {

        try{
          print(' progress done ${response.data['data']['results']} ');
        }catch(e){
          print('error when progress /');
        }

        return response.data;
      } else {
        // Registration failed

        print('from progress error = ${response.data}');
        throw ('get  progress failed: ${response.data}');
      }
    } catch (e) {
      // Handle network or other errors

      print('from   progress error = ${e}');
      throw ('Error  progress  course: $e');
    }
  }
}