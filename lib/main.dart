import 'dart:async';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/adapters.dart';

import 'app/modules/common/controllers/route_controller.dart';
import 'app/modules/common/controllers/user_controller.dart';
import 'app/modules/common/widgets/appbar/bottom_app_bar/bottom_app_bar_controller.dart';
import 'app/modules/system_management/splash/splash_binding.dart';
import 'app/routes/app_pages.dart';
import 'app/routes/app_routes.dart';
import 'app/theme/app_theme.dart';
import 'core/services/languages/language_service.dart';
import 'core/services/storage/custom_storage_service.dart';
import 'core/services/storage/storage_key_enums.dart';
import 'firebase_options.dart';
import 'generated/locales.g.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await Hive.initFlutter();
  await Hive.openBox(StorageKeys.customStorage.name);
  await initApp();
}

Future<void> initApp() async {
  Get.put(CustomStorageService());
  Get.put(RouteController());
  Get.put(BottomAppBarController());
  Get.put(UserController());
  Get.put(LanguageService());
  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final languageService = Get.find<LanguageService>();
    RouteController routeController = Get.find<RouteController>();
    return GetMaterialApp(
      title: "Hero Games Case",
      debugShowCheckedModeBanner: false,
      defaultTransition: Transition.fade,
      opaqueRoute: Get.isOpaqueRouteDefault,
      popGesture: Get.isPopGestureEnable,
      enableLog: kDebugMode ? true : false,
      initialRoute: AppRoutes.splash.path,
      initialBinding: SplashBinding(),
      fallbackLocale: LanguageService.fallbackLocale,
      locale: languageService.currentLocale,
      translationsKeys: AppTranslation.translations,
      builder: routeController.materialRouteBuilder,
      routingCallback: routeController.materialRouteCallBack,
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      supportedLocales: locales.values,
      theme: AppThemes.light,
      getPages: AppPages.PAGES,
    );
  }
}
