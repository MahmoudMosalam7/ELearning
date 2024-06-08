import 'package:drop_down_list/model/selected_list_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../../../../../Layout/Login_Register_ForgetPassword/DropDownList/dropDownList.dart';
import '../../../../../apis/upload_course/add_price_compiler_delete_publish.dart';
import '../../../../../network/local/cache_helper.dart';
import 'package:easy_localization/easy_localization.dart';

import '../../../../../translations/locale_keys.g.dart';
class AddPriceAndPublish extends StatefulWidget {
  const AddPriceAndPublish({super.key, required this.courseId, required this.fromInstructor});
  final String courseId;
  final bool fromInstructor;

  @override
  State<AddPriceAndPublish> createState() => _AddPriceAndPublishState();
}

class _AddPriceAndPublishState extends State<AddPriceAndPublish> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final _amountContoller = TextEditingController();
  final _currencyContoller = TextEditingController();
  final _compilerContoller = TextEditingController();
  final _spreadSheetContoller = TextEditingController();
  HttpServiceCoursePriceAndPublishAndDeleteAndCompiler httpCourse = HttpServiceCoursePriceAndPublishAndDeleteAndCompiler();
  String errorMessage = '';

  Future<void> _addCoursePrice() async {
    try {
      // Fetch course data only if not already loading
      String id = CacheHelper.getData(key: 'courseId');
      if(widget.fromInstructor){
        id = widget.courseId;
        print('widget.fromInstructor id = $id');
      }
      String amount = _amountContoller.text  ;
      print('id = $id');
      await httpCourse.addCoursePrice(
          amount,
          _currencyContoller.text,
          CacheHelper.getData(key: 'token'),
          id);

      errorMessage = "";
      Fluttertoast.showToast(
        msg: "add Course price Success",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 5,
        backgroundColor: Colors.green,
        textColor: Colors.white,
        fontSize: 16.0,
      );
      _currencyContoller.text ='';
      _amountContoller.text ='';

    } catch (e) {
      print('Error add course price : $e');
      setState(() {
        errorMessage = 'Error: $e';
        if (errorMessage.contains('422')) {
          errorMessage = "Check your Emails link !";
        } else {
          errorMessage = "Unexpected Error!";
        }
      });
      Fluttertoast.showToast(
        msg: errorMessage,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 5,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0,
      );
    }
  }
  Future<void> _publishCourse() async {
    try {
      // Fetch course data only if not already loading
      String id = CacheHelper.getData(key: 'courseId');
      if(widget.fromInstructor){
        id = widget.courseId;
        print('widget.fromInstructor id = $id');
      }
      print('id = $id');
      await httpCourse.publishCourse(
          CacheHelper.getData(key: 'token'),
          id);

      errorMessage = "";
      Fluttertoast.showToast(
        msg: "add publishCourse Success",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 5,
        backgroundColor: Colors.green,
        textColor: Colors.white,
        fontSize: 16.0,
      );
      _currencyContoller.text ='';
      _amountContoller.text ='';

    } catch (e) {
      print('Error publishCourse : $e');
      setState(() {
        errorMessage = 'Error: $e';
        if (errorMessage.contains('422')) {
          errorMessage = "Check your Emails link !";
        } else {
          errorMessage = "Unexpected Error!";
        }
      });
      Fluttertoast.showToast(
        msg: errorMessage,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 5,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0,
      );
    }
  }

  Future<void> _addCourseSpreedSheet() async {
    try {
      // Fetch course data only if not already loading
      String id = CacheHelper.getData(key: 'courseId');
      if(widget.fromInstructor){
        id = widget.courseId;
        print('widget.fromInstructor id = $id');
      }
      print('id = $id');
      await httpCourse.addSpreadSheetLinkOfCourse(
          _spreadSheetContoller.text,
          CacheHelper.getData(key: 'token'),
          id);

      errorMessage = "";
      Fluttertoast.showToast(
        msg: "add Spreed Sheet Success",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 5,
        backgroundColor: Colors.green,
        textColor: Colors.white,
        fontSize: 16.0,
      );
      _currencyContoller.text ='';
      _amountContoller.text ='';

    } catch (e) {
      print('Error add Spreed Sheet : $e');
      setState(() {
        errorMessage = 'Error: $e';
        if (errorMessage.contains('422')) {
          errorMessage = "Check your Emails link !";
        } else {
          errorMessage = "Unexpected Error!";
        }
      });
      Fluttertoast.showToast(
        msg: errorMessage,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 5,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0,
      );
    }
  }

  Future<void> _addCourseCompiler() async {
    try {
      // Fetch course data only if not already loading
      String id = CacheHelper.getData(key: 'courseId');
      if(widget.fromInstructor){
        id = widget.courseId;
        print('widget.fromInstructor id = $id');
      }
      print('id = $id');
      await httpCourse.addCourseCompiler(
          _compilerContoller.text,
          CacheHelper.getData(key: 'token'),
          id);

      errorMessage = "";
      Fluttertoast.showToast(
        msg: "add Course compiler Success",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 5,
        backgroundColor: Colors.green,
        textColor: Colors.white,
        fontSize: 16.0,
      );
      _currencyContoller.text ='';
      _amountContoller.text ='';

    } catch (e) {
      print('Error add Course compiler data: $e');
      setState(() {
        errorMessage = 'Error: $e';
        if (errorMessage.contains('422')) {
          errorMessage = "Check your Emails link !";
        } else {
          errorMessage = "Unexpected Error!";
        }
      });
      Fluttertoast.showToast(
        msg: errorMessage,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 5,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0,
      );
    }
  }
  @override
  Widget build(BuildContext context) {
    bool? comp = CacheHelper.getData(key: 'compiler');
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
                Text(LocaleKeys.InstructorAddPriceAndPublishAddPriceAndTest.tr(),
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20.0.sp
                  ),
                ),
                SizedBox(height: 20.h,),
                TextFormField(
                  keyboardType: TextInputType.number,
                  obscureText: false,
                  controller: _amountContoller,
                  decoration: InputDecoration(
                      labelText: "${LocaleKeys.InstructorAddPriceAndPublishamount.tr()}",
                      border: OutlineInputBorder(
                          borderRadius:BorderRadius.all(Radius.circular(20.0.r) )
                      )
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return '${LocaleKeys.InstructorAddPriceAndPublishAmountisrequired.tr()}';
                    }
                    return null;
                  },


                ),
                   SizedBox(height: 10.h,),
                AppTextField(
                  data: [
                    //
                    SelectedListItem(name:'${LocaleKeys.InstructorAddPriceAndPublishEGP.tr()}' ),
                    SelectedListItem(name:'${LocaleKeys.InstructorAddPriceAndPublishUSD.tr()}' ),
                  ],
                  textEditingController: _currencyContoller,
                  title: '${LocaleKeys.InstructorAddPriceAndPublishSelectCurrency.tr()}',
                  hint: '${LocaleKeys.InstructorAddPriceAndPublishCurrency.tr()}',
                  isDataSelected: true,
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
                          LocaleKeys.InstructorAddPriceAndPublishAddPrice.tr(),
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 22.0.sp,
                          ),
                        )  ,

                        onPressed: (){
                          if (_currencyContoller.text.isNotEmpty && _amountContoller.text.isNotEmpty) {

                            _addCoursePrice();
                          }
                        },),
                    ),
                  ],
                ),
                SizedBox(height: 30.h,),
                Text("""${LocaleKeys.InstructorAddPriceAndPublishPleaseenteraGoogleSheetlinkcontainingthefollowing.tr()}
  ${LocaleKeys.InstructorAddPriceAndPublishColumnAcontainsthequestions.tr()}
  ${LocaleKeys.InstructorAddPriceAndPublishColumnsfromBtoEeachcolumncontainsananswer.tr()}
  ${LocaleKeys.InstructorAddPriceAndPublishColumnFcontainsthecorrectanswer.tr()}"""),
                SizedBox(height: 30.h,),
                  TextFormField(
                    keyboardType: TextInputType.text,
                    obscureText: false,
                    controller: _spreadSheetContoller,
                    decoration: InputDecoration(
                        labelText: "https://docs.google.com/spreadsheets",
                        border: OutlineInputBorder(
                            borderRadius:BorderRadius.all(Radius.circular(20.0.r) )
                        )
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return '${LocaleKeys.InstructorAddPriceAndPublishspreadsheetlinkisrequired.tr()}';
                      }
                      return null;
                    },


                  ),

                  SizedBox(height: 10.h,),

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
                            '${LocaleKeys.InstructorAddPriceAndPublishspreadAddSpreadSheetLink.tr()}',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 18.0.sp,
                            ),
                          )  ,

                          onPressed: (){
                            if (_spreadSheetContoller.text.isNotEmpty ) {
                              _addCourseSpreedSheet();
                            }
                          },),
                      ),
                    ],
                  ),
                  SizedBox(height: 30.h,),
                if(comp != null)
                TextFormField(
                  keyboardType: TextInputType.text,
                  obscureText: false,
                  controller: _compilerContoller,
                  decoration: InputDecoration(
                      labelText: "${LocaleKeys.InstructorAddPriceAndPublishspreadcompiler.tr()}",
                      border: OutlineInputBorder(
                          borderRadius:BorderRadius.all(Radius.circular(20.0.r) )
                      )
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return '${LocaleKeys.InstructorAddPriceAndPublishspreadcompilerisrequired.tr()}';
                    }
                    return null;
                  },


                ),
                if(comp != null)
                SizedBox(height: 10.h,),
                if(comp != null)
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
                          '${LocaleKeys.InstructorAddPriceAndPublishspreadAddCompiler.tr()}',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 22.0.sp,
                          ),
                        )  ,

                        onPressed: (){
                          if (_compilerContoller.text.isNotEmpty ) {
                            _addCourseCompiler();
                          }
                        },),
                    ),
                  ],
                ),
                if(comp != null)
                SizedBox(height: 30.h,),
                if(!widget.fromInstructor)
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
                          '${LocaleKeys.InstructorAddPriceAndPublishspreadPublish.tr()}',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 22.0.sp,
                          ),
                        )  ,

                        onPressed: (){
                          _publishCourse();
                        },),
                    ),
                  ],
                ),
                if(!widget.fromInstructor)
                  SizedBox(height: 10.h,),
                if(!widget.fromInstructor)
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
                          '${LocaleKeys.InstructorAddPriceAndPublishspreadSaveNext.tr()}',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 22.0.sp,
                          ),
                        )  ,

                        onPressed: (){
                          Navigator.pop(context);
                          Navigator.pop(context);
                          Navigator.pop(context);
                          Navigator.pop(context);
                        },),
                    ),
                  ],
                ),




              ],
            ),
          ),
        ),
      ),
    );
  }
}
