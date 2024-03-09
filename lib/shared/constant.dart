import 'package:get/get.dart';
import 'package:dio/dio.dart' as dio; // Import Dio and alias it as 'dio'
import 'package:image_picker/image_picker.dart';

import '../models/section_model.dart';

const String baseUrl = 'https://qh409mzl-3000.uks1.devtunnels.ms/api';
List<String> categoryName = [
   'Devleopment',
   'Design',
  'Tech',
   'Marketing',
   'Business',
   'Sports',
   'IT Software',
   'Chemical',
   'Physices',
  // Add more button data with text and color
];

List<Section> sections = [];
 String id = '' ;
Map<String ,dynamic> ?getData ;

Future<dio.MultipartFile> uploadImageToApi(XFile image) async {
  print('image inside uplod = ${image.mimeType}');
  return dio.MultipartFile.fromFile(image.path, filename: image.path.split('/').last);
}
