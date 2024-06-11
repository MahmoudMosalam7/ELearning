import 'package:drop_down_list/model/selected_list_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:learning/shared/constant.dart';
import '../../../../../Layout/Login_Register_ForgetPassword/DropDownList/dropDownList.dart';
import '../../../../../apis/upload_course/http_service_basic_information.dart';
import '../../../../../network/local/cache_helper.dart';
import '../../../../../translations/locale_keys.g.dart';
import '../../../../Home/home.dart';
import '../../../../Home/listView_category.dart';
import 'advanced_information.dart';
import 'package:easy_localization/easy_localization.dart';

class BasicInformation extends StatefulWidget {
  final bool fromUpdateCourse;
  final String courseId;

  const BasicInformation({super.key, required this.fromUpdateCourse, required this.courseId});
  @override
  State<BasicInformation> createState() => _BasicInformationState();
}

class _BasicInformationState extends State<BasicInformation> {
  final _titleContoller = TextEditingController();

  final _subTitleContoller = TextEditingController();

  final _categoryContoller = TextEditingController();

  final _languageContoller = TextEditingController();

  final _levelContoller = TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  HttpServiceBasicInformation basicInformation = HttpServiceBasicInformation();

  String errorMessage = '';
  bool isLoading = false;

  void _basicInformation(String categoryID) async {
    // Reset error message and loading state
    setState(() {
      errorMessage = '';
      isLoading = true;
    });

    try {
      // Add your login logic here, e.g., make API call
      await basicInformation.baicInformation(
        _titleContoller.text,
        _subTitleContoller.text,
        categoryID,
          _languageContoller.text,
          _levelContoller.text,
        CacheHelper.getData(key: 'token'),
          getData!['data']['_id']
      );

      // Login successful, you can navigate to another screen or show a success message
      // ...

      // Fetch data and wait for it to complete
     

      // Now navigate to the appropriate screen based on the fetched data
     
      print('courseId successful!');

      Navigator.push(context, MaterialPageRoute(builder: (context){
        return AdvancedInformationScreen(courseId:'' ,fromUpdateCourse:false ,);
      }));
    } catch (e) {
      // Handle validation errors or network errors
      setState(() {
        errorMessage = 'Error: $e';
        if (errorMessage.contains('422')) {
          // Your code here
          errorMessage ="Valdition Error!";
        }
        else if (errorMessage.contains('401')) {
          // Your code here
          errorMessage =" unauthorized access !";
        }
        else if (errorMessage.contains('500')) {
          // Your code here
          errorMessage =" Server Not Available Now !";
        }
        else{
          errorMessage ="Unexpected Error!";
        }
        Fluttertoast.showToast(
          msg: "create course Field!",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 5,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0,
        );

      });
    } finally {
      // Update loading state
      setState(() {
        isLoading = false;
      });
    }
  }

