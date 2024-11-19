
import 'dart:io';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:hodhod/app/binding/initial_binding.dart';
import 'package:hodhod/app/config/app_colors.dart';
import 'package:hodhod/app/config/app_theme.dart';
import 'package:hodhod/app/routes/app_pages.dart';
import 'package:hodhod/app/routes/app_routes.dart';
import 'package:hodhod/app/services/storage_service.dart';
import 'package:hodhod/app/translations/app_translations.dart';
import 'package:hodhod/data/api/http_service.dart';

import 'app/util/default_firebase_options.dart';
import 'ui/splash/view/splash.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  await initServices();
  if (Platform.isIOS){
    await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform,name: "hod-hod-app");
  }else{
    await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  }
  runApp(const MyApp());
  configLoading();
}

Future<void> initServices() async {
  await Get.putAsync<StorageService>(() => StorageService().init());
  await Get.putAsync<HttpService>(() => HttpService().init());
}

void configLoading() {
  EasyLoading.instance
    // ..displayDuration = const Duration(milliseconds: 2000)
    ..indicatorType = EasyLoadingIndicatorType.fadingCircle
    ..loadingStyle = EasyLoadingStyle.dark
    ..indicatorSize = 45.0
    ..radius = 10.0
    ..maskType = EasyLoadingMaskType.black
    ..progressColor = Colors.yellow
    ..backgroundColor = AppColors.primary
    ..indicatorColor = Colors.white
    ..textColor = Colors.yellow
    ..maskColor = Colors.blue.withOpacity(0.5)
    ..userInteractions = false
    ..dismissOnTap = false;
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    final storage = Get.find<StorageService>();
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (x, y) => GetMaterialApp(
        // ignore: unnecessary_null_comparison
        translations: AppTranslations(),
        locale: Locale(storage.getLanguageCode()),
        fallbackLocale: Locale(storage.getLanguageCode()),
        initialBinding: InitialBinding(),
        initialRoute: AppRoutes.splash,
        getPages: appPages,
        defaultTransition: Transition.cupertino,
        builder: EasyLoading.init(),
        theme: lightTheme,
        darkTheme: lightTheme,
        home: Splash(),
        debugShowCheckedModeBanner: false,
        title: 'Hod Hod',
      ),
    );
  }
}
