import 'package:drop_down_list/model/selected_list_item.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../../../Layout/Login_Register_ForgetPassword/DropDownList/dropDownList.dart';
import 'advanced_information.dart';

class BasicInformation extends StatelessWidget {
  final _titleContoller = TextEditingController();
  final _subTitleContoller = TextEditingController();
  final _categoryContoller = TextEditingController();
  final _languageContoller = TextEditingController();
  final _levelContoller = TextEditingController();
  final _courseDurationContoller = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Basic Information',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20.0.sp
                  ),
                ),
                SizedBox(height: 20.h,),
                TextFormField(
                  keyboardType: TextInputType.visiblePassword,
                  obscureText: false,
                  controller: _titleContoller,
                  decoration: InputDecoration(
                      labelText: "Title",
                      border: OutlineInputBorder(
                          borderRadius:BorderRadius.all(Radius.circular(20.0.r) )
                      )
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return ' Title is required';
                    }
                    return null;
                  },


                ),
                SizedBox(height: 10.h,),
                TextFormField(
                  keyboardType: TextInputType.visiblePassword,
                  obscureText: false,
                  controller: _subTitleContoller,
                  decoration: InputDecoration(
                      labelText: "SubTitle",
                      border: OutlineInputBorder(
                          borderRadius:BorderRadius.all(Radius.circular(20.0.r) )
                      )
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'SubTitle is required';
                    }
                    return null;
                  },


                ),
                SizedBox(height: 10.h,),
                AppTextField(
                  data: [
                    SelectedListItem(name:'Devleopment' ),
                    SelectedListItem(name:'Design' ),
                    SelectedListItem(name:'Tech' ),
                    SelectedListItem(name:'Marketing' ),
                    SelectedListItem(name:'Business' ),
                    SelectedListItem(name:'Sports' ),
                    SelectedListItem(name:'IT Software' ),
                    SelectedListItem(name:'Chemical' ),
                    SelectedListItem(name:'Physices' ),
                  ],
                  textEditingController: _categoryContoller,
                  title: 'Select Category',
                  hint: 'Category',
                  isDataSelected: true,
                ),
                SizedBox(height: 10.h,),
                AppTextField(
                  data: [
                    SelectedListItem(name:'Arabic' ),
                    SelectedListItem(name:'English' ),
                    SelectedListItem(name:'Italy' ),
                    SelectedListItem(name:'Germany' ),
                    SelectedListItem(name:'France' ),
                  ],
                  textEditingController: _languageContoller,
                  title: 'Select Language',
                  hint: 'Language',
                  isDataSelected: true,
                ),
                SizedBox(height: 10.h,),
                AppTextField(
                  data: [
                    SelectedListItem(name:'Level 0' ),
                    SelectedListItem(name:'Level 1' ),
                    SelectedListItem(name:'Level 2' ),
                    SelectedListItem(name:'Level 3' ),
                  ],
                  textEditingController: _levelContoller,
                  title: 'Select Level',
                  hint: 'Level',
                  isDataSelected: true,
                ),
                SizedBox(height: 15.h,),
                TextFormField(
                  keyboardType: TextInputType.visiblePassword,
                  obscureText: false,
                  controller: _courseDurationContoller,
                  decoration: InputDecoration(
                      labelText: "Course Duration",
                      border: OutlineInputBorder(
                          borderRadius:BorderRadius.all(Radius.circular(20.0.r) )
                      )
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Course Duration is required';
                    }
                    return null;
                  },


                ),
                SizedBox(height: 15.h,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: 230.w,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20.0.r,),
                        color: Colors.green,
                      ),
                      child: MaterialButton(
                        child:  Text(
                          'Save & Next',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 22.0.sp,
                          ),
                        )  ,

                        onPressed: (){
                          if (_formKey.currentState!.validate()) {
                             Get.to(AdvancedInformationScreen());
                          }
                          //Get.to(Payment());
                        },),
                    ),
                  ],
                )




              ],
            ),
          ),
        ),
      ),
    );
  }
}
