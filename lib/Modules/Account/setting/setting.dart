import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import '../../../network/local/cache_helper.dart';
import '../../../provider/dark_theme_provider.dart';
import 'accountsecurity.dart';

class Setting extends ConsumerStatefulWidget {
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

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Setting'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Container(
          child: Column(
            children: [
              Container(
                width: double.infinity,
                child: MaterialButton(
                  onPressed: () {},
                  child: Row(
                    children: [
                      Column(
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
                      Spacer(flex: 1),
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
                      )
                    ],
                  ),
                ),
              ),
              SizedBox(height: 5.0),
              MaterialButton(
                onPressed: (){
                  Get.to(Acount_Security());
                },
                child:
                Container(
                  width: double.infinity,
                  child: Row(
                    children: [
                      Text("update password"
                        ,style: TextStyle(
                            fontSize: 17.0
                        ),
                      ),
                      Spacer(flex: 1,),
                      Icon(Icons.keyboard_arrow_right),
                    ],
                  ),
                ),

              ),
            ],
          ),
        ),
      ),
    );
  }
}
