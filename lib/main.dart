import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:learning/provider/dark_theme_provider.dart';
import 'package:learning/translations/codegen_loader.g.dart';

import 'Layout/splashScreen.dart';
import 'Modules/Account/setting/setting.dart';
import 'chat/firebase_options.dart';
import 'network/local/cache_helper.dart';
import 'network/notifications/notifications.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
 await EasyLocalization.ensureInitialized();
  notificationInitialization();  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await FlutterDownloader.initialize(
    debug: true, // optional: set false to disable printing logs to console
  );
  await CacheHelper.init();
  runApp(
    EasyLocalization(
      supportedLocales: [
        Locale('en'),
        Locale('ar'),
        Locale('de'),
        Locale('fr'),
        Locale('ja'),
      ],
      path: 'assets/translations/',
      assetLoader: CodegenLoader(),
      saveLocale: true,
      fallbackLocale: Locale('en'),
      child: ProviderScope(
        child:   RestartWidget(child: MyApp()),

      ),
    ),
  );
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final _themeDarkMode = ref.watch(themeDarkMode);

    return ScreenUtilInit(
      designSize: const Size(360, 690),
      minTextAdapt: true,
      splitScreenMode: true,
      child: GetMaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',

        supportedLocales: context.supportedLocales,
        localizationsDelegates: context.localizationDelegates,
        locale: context.locale,
       theme: ThemeData(
          brightness: _themeDarkMode == ThemeModeEnum.light
              ? Brightness.light
              : Brightness.dark,
        ),
        darkTheme: ThemeData(
          brightness: Brightness.dark,
        ),
        home: const Splash_Screen(),
      ),
    );
  }
}