  void _updateBasicInformation(String categoryID) async {
    // Reset error message and loading state
    setState(() {
      errorMessage = '';
      isLoading = true;
    });

    try {
      // Add your login logic here, e.g., make API call
      await basicInformation.updateBaicInformation(
          _titleContoller.text,
          _subTitleContoller.text,
          categoryID,
          _languageContoller.text,
          _levelContoller.text,
          CacheHelper.getData(key: 'token'),
          getData!['data']['_id'],
         widget.courseId
      );

      // Login successful, you can navigate to another screen or show a success message
      // ...

      // Fetch data and wait for it to complete


      // Now navigate to the appropriate screen based on the fetched data

      print('update basic Info successful!');
      Navigator.pop(context);
    } catch (e) {
      // Handle validation errors or network errors
      setState(() {
        errorMessage = 'Error: $e';
        if (errorMessage.contains('422')) {
          // Your code here
          errorMessage ="Valdition Error!";
        }
        else if (errorMessage.contains('401')) {
          // Your code here
          errorMessage =" unauthorized access !";
        }
        else if (errorMessage.contains('500')) {
          // Your code here
          errorMessage =" Server Not Available Now !";
        }
        else{
          errorMessage ="Unexpected Error!";
        }
        Fluttertoast.showToast(
          msg: "create course Field!",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 5,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0,
        );

      });
    } finally {
      // Update loading state
      setState(() {
        isLoading = false;
      });
    }
  }

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
                Text(LocaleKeys.InstructorBasicInformationBasicInformation.tr(),
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
                      labelText: "${LocaleKeys.InstructorBasicInformationTitle.tr()}",
                      border: OutlineInputBorder(
                          borderRadius:BorderRadius.all(Radius.circular(20.0.r) )
                      )
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return '${LocaleKeys.InstructorBasicInformationTitleisrequired.tr()}';
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
                      labelText: "${LocaleKeys.InstructorBasicInformationSubTitle.tr()}",
                      border: OutlineInputBorder(
                          borderRadius:BorderRadius.all(Radius.circular(20.0.r) )
                      )
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return '${LocaleKeys.InstructorBasicInformationSubTitleisrequired.tr()}';
                    }
                    return null;
                  },


                ),
                SizedBox(height: 10.h,),
                AppTextField(
                  data: [

                    SelectedListItem(name:'Development'  ),
                    SelectedListItem(name:'Marketing' ),
                    SelectedListItem(name:'Sports' ),
                    SelectedListItem(name:'Design' ),
                    SelectedListItem(name:'Business' ),
                    SelectedListItem(name:'Tech' ),
                    SelectedListItem(name:'IT Software' ),
                    SelectedListItem(name:'Chemical' ),
                    SelectedListItem(name:'Physices' ),
                    SelectedListItem(name:'Computer Science(cs)' ),
                  ],
                  textEditingController: _categoryContoller,
                  title: '${LocaleKeys.InstructorBasicInformationSelectCategory.tr()}',
                  hint: '${LocaleKeys.InstructorBasicInformationCategory.tr()}',
                  isDataSelected: true,
                  isFromInstructo: true,
                ),
                SizedBox(height: 10.h,),
                AppTextField(
                  data: [
                    SelectedListItem(name:'Arabic' ),
                    SelectedListItem(name:'English' ),
                    SelectedListItem(name:'Japan' ),
                    SelectedListItem(name:'Germany' ),
                    SelectedListItem(name:'France' ),
                  ],
                  textEditingController: _languageContoller,
                  title: '${LocaleKeys.InstructorBasicInformationSelectLanguage.tr()}',
                  hint: '${LocaleKeys.InstructorBasicInformationLanguage.tr()}',
                  isDataSelected: true,
                  isFromInstructo: true,
                ),
                SizedBox(height: 10.h,),
                AppTextField(
                  data: [
                    SelectedListItem(name:'beginner' ),
                    SelectedListItem(name:'intermidiate' ),
                    SelectedListItem(name:'advanced' ),
                    SelectedListItem(name:'Proficient' ),
                  ],
                  textEditingController: _levelContoller,
                  title: '${LocaleKeys.InstructorBasicInformationSelectLevel.tr()}',
                  hint: '${LocaleKeys.InstructorBasicInformationLevel.tr()}',
                  isDataSelected: true,
                  isFromInstructo:true ,
                ),
                SizedBox(height: 30.h,),

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
                          LocaleKeys.InstructorBasicInformationSaveNext.tr(),
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 22.0.sp,
                          ),
                        )  ,

                        onPressed: (){
                          print('token = ${CacheHelper.getData(key: 'token')}');
                          print('mahmoud ${_categoryContoller.text}');
                          CategoryData? result;
                           List<CategoryData> categoryData2 = getCategoryData(context);
                          for (var category in categoryData2) {
                            print('${category.text}');
                            if (category.text == _categoryContoller.text) {
                              result = category;
                              break;
                            }
                          }

                          if (_formKey.currentState!.validate()) {
                            if(widget.fromUpdateCourse){
                              print('from true mosalam');
                              _updateBasicInformation(result!.id);
                            }
                            else _basicInformation(result!.id);
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
