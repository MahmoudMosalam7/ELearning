import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:learning/Modules/Home/InformationOFCourses/payment_by_method.dart';

import '../../../apis/courseInformation/http_service_courseInformation.dart';
import '../../../network/local/cache_helper.dart';
import '../../../shared/constant.dart';
import 'package:easy_localization/easy_localization.dart';

import '../../../translations/locale_keys.g.dart';

class SelectPayment extends StatelessWidget {
   SelectPayment({super.key,required this.courseID,required this.coursePrice});
  String courseID ;
  String coursePrice ;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(LocaleKeys.SelectPaymentTitle.tr(),style: TextStyle(
          fontWeight: FontWeight.bold
        ),),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: GestureDetector(
                onTap: () {
                  // Add your functionality here
                  Navigator.of(context).push(MaterialPageRoute(builder: (context){
                    return PaymentByMethod(
                      courseId:courseID , coursePrice: coursePrice, numberOFMethod: '01147974226',);
                  }));
                },
                child: Container(
                  width: double.infinity,// تحديد العرض المطلوب للبطاقة
                  height: 70.h,
                  child: Card(
                    elevation: 5.r, // إضافة هامش
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.r), // تحديد شكل الزوايا
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Row(
                        children: [
                          Icon(Icons.payment), // إضافة الأيقونة في البداية
                          SizedBox(width: 10.w), // إضافة مسافة بين الأيقونة والنص
                          Text(LocaleKeys.SelectPaymentEtisalatCash.tr(),
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18.sp
                          ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: GestureDetector(
                onTap: () {
                  // Add your functionality here
                  Navigator.of(context).push(MaterialPageRoute(builder: (context){
                    return PaymentByMethod(
                      courseId:courseID , coursePrice: coursePrice, numberOFMethod: '01147974226',);
                  }));
            },
                child: Container(
                  width: double.infinity,// تحديد العرض المطلوب للبطاقة
                  height: 70.h,
                  child: Card(
                    elevation: 5.r, // إضافة هامش
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.r), // تحديد شكل الزوايا
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Row(
                        children: [
                          Icon(Icons.payment), // إضافة الأيقونة في البداية
                          SizedBox(width: 10.w), // إضافة مسافة بين الأيقونة والنص
                          Text(LocaleKeys.SelectPaymentVodafoneCash.tr(),
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 18.sp
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: GestureDetector(
                onTap: () {
                  // Add your functionality here
                  Navigator.of(context).push(MaterialPageRoute(builder: (context){
                    return PaymentByMethod(
                      courseId:courseID , coursePrice: coursePrice, numberOFMethod: '01147974226',);
                  }));
                },
                child: Container(
                  width: double.infinity,// تحديد العرض المطلوب للبطاقة
                  height: 70.h,
                  child: Card(
                    elevation: 5.r, // إضافة هامش
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.r), // تحديد شكل الزوايا
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Row(
                        children: [
                          Icon(Icons.payment), // إضافة الأيقونة في البداية
                          SizedBox(width: 10.w), // إضافة مسافة بين الأيقونة والنص
                          Text(LocaleKeys.SelectPaymentOrangeCash.tr(),
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 18.sp
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: GestureDetector(
                onTap: () {
                  // Add your functionality here
                  Navigator.of(context).push(MaterialPageRoute(builder: (context){
                    return PaymentByMethod(
                      courseId:courseID , coursePrice: coursePrice, numberOFMethod: '01203175750',);
                  }));
                },
                child: Container(
                  width: double.infinity,// تحديد العرض المطلوب للبطاقة
                  height: 70.h,
                  child: Card(
                    elevation: 5.r, // إضافة هامش
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.r), // تحديد شكل الزوايا
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Row(
                        children: [
                          Icon(Icons.payment), // إضافة الأيقونة في البداية
                          SizedBox(width: 10.w), // إضافة مسافة بين الأيقونة والنص
                          Text(LocaleKeys.SelectPaymentInstaPay.tr(),
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 18.sp
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: GestureDetector(
                onTap: () {
                  // Add your functionality here
                   //Get.to(AddCoupon());
                  _showBottomSheet(context);
                },
                child: Container(
                  width: double.infinity,// تحديد العرض المطلوب للبطاقة
                  height: 70.h,
                  child: Card(
                    elevation: 5.r, // إضافة هامش
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.r), // تحديد شكل الزوايا
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Row(
                        children: [
                          Icon(Icons.payment), // إضافة الأيقونة في البداية
                          SizedBox(width: 10.w), // إضافة مسافة بين الأيقونة والنص
                          Text(LocaleKeys.SelectPaymentByCoupon.tr(),
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 18.sp
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      )
      ,
    );
  }
   final _nameContoller = TextEditingController();

   void _showBottomSheet(BuildContext context) {
     showModalBottomSheet(
       context: context,
       builder: (BuildContext context) {
         return Container(
           // You can customize the content of your bottom sheet here
           padding: EdgeInsets.all(16.0),
           child: Column(
             mainAxisSize: MainAxisSize.min,
             children: [
               ListTile(
                 title: Text(LocaleKeys.SelectPaymentEnterCoupon.tr()
                   ,style: TextStyle(
                     fontWeight: FontWeight.bold,
                   ),
                 ),
                 onTap: () {
                   // Handle share action
                   Navigator.pop(context); // Close the bottom sheet
                 },
               ),
               Padding(
                 padding: const EdgeInsets.all(10.0),
                 child: Row(
                   children: [

                     Expanded(
                       child: TextFormField(
                         controller: _nameContoller,
                         decoration:  InputDecoration(
                           labelText: '${LocaleKeys.SelectPaymentEnterCoupon.tr()}',
                           labelStyle: TextStyle(
                             fontSize: 25.0,
                           ),
                           border: OutlineInputBorder(),
                           prefixIcon: Icon(
                             Icons.payments,
                           ),
                         ),
                         textAlign: TextAlign.start,
                         keyboardType: TextInputType.text,
                         onFieldSubmitted: (value) {},
                         validator: (value) {
                           if (value == null || value.isEmpty) {
                             return '${LocaleKeys.SelectPaymentCouponisrequired.tr()}';
                           }
                           return null;
                         },
                       ),
                     ),

                   ],
                 ),
               ),
               GestureDetector(
                 onTap: () async{
                   if(_nameContoller.text.length <11){
                     Navigator.of(context).push(MaterialPageRoute(builder: (context){
                       return PaymentByMethod(
                         courseId:courseID , coursePrice: coursePrice, numberOFMethod: '01147974226',coupon: _nameContoller.text,);
                     }));
                   }
                   else {
                     //9DCGLZEM100
                      try {
                        HttpServiceCourse  httpServiceCourse = HttpServiceCourse();

                        await httpServiceCourse.paymentByMethod(
                           null, getData?['data']['_id']
                           , coursePrice,
                           '01147974226',
                           courseID,
                           CacheHelper.getData(key: 'token'),
                          coupon: _nameContoller.text
                       );
                       print('payment by coupon success');
                       Fluttertoast.showToast(
                         msg: "Payment  Success",
                         toastLength: Toast.LENGTH_SHORT,
                         gravity: ToastGravity.BOTTOM,
                         timeInSecForIosWeb: 5,
                         backgroundColor: Colors.green,
                         textColor: Colors.white,
                         fontSize: 16.0,
                       );
                     }catch(e){
                       print('excption of payment = $e');
                     }
                   }
                 },
                 child: Container(
                   width: 240.w,
                   height: 40.h,
                   decoration: const BoxDecoration(
                     color: Colors.green,
                   ),
                   child:  Center(child: Text(LocaleKeys.SelectPaymentApply.tr())),
                 ),
               ),
             ],
           ),
         );
       },
     );
   }

}
