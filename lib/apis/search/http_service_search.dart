// lib/http_service.dart
import 'package:dio/dio.dart';

import '../../shared/constant.dart';

class HttpServiceSearch {

  final Dio _dio = Dio(BaseOptions(baseUrl: baseUrl));


  Future< Map<String,dynamic> > searchByCourse( String token,String keyword) async {
    try {

      final response = await _dio.get(
        '/v1/course/search/course?keyword=$keyword',

        options: Options(headers: {'Authorization': 'Bearer $token'}),
      );

      print('from search = ${response.data}');
      if (response.statusCode == 200) {

        try{
          print('search${response.data['data']['results']} ');
        }catch(e){
          print('error  get search /');
        }

        return response.data;
      } else {
        // Registration failed

        print('from get search error = ${response.data}');
        throw ('get search failed: ${response.data}');
      }
    } catch (e) {
      // Handle network or other errors

      print('from get search error = ${e}');
      throw ('Error during get search: $e');
    }
  }


}