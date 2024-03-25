// lib/http_service.dart
import 'package:dio/dio.dart';
import '../../network/local/cache_helper.dart';
import '../../shared/constant.dart';
class HttpServiceLogin {

  final Dio _dio = Dio(BaseOptions(baseUrl: baseUrl));

  Future<void> loginUser( String email, String password) async {
    try {
      final response = await _dio.post(
        '/v1/auth/login',
        data: { 'email': email,'password': password},
      );
      print(response);
      print(response.data);
      if (response.statusCode == 200) {
        // Login successful
       try{
         print(response.data['data']['token']);
         await CacheHelper.saveData(key:'token', value:response.data['data']['token']);
         print('save toke is done ');
       }catch(e){
         print('error when save token /');
       }

        //    print('Token]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]: ${loginModel.data!.token}');
         //
        return;
      } else {
        // Registration failed
        throw ('Login failed: ${response.data}');
      }
    } catch (e) {
      // Handle network or other errors
      throw ('Error during Login: $e');
    }
  }
}