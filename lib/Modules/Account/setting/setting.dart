import 'package:drop_down_list/model/selected_list_item.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../Layout/Login_Register_ForgetPassword/DropDownList/dropDownList.dart';
import '../../../network/local/cache_helper.dart';
import '../../../provider/dark_theme_provider.dart';
import 'accountsecurity.dart';

class Setting extends ConsumerStatefulWidget {
  const Setting({super.key});

  @override
  ConsumerState<Setting> createState() => _Setting();
}

class _Setting extends ConsumerState<Setting> {
  late bool isActive;

  @override
  void initState() {
    super.initState();
    isActive = CacheHelper.getBool(key: 'darkMode') ?? false;
    //selectLanguage();
  }
  void selectLanguage()async{

      setState(() async{
        await context.setLocale(const Locale('ar'));
      });

  }
  final _languageContoller = TextEditingController();

  @override
  Widget build(BuildContext context) {
   // String x = LocaleKeys.Arabic.tr();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Setting'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          children: [
            SizedBox(
              width: double.infinity,
              child: MaterialButton(
                onPressed: () {},
                child: Row(
                  children: [
                    const Column(
                      children: [
                        Text(
                          "dark mode ",
                          style: TextStyle(
                            fontSize: 17.5,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ],
                    ),
                    const Spacer(flex: 1),
                    Switch(
                      value: isActive,
                      onChanged: (value) {
                        ref.read(themeDarkMode.notifier).selectMode();
                        setState(() {
                          isActive = value;
                          CacheHelper.saveData(key: 'darkMode', value: value);
                        });
                      },
                      activeColor: Colors.green,
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 5.0.h),
            AppTextField(
              data: [
                SelectedListItem(name: "Arabic"),
                SelectedListItem(name:"English"), // Add .tr() for translation
                SelectedListItem(name: "germany"), // Corrected from 'Germany' to 'germany'
                SelectedListItem(name: "france"), // Corrected from 'France' to 'france'
                SelectedListItem(name: "japan"), // Corrected from 'Japan' to 'Japan'
              ],
              textEditingController: _languageContoller,
              title: 'Select Language',
              hint: 'Language',
              isDataSelected: true,
            ),
            SizedBox(height: 10.h),
            MaterialButton(
              onPressed: () {
                Get.to(Acount_Security());
              },
              child: SizedBox(
                width: double.infinity,
                child: const Row(
                  children: [
                    Text(
                      "update password",
                      style: TextStyle(
                        fontSize: 17.0,
                      ),
                    ),
                    Spacer(flex: 1),
                    Icon(Icons.keyboard_arrow_right),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
