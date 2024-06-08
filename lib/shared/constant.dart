
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:dio/dio.dart' as dio; // Import Dio and alias it as 'dio'
import 'package:image_picker/image_picker.dart';

import '../Modules/Home/listView_category.dart';
import '../models/section_model.dart';
import '../translations/locale_keys.g.dart';
//https://dp1fzm8l-3000.uks1.devtunnels.ms/ yassin
//https://qh409mzl-3000.uks1.devtunnels.ms/ nur
const String baseUrl = 'https://qh409mzl-3000.uks1.devtunnels.ms/api';
Map<String, dynamic>? data;
Key _key = UniqueKey();

int score = 0;
Widget buttonWidget({required String text , required VoidCallback onClicked}){
  return ElevatedButton(onPressed: onClicked, child: Text(text,style:TextStyle(
      fontSize: 20,
      color: Colors.white
  ) ,),
    style: ElevatedButton.styleFrom(
        backgroundColor: Colors.blue,
        padding: EdgeInsets.symmetric(horizontal: 32,vertical: 20)
    ),
  );
}


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
