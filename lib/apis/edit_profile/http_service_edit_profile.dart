// lib/http_service.dart
import 'package:dio/dio.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:developer';
import '../../shared/constant.dart';
class HttpServiceEditProfile {

  final Dio _dio = Dio(BaseOptions(baseUrl: baseUrl));

  Future<void> updateMe(String name, String email, String bio, String phone, String gender, XFile image, String token) async {
    print(']]]]]]]]]]]]]]]]]]]]]from api edit');
    try {
      List<String> allowedFileTypes = ['image/jpeg','image/jpg', 'image/png', 'video/mp4', 'application/pdf', 'application/vnd.ms-powerpoint'];
      String? fileType = await image.mimeType;
      inspect(image);
      print('image = ${image.path}');
      print('fileType = $fileType');
      /*if (!allowedFileTypes.contains(fileType)) {
        print('Invalid file type. Only JPEG, PNG, MP4, PDF, and PPT files are allowed.');
        return;
      }*/

      var im = await uploadImageToApi(image);
      inspect(im);
      print(']]]]]]]]]]]]]]]]]]]]]from api edit');
      print(']]]]]]]]]]]]]]]]]]]]]from api edit im = ${im.filename}');

      FormData formData = FormData.fromMap({
        'name': name,
        'email': email,
        'profileImage': await MultipartFile.fromFile(image.path, filename: image.path.split('/').last),
        'bio': bio,
        'phone': phone,
        'gender': gender,
      });

      final response = await _dio.put(
        '/v1/users/updateMe',
        data: formData,
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
            'Content-Type': 'multipart/form-data',
          },
        ),
      );

      print(response);
      print(response.data);

      if (response.statusCode == 200) {
        try {
          print('success from api ');
          print(response.data['data']['token']);
        } catch (e) {
          print('error when save token /');
        }
        return;
      } else {
        throw (' failed: ${response.data}');
      }
    } catch (e) {
      print('error = $e');
      throw ('Error during Login: $e');
    }
  }

}