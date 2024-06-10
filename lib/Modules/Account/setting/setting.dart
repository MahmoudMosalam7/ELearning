
import 'package:drop_down_list/model/selected_list_item.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../Layout/Login_Register_ForgetPassword/DropDownList/dropDownList.dart';

import '../../../network/local/cache_helper.dart';
import '../../../provider/dark_theme_provider.dart';
import '../../../translations/locale_keys.g.dart';
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

  }
  void selectLanguage()async{
   if(_languageContoller.text =='Arabic'){
     print('from get translation');
     setState(() async{
       await context.setLocale(const Locale('ar'));
     });
   }


  }
  final _languageContoller = TextEditingController();

  @override
  Widget build(BuildContext context) {
   // String x = LocaleKeys.Arabic.tr();
    //selectLanguage();
    return Scaffold(
      appBar: AppBar(
        title:  Text(LocaleKeys.SettingTitle.tr()),
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
                     Column(
                      children: [
                        Text(
                          LocaleKeys.Settingdarkmode.tr(),
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
              isFromInstructo: false,
              data: [
                SelectedListItem(name: "Arabic"),
                SelectedListItem(name:"English"), // Add .tr() for translation
                SelectedListItem(name: "germany"), // Corrected from 'Germany' to 'germany'
                SelectedListItem(name: "france"), // Corrected from 'France' to 'france'
                SelectedListItem(name: "japan"), // Corrected from 'Japan' to 'Japan'
              ],
              textEditingController: _languageContoller,
              title: '${LocaleKeys.InstructorBasicInformationSelectLanguage.tr()}',
              hint: '${LocaleKeys.InstructorBasicInformationLanguage.tr()}',
              isDataSelected: true,
            ),
            SizedBox(height: 10.h),
            MaterialButton(
              onPressed: () {
                //Get.to(Acount_Security());
                Navigator.push(context, MaterialPageRoute(builder: (context){
                  return Acount_Security();
                }));
              },
              child: SizedBox(
                width: double.infinity,
                child:  Row(
                  children: [
                    Text(
                      LocaleKeys.Settingupdatepassword.tr(),
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
class RestartWidget extends StatefulWidget {
  final Widget child;

  RestartWidget({required this.child});

  static void restartApp(BuildContext context) {
    final _RestartWidgetState? state = context.findAncestorStateOfType<_RestartWidgetState>();
    state?.restartApp();
  }

  @override
  _RestartWidgetState createState() => _RestartWidgetState();
}

class _RestartWidgetState extends State<RestartWidget> {
  Key key = UniqueKey();

  void restartApp() {
    setState(() {
      key = UniqueKey();  // تغيير المفتاح لإعادة بناء الشجرة
    });
  }

  @override
  Widget build(BuildContext context) {
    return KeyedSubtree(
      key: key,
      child: widget.child,
    );
  }
}

