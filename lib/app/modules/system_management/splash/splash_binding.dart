import 'package:get/get.dart';

import '../../../repositories/auth_repository.dart';
import 'splash_controller.dart';

class SplashBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => AuthRepository());
    Get.lazyPut(() => SplashController());
  }
}
