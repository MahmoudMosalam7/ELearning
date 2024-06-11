import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Payment extends StatelessWidget {

  final _cardNoContoller = TextEditingController();

  final _actCodeContoller = TextEditingController();

  final _validThruContoller = TextEditingController();

  final _cvvContoller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
            child: Text("Select Payment Method",
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),)),

      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Debit/ Credit Card",style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.black,
                fontSize: 20.sp
              ),),
              Image(image: AssetImage("assets/images/payment_image/creditCard.png")),
              SizedBox(height: 20.0.h,),
              Container(
                decoration: BoxDecoration(

                    borderRadius: BorderRadius.circular(50.r)),
                padding: EdgeInsets.all(.0),
          
                child: TextFormField(
                  controller: _cardNoContoller,
                  decoration: InputDecoration(
                      labelText: "Card Number",
                      border: OutlineInputBorder(
                          borderRadius:BorderRadius.all(Radius.circular(20.0) )
                      )
                  ),
          
                ),
              ),
              SizedBox(height: 20.0.h,),
              Container(
                decoration: BoxDecoration(

                    borderRadius: BorderRadius.circular(50.r)),
                padding: EdgeInsets.all(.0),
          
                child: TextFormField(
                  controller: _actCodeContoller,
                  decoration: InputDecoration(
                      labelText: "Act Code",
                      border: OutlineInputBorder(
                          borderRadius:BorderRadius.all(Radius.circular(20.0) )
                      )
                  ),
          
                ),
              ),
              SizedBox(height: 20.0.h,),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(

                        borderRadius: BorderRadius.circular(50.r),
                      ),
                      padding: EdgeInsets.all(0.0),
                      child: TextFormField(
                        controller: _validThruContoller,
                        decoration: InputDecoration(
                          labelText: "Valid Thru",
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(20.0)),
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 20.0.w),
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(

                        borderRadius: BorderRadius.circular(50.r),
                      ),
                      padding: EdgeInsets.all(0.0),
                      child: TextFormField(
                        controller: _cvvContoller,
                        decoration: InputDecoration(
                          labelText: "CVV",
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(20.0)),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20.0.h,),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text("Total Price :",style: TextStyle(
                    color: Colors.grey
                  ),),
                  SizedBox(width: 10.0.w,),
                  Text('199.0 EG',style: TextStyle(

                    fontWeight: FontWeight.bold,
                  ),),
                ],
              ),
              SizedBox(height: 20.0.h,),
              Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20.0.r,),
                    color: Colors.green,
                  ),
                  child: MaterialButton(
          
                    child:  Text(
          
                      'Confirm',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20.0.sp,
                      ),
                    ),
          
                    onPressed:(){},
                    //(){Get.to(const HomeLayout());
                    //},
                  )
              ),
          
            ],
          ),
        ),
      ),
    );
  }
}
