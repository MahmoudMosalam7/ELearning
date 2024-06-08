import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AddCoupon extends StatelessWidget {
   AddCoupon({super.key});
  final _nameContoller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Row(
              children: [

                Expanded(
                  child: TextFormField(
                    controller: _nameContoller,
                    decoration: const InputDecoration(
                      labelText: 'Enter Coupon',
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
                        return 'Name is required';
                      }
                      return null;
                    },
                  ),
                ),

              ],
            ),
          ),
          GestureDetector(
            onTap: () {

            },
            child: Container(
              width: 240.w,
              height: 40.h,
              decoration: const BoxDecoration(
                color: Colors.green,
              ),
              child: const Center(child: Text('Apply')),
            ),
          ),

        ],
      ),
    );
  }
}

