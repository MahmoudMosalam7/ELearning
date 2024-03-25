// lib/http_service.dart
import 'package:dio/dio.dart';
import '../../network/local/cache_helper.dart';
import '../../shared/constant.dart';
class HttpServiceGetData {

  final Dio _dio = Dio(BaseOptions(baseUrl: baseUrl));

  Future<Map<String, dynamic>> getData(String token) async {

    try {
      // Make GET request with Authorization header
      Response response = await _dio.get(
        '/v1/users/getMe',
        options: Options(headers: {'Authorization': 'Bearer $token'}),
      );

      // Check if the request was successful (status code 200)
      if (response.statusCode == 200) {
        // Parse and return the response data
        return response.data;
      } else {
        // Handle errors, if any
        print('Error - Status Code: ${response.statusCode}');
        // You might want to throw an exception here or handle the error accordingly
        throw Exception('Failed to fetch data');
      }
    } catch (error) {
      // Handle Dio errors
      print('Dio error: $error');
      // You might want to throw an exception here or handle the error accordingly
      throw Exception('Failed to fetch data');
    }
  }
}