import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:learning/provider/dark_theme_provider.dart';

import 'Layout/splashScreen.dart';
import 'network/local/cache_helper.dart';

void main()async {
  WidgetsFlutterBinding.ensureInitialized();
  await CacheHelper.init();
  runApp( ProviderScope(child: MyApp()));
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context ,WidgetRef ref) {
    final _themeDarkMode = ref.watch(themeDarkMode);
    return ScreenUtilInit(
      designSize: const Size(360, 690),
      minTextAdapt: true,
      splitScreenMode: true,
      child: GetMaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',

        theme: ThemeData(
          brightness: _themeDarkMode == ThemeModeEnum.light
              ? Brightness.light
              : Brightness.dark,
          // Define your light mode theme colors here
        ),
        darkTheme: ThemeData(
          brightness: Brightness.dark,
          // Define your dark mode theme colors here
        ),
      
        home: const Splash_Screen(),
      ),
    );
  }
}
