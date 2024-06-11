import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:easy_localization/easy_localization.dart';
import '../../../apis/admin/http_service_admin.dart';
import '../../../models/payment.dart';
import '../../../network/local/cache_helper.dart';
import '../../../translations/locale_keys.g.dart';

class AdminPayment extends StatefulWidget {
  const AdminPayment({super.key});

  @override
  State<AdminPayment> createState() => _AdminPaymentState();
}

class _AdminPaymentState extends State<AdminPayment> {
  HttpServiceAdmin httpServiceAdmin = HttpServiceAdmin();
  late Map<String,dynamic> serverData ;
  String errorMessage = '';
  bool isLoading = false;
  void initState(){
    _getAllTransaction();
    super.initState();
  }
  List<Payment> transactions = [];
  void _getAllTransaction() async {
    // Reset error message and loading state
    setState(() {
      errorMessage = '';
      isLoading = true;
    });

    try {
      // Add your login logic here, e.g., make API call
      serverData = await httpServiceAdmin.getAllTransaction(
          CacheHelper.getData(key: 'token')
      );

      print('get all transaction successful! $serverData');
      print('serverdata = ${Payment.parsePaymentFromServer(serverData)}');
      transactions = Payment.parsePaymentFromServer(serverData);
      print('transactions: $transactions');
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
          msg: "$errorMessage",
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
  void _approveTransaction(String transactionId) async {
    // Reset error message and loading state
    setState(() {
      errorMessage = '';
      isLoading = true;
    });

    try {
      // Add your login logic here, e.g., make API call
       httpServiceAdmin.approveTransaction(
          CacheHelper.getData(key: 'token'),
           transactionId
      );
       setState(() {
         transactions.removeWhere((transaction) => transaction.transactionId == transactionId);
       });

       Fluttertoast.showToast(
         msg: "approve Tanaction successfully",
         toastLength: Toast.LENGTH_SHORT,
         gravity: ToastGravity.BOTTOM,
         timeInSecForIosWeb: 5,
         backgroundColor: Colors.green,
         textColor: Colors.white,
         fontSize: 16.0,
       );


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
          msg: "$errorMessage",
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
  void _rejectTransaction(String transactionId) async {
    // Reset error message and loading state
    setState(() {
      errorMessage = '';
      isLoading = true;
    });

    try {
      // Add your login logic here, e.g., make API call
      httpServiceAdmin.rejectTransaction(
          CacheHelper.getData(key: 'token'),
          transactionId
      );
      setState(() {
        transactions.removeWhere((transaction) => transaction.transactionId == transactionId);
      });

      Fluttertoast.showToast(
        msg: "reject Tanaction successfully",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 5,
        backgroundColor: Colors.green,
        textColor: Colors.white,
        fontSize: 16.0,
      );


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
          msg: "$errorMessage",
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
      body:SingleChildScrollView(
        child: ListView.separated(
          scrollDirection: Axis.vertical,
          physics: NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemCount: transactions.length,
          itemBuilder: (context, index) {
            final transaction = transactions[index];

            return InkWell(
              onTap: () {
                // Handle the tap event here

                //Get.to(CourseInformation(courseId: products[index].id));

              },
              child: listOfPayment( transaction),
            );
          },
          separatorBuilder: (context, index) => Divider(height: 15.0),
        ),
      ) ,

    );
  }
  Widget listOfPayment(Payment payment){
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Container(
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey),
            borderRadius: BorderRadius.circular(10.r),
          ),
          padding: EdgeInsets.all(10.r),
          child: Row(
            children: [
              Image.network(
                '${payment.imageUrl}',
                width: 140.w,
                height: 130.h,
              ),
              SizedBox(width: 10.w),
              Column(
                children: [
                  //
                  Text('${LocaleKeys.AdminPaymentprice.tr()} : ${payment.price} '),
                  SizedBox(height: 10.h),
                  Text('${LocaleKeys.AdminPaymentcurrency.tr()} : ${payment.currency} '),
                  //Text('${payment.userID}'),
                ],
              ),
            ],
          ),
        ),
        SizedBox(width: 10.w),
        IconButton(
          onPressed: () {
            // Add your accept functionality here
            setState(() {
              _approveTransaction(payment.transactionId);
            });
          },
          icon: Icon(Icons.check),
          color: Colors.green,
        ),
        IconButton(
          onPressed: () {
            // Add your reject functionality here
            setState(() {
              _rejectTransaction(payment.transactionId);
            });
          },
          icon: Icon(Icons.close),
          color: Colors.red,
        ),
      ],
    );
  }

}
