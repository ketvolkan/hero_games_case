import 'package:get/get.dart';

import '../../repositories/hobby_repository.dart';
import 'home_controller.dart';

class HomeBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => HobbyRepository());
    Get.lazyPut(() => HomeController());
  }
}
