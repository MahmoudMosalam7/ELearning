import 'package:get/get.dart';
import 'package:dio/dio.dart' as dio; // Import Dio and alias it as 'dio'
import 'package:image_picker/image_picker.dart';

import '../Modules/Home/listView_category.dart';
import '../models/section_model.dart';
//https://dp1fzm8l-3000.uks1.devtunnels.ms yassin
//https://qh409mzl-3000.uks1.devtunnels.ms/ nur
const String baseUrl = 'https://dp1fzm8l-3000.uks1.devtunnels.ms/api';
Map<String, dynamic>? data;


List<CategoryData> categoryData = [
  CategoryData(text: 'Development', id: '65ccf45dc5878a651ba20c6b'),
  CategoryData(text: 'Marketing', id: '65ccf46fc5878a651ba20c6f'),
  CategoryData(text: 'Sports', id: '65cd21eb87bb347d80d0910f'),
  CategoryData(text: 'Design',  id: '65ecd14c271787e0f6fd07bb'),
  CategoryData(text: 'Tech', id: '65ecd179271787e0f6fd07bf'),
  CategoryData(text: 'Business',  id: '65ecd19a271787e0f6fd07c3'),
  CategoryData(text: 'IT Software',  id: '65ecd1b5271787e0f6fd07c7'),
  CategoryData(text: 'Chemical',id: '65ecd1c2271787e0f6fd07cb'),
  CategoryData(text: 'Physices',  id: '65ecd1d9271787e0f6fd07cf'),
  CategoryData(text: 'Computer Science(cs)',  id: '66046eaf698d7afd28450d0c'),
  // Add more button data with text and color
];

Map<String,String> categoryName = {

  'IT Software':'',
  '' : '',
  '' : '',
  // Add more button data with text and color
};

List<Section> sections = [];
 String id = '' ;
Map<String ,dynamic> ?getData ;

Future<dio.MultipartFile> uploadImageToApi(XFile image) async {
  print('image inside uplod = ${image.mimeType}');
  return dio.MultipartFile.fromFile(image.path, filename: image.path.split('/').last);
}
