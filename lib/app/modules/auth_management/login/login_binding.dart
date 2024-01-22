import 'package:get/get.dart';

import '../../../repositories/auth_repository.dart';
import 'login_controller.dart';

class LoginBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => AuthRepository());
    Get.lazyPut(() => LoginController());
  }
}
