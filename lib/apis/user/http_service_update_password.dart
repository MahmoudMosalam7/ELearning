// lib/http_service.dart
import 'package:dio/dio.dart';
import '../../shared/constant.dart';
class HttpServiceUpdatePassword {

  final Dio _dio = Dio(BaseOptions(baseUrl: baseUrl));

  Future<void> updateUserPassword( String oldPassword,String newPassword,
      String confirmPassword,String token) async {
    try {

      print('update password is $oldPassword ');
      print('update password is $newPassword ');
      print('update password is $confirmPassword ');
      print('update password is $token ');
      final response = await _dio.put(
        '/v1/users/changeMyPassword',
        data: { 'oldPassword': oldPassword,'newPassword': newPassword,
          'passwordConfirm': confirmPassword,},
        options: Options(headers: {'Authorization': 'Bearer $token'}),

      );
      print(response);
      print(response.data);
      if (response.statusCode == 200) {
        // Login successful
        try{
           print('update password is done ');
        }catch(e){
          print('error when update password/');
        }

          return;
      } else {
        // Registration failed
        throw ('update password failed: ${response.data}');
      }
    } catch (e) {
      // Handle network or other errors
      throw ('Error during update password: $e');
    }
  }
}