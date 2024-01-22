import 'package:get/get.dart';

import '../../../../core/services/storage/custom_storage_service.dart';
import '../../../../core/services/storage/storage_key_enums.dart';
import '../../../../core/utils/utils.dart';
import '../../../routes/app_routes.dart';
import '../../common/controllers/user_controller.dart';

class SplashController extends GetxController {
  final customStorageService = Get.find<CustomStorageService>();
  final userController = Get.find<UserController>();
  String loading = "Yükleniyor...";
  @override
  void onReady() async {
    await getUserInternetInformation();
    await checkSplashLogin();
    Get.offAndToNamed(AppRoutes.login.path);
    super.onReady();
  }

  Future<void> checkSplashLogin() async {
    errorHandler(
      tryMethod: () async {
        bool? rememberMe = customStorageService.read(StorageKeys.rememberMe.name);
        if (!(rememberMe ?? false)) return;
        String? email = customStorageService.read(StorageKeys.email.name);
        String? password = customStorageService.read(StorageKeys.password.name);
        // await userController.logIn(email: email, password: password);
      },
      onErr: () async {},
    );
  }
}
