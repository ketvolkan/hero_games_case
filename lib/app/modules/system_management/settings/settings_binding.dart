import 'package:get/get.dart';

import '../../../repositories/auth_repository.dart';
import 'settings_controller.dart';

class SettingsBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => AuthRepository());
    Get.lazyPut(() => SettingsController());
  }
}
