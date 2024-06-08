
import 'package:drop_down_list/drop_down_list.dart';
import 'package:drop_down_list/model/selected_list_item.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../../Modules/Account/setting/setting.dart';
class AppTextField extends StatefulWidget {
  final TextEditingController textEditingController;
  final String title;
  final String hint;
  final bool isDataSelected;
  final List<SelectedListItem>? data;

  const AppTextField({
    required this.textEditingController,
    required this.title,
    required this.hint,
    required this.isDataSelected,
    this.data,
    Key? key,
  }) : super(key: key);

  @override
  _AppTextFieldState createState() => _AppTextFieldState();
}

class _AppTextFieldState extends State<AppTextField> {
  /// This is on text changed method which will display on city text field on changed.
  void onTextFieldTap() {
    DropDownState(
      DropDown(
        isDismissible: true,
        bottomSheetTitle:  Text(
          widget.title,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 20.0,
          ),
        ),
        submitButtonChild: const Text(
          'Done',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        data: widget.data ?? [],
        selectedItems: (List<dynamic> selectedList) async {
          List<String> list = [];
          for (var item in selectedList) {
            if (item is SelectedListItem) {
              list.add(item.name);


                if('Arabic' ==item.name){
                  setState(() async{

                    await context.setLocale(Locale('ar'));
                    RestartWidget.restartApp(context);
                    print('Arabic = ${item.name}');
                  });
                }
                else if('English' ==item.name){
                  setState(()async {

                    await context.setLocale(Locale('en'));
                    RestartWidget.restartApp(context);
                    print('English = ${item.name}');
                  });
                }
                else if('germany' ==item.name){
                  setState(() async{

                    await context.setLocale(Locale('de'));
                    RestartWidget.restartApp(context);
                    print('germany = ${item.name}');
                  });
                }
                else if('france' ==item.name){

                  await context.setLocale(Locale('fr'));
                  RestartWidget.restartApp(context);
                  print('france = ${item.name}');
                }
                else if('japan' ==item.name){

                  await context.setLocale(Locale('ja'));
                  RestartWidget.restartApp(context);
                  print('japan = ${item.name}');
                }
                print('Arabic');

              // to take the name of item selected to print it in the status
              widget.textEditingController.text = item.name;
            }
          }
          Fluttertoast.showToast(
            msg: list.toString(),
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 5,
            backgroundColor: Colors.green,
            textColor: Colors.white,
            fontSize: 16.0,
          );

        },
        //  if you want multiple selection
        enableMultipleSelection: false,
      ),
    ).showModal(context);
  }



  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(widget.title),
        const SizedBox(
          height: 5.0,
        ),
        TextFormField(
          controller: widget.textEditingController,
          cursorColor: Colors.black,
          onTap: widget.isDataSelected
              ? () {
            FocusScope.of(context).unfocus();
            onTextFieldTap();
          }
              : null,
          decoration: InputDecoration(
            filled: true,
            fillColor: Colors.black12,
            contentPadding:
            const EdgeInsets.only(left: 8, bottom: 0, top: 0, right: 15),
            // to make the selected item visible in the status after choose it
            hintText: widget.textEditingController.text == ''? widget.hint :
            widget.textEditingController.text,
            border: const OutlineInputBorder(
              borderSide: BorderSide(
                width: 0,
                style: BorderStyle.none,
              ),
              borderRadius: BorderRadius.all(
                Radius.circular(8.0),
              ),
            ),
          ),
        ),
        const SizedBox(
          height: 15.0,
        ),
      ],
    );
  }
}