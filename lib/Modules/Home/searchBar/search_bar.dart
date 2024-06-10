import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../../apis/search/http_service_search.dart';
import '../../../models/listView_Courses.dart';
import '../../../network/local/cache_helper.dart';
import '../InformationOFCourses/CourseInformation.dart';
import '../Product.dart';

class SearchBarContainer extends StatefulWidget {
  const SearchBarContainer({super.key});

  @override
  State<SearchBarContainer> createState() => _SearchBarContainerState();
}

class _SearchBarContainerState extends State<SearchBarContainer> {
  TextEditingController textEditingController = TextEditingController();
  HttpServiceSearch httpServiceSearch = HttpServiceSearch();
  late Map<String, dynamic> serverData;
  String errorMessage = '';
  bool isLoading = false;

  List<Product> products = [];

  void _allCourses(String keyword) async {
    // Reset error message and loading state
    setState(() {
      errorMessage = '';
      isLoading = true;
    });

    try {
      // Add your login logic here, e.g., make API call
      serverData = await httpServiceSearch.searchByCourse(
        CacheHelper.getData(key: 'token'),
        keyword,
      );

      print('get all course successful! $serverData');

      if (serverData != null) {
        print('serverdata = ${Product.parseProductsFromServer(serverData)}');
        products = Product.parseProductsFromServer(serverData);
        print('Products: $products');
      } else {
        throw Exception('Server data is null');
      }
    } catch (e) {
      // Handle validation errors or network errors
      setState(() {
        errorMessage = 'Error: $e';
        if (errorMessage.contains('422')) {
          // Your code here
          errorMessage = "Validation Error!";
        } else if (errorMessage.contains('401')) {
          // Your code here
          errorMessage = "Unauthorized access!";
        } else if (errorMessage.contains('500')) {
          // Your code here
          errorMessage = "Server Not Available Now!";
        } else {
          errorMessage = "Unexpected Error!";
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
      // appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 64.0),
        child: SearchAnchor(
          builder: (BuildContext context, SearchController controller) {
            return SearchBar(
              controller: controller,
              padding: MaterialStatePropertyAll<EdgeInsets>(
                EdgeInsets.symmetric(horizontal: 16),
              ),
              onTap: () {
                if (controller.text.length >= 3) {
                  _allCourses(controller.text);
                  controller.openView();
                }
              },
              onChanged: (value) {
                if (value.length >= 3) {
                  _allCourses(value);
                  controller.openView();
                }
              },
              leading: Icon(Icons.search),
            );
          },
          suggestionsBuilder: (BuildContext context, SearchController controller) {
            return List<GestureDetector>.generate(products.length, (index) {
              final Product product = products[index];
              return GestureDetector(
                onTap: () {
                  Get.to(CourseInformation(
                    courseId: product.id,
                    fromInstructor: false,
                  ));
                },
                child: ProductListItem(product: product),
              );
            });
          },
        ),
      ),
    );
  }
}
