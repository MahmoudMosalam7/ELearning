import 'package:dio/dio.dart';
import 'package:image_picker/image_picker.dart';
import '../../shared/constant.dart';
import 'dart:io';

class HttpServiceEditProfile {
  final Dio _dio = Dio(BaseOptions(baseUrl: baseUrl));

  Future<void> updateMe(String name,  String bio, String phone,
      String gender, XFile image, String token) async {
    try {
      // Print statements for debugging
      print('Name: $name');
      print('Bio: $bio');
      print('Phone: $phone');
      print('Token: $token');

      // Creating MultipartFile
      final imageFile = File(image.path);
      final imageFileName = image.path.split('/').last;
      final formData = FormData.fromMap({
        'name': name,
        'profileImage': await MultipartFile.fromFile(
          imageFile.path,
          filename: imageFileName,
        ),
        'bio': bio,
        'phone': phone,
        'gender': gender,
      });

      // Sending request
      final response = await _dio.put(
        '/v1/users/updateMe',
        data: formData,
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
          },
        ),
      );

      // Handling response
      print('Response Status: ${response.statusCode}');
      print('Response Data: ${response.data}');

      if (response.statusCode == 200) {
        print('Update successful');
        // Handle success, maybe parse response data
      } else {
        print('Update failed');
        throw Exception('Failed to update profile: ${response.data}');
      }
    } catch (e) {
      print('Error: $e');
      throw Exception('Error during profile update: $e');
    }
  }

}
