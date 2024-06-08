// lib/http_service.dart
import 'package:dio/dio.dart';

import '../../network/local/cache_helper.dart';
import '../../shared/constant.dart';
class HttpServiceReviews {

  final Dio _dio = Dio(BaseOptions(baseUrl: baseUrl));

  Future<void> createReview( String courseId,double rating,
  String comment
  ,String token) async {
    try {
      print('coursid=$courseId');
      print('rating=$rating');
      print('comment=$comment');
      print('token=$token');
      final response = await _dio.post(
        '/v1/review',
        data: { 'courses': courseId,'ratings':rating
        ,'title':comment
        },
          options: Options(
            headers: {
              'Authorization': 'Bearer $token',
            },
      ));
      print(response);
      print(response.data);
      if (response.statusCode == 200) {
        //  successful
        try{
          print(response.data['data']['token']);
          //   await CacheHelper.saveData(key: 'token', value:response.data['data']['token']);
          //   print('save toke is done ');
        }catch(e){
          print('error when create Reviews /');
        }

        //    print('Token]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]: ${loginModel.data!.token}');
        //
        return;
      } else {
        // Registration failed
        throw ('create Reviews failed: ${response.data}');
      }
    } catch (e) {
      // Handle network or other errors
      throw ('Error during create Reviews: $e');
    }
  }
}