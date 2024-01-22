import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

import '../../../../core/services/storage/custom_storage_service.dart';
import '../../../../core/services/storage/storage_key_enums.dart';
import '../../../../core/utils/utils.dart';
import '../../../../generated/locales.g.dart';
import '../../../models/auth_models/login_model.dart';
import '../../../repositories/auth_repository.dart';
import '../../../routes/app_routes.dart';
import '../../common/controllers/user_controller.dart';

class SplashController extends GetxController {
  final customStorageService = Get.find<CustomStorageService>();
  final userController = Get.find<UserController>();
  AuthRepository authRepository = Get.find<AuthRepository>();

  String loading = LocaleKeys.common_loading.tr;
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
        if (email == null || password == null) return;
        User? result = await authRepository.signIn(loginModel: LoginModel(email: email, password: password));
        if (result == null) return;
        userController.user = result;
        Get.offAndToNamed(AppRoutes.home.path);
      },
      onErr: () async {},
    );
  }
}
