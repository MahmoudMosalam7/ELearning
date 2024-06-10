// lib/http_service.dart
import 'package:dio/dio.dart';

import '../../shared/constant.dart';

class HttpServiceRegstration {

  final Dio _dio = Dio(BaseOptions(baseUrl: baseUrl));

  Future<void> registerUser(String name, String email, String phoneNumber, String password,String cpassword) async {
    try {
      print('inside the function of register inside registerUser {{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{');

      final response = await _dio.post(
        '/v1/auth/register',
        data: {'name': name, 'email': email.toLowerCase(),'phone': phoneNumber,
          'roles': 'User' , 'password': password,'passwordConfirm': cpassword},
      );
      print("respons [[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[${response.data}");
      if (response.statusCode == 200) {
        // Registration successful
        return;
      } else {
        // Registration failed
        print("respons [[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[${response.data}");

        throw ('Registration failed: ${response.data}');
      }
    } catch (e) {
      // Handle network or other errors
      print("respons [[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[$e");
      throw ('Error during registration: $e');

    }
  }
}