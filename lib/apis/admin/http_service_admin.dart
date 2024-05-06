// lib/http_service.dart
import 'package:dio/dio.dart';

import '../../shared/constant.dart';

class HttpServiceAdmin {

  final Dio _dio = Dio(BaseOptions(baseUrl: baseUrl));

  Future<void> addUser(String name, String email, String status, String password,String cpassword,
      String token
      ) async {
    try {
      final response = await _dio.post(
        '/v1/users',
        data: {'name': name, 'email': email,
          'roles': status , 'password': password,'passwordConfirm': cpassword},
          options: Options(headers: {'Authorization': 'Bearer $token'})
      );
      print("respons [[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[${response.data}");
      if (response.statusCode == 200) {
        // Registration successful
        return;
      } else {
        // Registration failed
        print("respons [[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[${response.data}");

        throw ('addNewUser failed: ${response.data}');
      }
    } catch (e) {
      // Handle network or other errors
      print("respons [[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[$e");
      throw ('Error during addNewUser: $e');

    }
  }

  Future<void> updateUser(String name, String email, String status,
      String token, String userId
      ) async {
    try {
      print('name = $name');
      print('email = $email');
      print('status = $status');
      print('token = $token');
      print('userId = $userId');
      final response = await _dio.put(
          '/v1/users/${userId}',
          data: {'name': name, 'email': email,
            'roles': status , },
          options: Options(headers: {'Authorization': 'Bearer $token'})
      );
      print("respons [[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[${response.data}");
      if (response.statusCode == 200) {
        // Registration successful
        return;
      } else {
        // Registration failed
        print("respons [[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[${response.data}");

        throw ('updateUser failed: ${response.data}');
      }
    } catch (e) {
      // Handle network or other errors
      print("respons [[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[$e");
      throw ('Error during update user: $e');

    }
  }

  Future<void> updateUserPassword(String password, String confirmPassword, String token, String userId
      ) async {
    try {
      print('password = $password');
      print('confrimPass = $confirmPassword');
      print('token = $token');
      print('userId = $userId');
      final response = await _dio.put(
          '/v1/users/changePassword/${userId}',
          data: {'password': password, 'passwordConfirm': confirmPassword,
             },
          options: Options(headers: {'Authorization': 'Bearer $token'})
      );
      print("respons [[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[${response.data}");
      if (response.statusCode == 200) {
        // Registration successful
        return;
      } else {
        // Registration failed
        print("respons [[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[${response.data}");

        throw ('updateUserPassword failed: ${response.data}');
      }
    } catch (e) {
      // Handle network or other errors
      print("respons [[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[$e");
      throw ('Error during update user password: $e');

    }
  }

  Future< Map<String,dynamic> > allUser( String token) async {
    try {

      final response = await _dio.get(
        '/v1/users',
        options: Options(headers: {'Authorization': 'Bearer $token'}),
      );

      print('from all user = ${response.data}');
      if (response.statusCode == 200) {

        try{
          print('save get all user is done ${response.data['data']['results']} ');
        }catch(e){
          print('error when save get all user /');
        }

        return response.data;
      } else {
        // Registration failed

        print('from get all user error = ${response.data}');
        throw ('get all user failed: ${response.data}');
      }
    } catch (e) {
      // Handle network or other errors

      print('from get all user error = ${e}');
      throw ('Error during get all user: $e');
    }
  }


  Future<void> deleteUser( String userId,
      String token
      ) async {
    try {
      final response = await _dio.delete(
          '/v1/users/$userId',
          options: Options(headers: {'Authorization': 'Bearer $token'})
      );
      print("respons from delete users[[[[[[[[[[[[[[[${response.data}");
      if (response.statusCode == 200) {
        // Registration successful
        return;
      } else {
        // Registration failed
        print("respons [[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[${response.data}");

        throw ('delete User failed: ${response.data}');
      }
    } catch (e) {
      // Handle network or other errors
      print("respons [[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[$e");
      throw ('Error during delete User: $e');

    }
  }
  Future< Map<String,dynamic> > getAllTransaction( String token) async {
    try {

      final response = await _dio.get(
        '/v1/transaction',
        options: Options(headers: {'Authorization': 'Bearer $token'}),
      );

      print('from all user = ${response.data}');
      if (response.statusCode == 200) {

        try{
          print('save get all user is done ${response.data['data']} ');
        }catch(e){
          print('error when save get All Transaction /');
        }

        return response.data;
      } else {
        // Registration failed

        print('from get All Transaction error = ${response.data}');
        throw ('get All Transactionfailed: ${response.data}');
      }
    } catch (e) {
      // Handle network or other errors

      print('from get All Transaction error = ${e}');
      throw ('Error during get All Transaction: $e');
    }
  }

  Future< void> approveTransaction( String token,String transactionId) async {
    try {

      final response = await _dio.post(
        '/v1/transaction/approve/${transactionId}',
        options: Options(headers: {'Authorization': 'Bearer $token'}),
      );

      print('from approve tranaction = ${response.data}');
      if (response.statusCode == 200) {

        try{
          print('save approve tranaction is done ${response.data['data']} ');
        }catch(e){
          print('error when approve tranaction Transaction /');
        }

        return response.data;
      } else {
        // Registration failed

        print('from gapprove tranaction error = ${response.data}');
        throw ('get approve tranaction failed: ${response.data}');
      }
    } catch (e) {
      // Handle network or other errors

      print('from approve tranaction error = ${e}');
      throw ('Error during approve tranaction: $e');
    }
  }

  Future< void> rejectTransaction( String token,String transactionId) async {
    try {

      final response = await _dio.post(
        '/v1/transaction/reject/${transactionId}',
        options: Options(headers: {'Authorization': 'Bearer $token'}),
      );

      print('from rejectTransaction  = ${response.data}');
      if (response.statusCode == 200) {

        try{
          print('save rejectTransaction is done ${response.data['data']} ');
        }catch(e){
          print('error when rejectTransaction /');
        }

        return response.data;
      } else {
        // Registration failed

        print('from rejectTransaction error = ${response.data}');
        throw ('get rejectTransaction failed: ${response.data}');
      }
    } catch (e) {
      // Handle network or other errors

      print('from rejectTransaction error = ${e}');
      throw ('Error rejectTransaction: $e');
    }
  }
}