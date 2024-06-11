import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:learning/models/listView_Courses.dart';

import '../../../../apis/update_instructor/http_service_courses.dart';
import '../../../../network/local/cache_helper.dart';
import '../../../../shared/constant.dart';
import 'package:easy_localization/easy_localization.dart';

import '../../../../translations/locale_keys.g.dart';
class InstructorProfites extends StatefulWidget {
  const InstructorProfites({super.key});

  @override
  State<InstructorProfites> createState() => _InstructorProfitesState();
}

class _InstructorProfitesState extends State<InstructorProfites> {
  HttpServiceCoursesOfInstructor httpServiceCoursesOfInstructor = HttpServiceCoursesOfInstructor();
  late Map<String,dynamic> serverData ;
  String errorMessage = '';
  bool isLoading = false;

  List<Product> products = [];
  void _allCoursesOfInstructor() async {
    // Reset error message and loading state
    setState(() {
      errorMessage = '';
      isLoading = true;
    });

    try {
      // Add your login logic here, e.g., make API call
      serverData = await httpServiceCoursesOfInstructor.allCoursesOfInstructor(
          CacheHelper.getData(key: 'token')
      );

      print('get all course successful! $serverData');

      print('serverdata = ${Product.parseProductsFromServer(serverData)}');
      products = Product.parseProductsFromServer(serverData);
      print('Products: $products');
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
  void initState(){
    _allCoursesOfInstructor();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(LocaleKeys.InstructorInstructorProfitesTitle.tr()),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("${LocaleKeys.InstructorInstructorProfitesyourProfits.tr()} ${getData?['data']['profits']}",style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20.sp
              ),),
              SizedBox(height: 20.sp,),
              ListView.separated(
                scrollDirection: Axis.vertical,
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: products.length,
                itemBuilder: (context, index) {
                  final product = products[index];
                  return InkWell(
                    onTap: () {
                      // Handle the tap event here
        
                      //Get.to(CourseContent(courseId: products[index].id, ));
        
                    },
                    child: containerOCoursesProfites(product: product),
                  );
                },
                separatorBuilder: (context, index) => Divider(height: 15.0),
              ),
        
            ],
          ),
        ),
      ),
    );
  }
  Widget containerOCoursesProfites({required Product? product}){
    print('list of profites = $product');
    return Card(
      elevation: 4, // Adds a shadow effect
      child: ListTile(
        title:  Text(product!.title,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
        leading: Stack(
          children: [
            Image.network((product.imageURL)),

          ],
        ),
        trailing: Text('${product.price['currency']}${product.profites}',style: TextStyle(

          fontWeight: FontWeight.bold
        ),),
      ),
    );
  }
}
