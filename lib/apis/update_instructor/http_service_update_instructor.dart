// lib/http_service.dart
import 'package:dio/dio.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:developer';
import '../../shared/constant.dart';
class HttpServiceUpdateInstructor {

  final Dio _dio = Dio(BaseOptions(baseUrl: baseUrl));

  Future<void> updateMe(String jobTitle, String jobDescription,
      String facebookUrl, String linkedinUrl, String instagramUrl, XFile image, String token) async {
    print(']]]]]]]]]]]]]]]]]]]]]from api update');
    try {
       String? fileType = await image.mimeType;
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
        'jobDescription': jobDescription,
        'jobTitle': jobTitle,
        'profileImage': await MultipartFile.fromFile(image.path, filename: image.path.split('/').last),
        'facebookUrl': facebookUrl,
        'linkedinUrl': linkedinUrl,
        'instagramUrl': instagramUrl,
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
  Future<Map<String,dynamic>> getInstructorInfo(String intstructorId, String token) async {
    print(']]]]]]]]]]]]]]]]]]]]]from api instToken = $token');
    print(']]]]]]]]]]]]]]]]]]]]]from api instId = $intstructorId');
    print(']]]]]]]]]]]]]]]]]]]]]from api update');
    try {

      FormData formData = FormData.fromMap({
        'instrucotrid': intstructorId,

      });

      final response = await _dio.get(
        '/v1/users/getInstructorPage',
        data: {  'instrucotrid': intstructorId,},
          options: Options(headers: {'Authorization': 'Bearer $token'})
      );

      print(response);
      print(response.data);

      if (response.statusCode == 200) {
        try {
          print('success from api ');
          print(response.data['data']['token']);
          return response.data;
        } catch (e) {
          print('error when save token /');
        }
        return {};
      } else {
        throw (' failed: ${response.data}');
      }
    } catch (e) {
      print('error = $e');
      throw ('Error during Login: $e');
    }
  }

}