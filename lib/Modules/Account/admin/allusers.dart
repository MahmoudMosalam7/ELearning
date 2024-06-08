import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:learning/Modules/Account/admin/update_user_information.dart';
import 'package:learning/Modules/Account/admin/update_user_password.dart';
import 'package:easy_localization/easy_localization.dart';
import '../../../apis/admin/http_service_admin.dart';
import '../../../models/usermodel.dart';
import '../../../network/local/cache_helper.dart';
import '../../../translations/locale_keys.g.dart';

class AllUsers extends StatefulWidget {
  const AllUsers({super.key});

  @override
  State<AllUsers> createState() => _AllUsersState();
}

class _AllUsersState extends State<AllUsers> {
  HttpServiceAdmin httpServiceAdmin = HttpServiceAdmin();
  late Map<String,dynamic> serverData ;
  String errorMessage = '';
  bool isLoading = false;
 void initState(){
   _allUsers();
   super.initState();
 }
  List<UserModel> users = [];
  void _allUsers() async {
    // Reset error message and loading state
    setState(() {
      errorMessage = '';
      isLoading = true;
    });

    try {
      // Add your login logic here, e.g., make API call
      serverData = await httpServiceAdmin.allUser(
          CacheHelper.getData(key: 'token')
      );

      print('get all users successful! $serverData');

      if (serverData != null) {
        print('serverdata = ${UserModel.parseProductsFromServer(serverData)}');
        users = UserModel.parseProductsFromServer(serverData);
        print('users: $users');
      } else {
        throw Exception('Server data is null');
      }
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
  void _deleteUser(String userId) async {
    setState(() {
      errorMessage = '';
      isLoading = true;
    });

    try {
      // Add your delete logic here, e.g., make API call to delete user
      await httpServiceAdmin.deleteUser(
          userId,
          CacheHelper.getData(key: 'token')
      );

      print('delete user successful!');

      // Remove the deleted user from the users list
      setState(() {
        users.removeWhere((user) => user.id == userId);
      });

      Fluttertoast.showToast(
        msg: "User deleted successfully",
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
          errorMessage = "Validation Error!";
        }
        else if (errorMessage.contains('401')) {
          errorMessage = "Unauthorized access!";
        }
        else if (errorMessage.contains('500')) {
          errorMessage = "Server Not Available Now!";
        }
        else{
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
   // _allUsers();
    return Scaffold(
      appBar: AppBar(
        title: Text(LocaleKeys.AdminAllUsersTitle.tr()),
      ),
      body:SingleChildScrollView(
        child: ListView.separated(
          scrollDirection: Axis.vertical,
          physics: NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemCount: users.length,
          itemBuilder: (context, index) {
            final user = users[index];
            return InkWell(
              onTap: () {
                // Handle the tap event here

              },
              child: _userUI( user),
            );
          },
          separatorBuilder: (context, index) => Divider(height: 15.0),
        ),
      ) ,
    );
  }
  Widget _userUI(UserModel userModel) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.circular(10.0),
      ),
      padding: EdgeInsets.all(8.0),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(10.0),
            child: Container(
              width: 80.0,
              height: 80.0,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Image.network(
                userModel.imageUrl,
                fit: BoxFit.cover,
              ),
            ),
          ),
          SizedBox(width: 10.0),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  userModel.name,
                  style: TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 5.0),
                Text(
                  userModel.email,
                  style: TextStyle(
                    fontSize: 16.0,
                  ),
                ),
                SizedBox(height: 5.0),
                Text(
                  userModel.phone,
                  style: TextStyle(
                    fontSize: 14.0,
                  ),
                ),
                SizedBox(height: 5.0),
                Text(
                  userModel.roles,
                  style: TextStyle(
                    fontSize: 12.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          Row(
            children: [
              IconButton(
                onPressed: () {
                  // Add edit functionality here
                  _showBottomSheet(context,userModel.id);
                },
                icon: Icon(Icons.edit),
                color: Colors.blue,
              ),
              IconButton(
                onPressed: () {
                  // Add delete functionality here
                  _deleteUser(userModel.id);
                },
                icon: Icon(Icons.delete),
                color: Colors.red,
              ),
            ],
          ),
        ],
      ),
    );
  }
  void _showBottomSheet(BuildContext context,String userId) {
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
                title: Text(LocaleKeys.AdminAllUsersWhatYouWillUpdata.tr()
                  ,style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                onTap: () {
                  // Handle share action
                  Navigator.pop(context); // Close the bottom sheet
                },
              ),
              ListTile(
                leading: Icon(Icons.dashboard_customize_rounded),
                title: Text(LocaleKeys.AdminAllUsersUpdateInformation.tr()),
                onTap: () {
                  // Handle edit action

                  Navigator.pop(context);// Close the bottom sheet
                  Navigator.of(context).push(MaterialPageRoute(builder: (context){
                    return UpdateUser(userId: userId,);
                  }));
                },
              ),
              ListTile(
                leading: Icon(Icons.password),
                title: Text(LocaleKeys.AdminAllUsersUpdatePassword.tr()),
                onTap: () {
                  // Handle delete action

                  Navigator.pop(context);// Close the bottom sheet
                  Navigator.of(context).push(MaterialPageRoute(builder: (context){
                    return UpdateUserPassword(userId: userId,);
                  }));
                },
              ),
            ],
          ),
        );
      },
    );
  }




}
