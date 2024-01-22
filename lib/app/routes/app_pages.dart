import 'package:get/get.dart';

import '../modules/auth_management/login/login_binding.dart';
import '../modules/auth_management/login/login_view.dart';
import '../modules/auth_management/register/register_binding.dart';
import '../modules/auth_management/register/register_view.dart';
import '../modules/home/home_binding.dart';
import '../modules/home/home_view.dart';
import '../modules/system_management/settings/settings_binding.dart';
import '../modules/system_management/settings/settings_view.dart';
import '../modules/system_management/splash/splash_binding.dart';
import '../modules/system_management/splash/splash_view.dart';
import 'app_routes.dart';

class AppPages {
  static var PAGES = [
    //* SPLASH
    GetPage(
      name: AppRoutes.splash.path,
      page: () => const SplashView(),
      binding: SplashBinding(),
      transition: Transition.noTransition,
    ),
    //* Login
    GetPage(
      name: AppRoutes.login.path,
      page: () => const LoginView(),
      binding: LoginBinding(),
      transition: Transition.noTransition,
    ),
    //* Register
    GetPage(
      name: AppRoutes.register.path,
      page: () => const RegisterView(),
      binding: RegisterBinding(),
      transition: Transition.noTransition,
    ),
    //* Home
    GetPage(
      name: AppRoutes.home.path,
      page: () => const HomeView(),
      binding: HomeBinding(),
    ),
    //* Settings
    GetPage(
      name: AppRoutes.settings.path,
      page: () => const SettingsView(), //Todo
      binding: SettingsBinding(),
    ),
  ];
}
