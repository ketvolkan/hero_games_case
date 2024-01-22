import 'package:get/get.dart';

import '../../../repositories/auth_repository.dart';
import 'register_controller.dart';

class RegisterBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => AuthRepository());
    Get.lazyPut(() => RegisterController());
  }
}
