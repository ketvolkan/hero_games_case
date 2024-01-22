import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

import '../../../../core/services/storage/custom_storage_service.dart';
import '../../../../core/services/storage/storage_key_enums.dart';
import '../../../repositories/auth_repository.dart';
import '../../../routes/app_routes.dart';
import '../widgets/appbar/bottom_app_bar/bottom_app_bar_controller.dart';

class UserController extends GetxController {
  CustomStorageService storageService = Get.find<CustomStorageService>();
  User? user;
  get logOut async {
    if (Get.isRegistered<AuthRepository>()) {
      Get.find<AuthRepository>().signOut();
    }
    Get.find<BottomAppBarController>().changeTabIndex(index: 0);
    await storageService.remove(StorageKeys.email.name);
    await storageService.remove(StorageKeys.password.name);
    await storageService.remove(StorageKeys.rememberMe.name);
    Get.offAndToNamed(AppRoutes.login.path);
  }
}
