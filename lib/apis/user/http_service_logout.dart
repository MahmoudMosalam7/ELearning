// lib/http_service.dart
import 'package:dio/dio.dart';
import '../../network/local/cache_helper.dart';
import '../../shared/constant.dart';
class HttpServiceLogout {

  final Dio _dio = Dio(BaseOptions(baseUrl: baseUrl));

  Future<void> logoutUser( String token) async {
    try {
      print('from logout $token');
      final response = await _dio.delete(
        '/v1/auth/logout',
        options: Options(headers: {'Authorization': 'Bearer $token'}),

      );
      print(response);
      print(response.data);
      if (response.statusCode == 200) {
        // Login successful
        try{    print(' logout is done ');
        }catch(e){
          print('error when logout token /');
        }

        //    print('Token]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]: ${loginModel.data!.token}');
        //
        return;
      } else {
        // Registration failed
        throw ('logout failed: ${response.data}');
      }
    } catch (e) {
      // Handle network or other errors
      throw ('Error during logout: $e');
    }
  }
}