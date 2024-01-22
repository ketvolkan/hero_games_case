import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../core/services/storage/custom_storage_service.dart';
import '../../../../core/services/storage/storage_key_enums.dart';
import '../../../../core/utils/getx_extensions.dart';
import '../../../../core/utils/utils.dart';
import '../../../../generated/locales.g.dart';
import '../../../models/auth_models/login_model.dart';
import '../../../repositories/auth_repository.dart';
import '../../../routes/app_routes.dart';
import '../../common/controllers/user_controller.dart';

enum LoginState { Initial, Busy, Loaded, Error }

class LoginController extends GetxController {
  AuthRepository authRepository = Get.find<AuthRepository>();
  UserController userController = Get.find<UserController>();
  CustomStorageService storageService = Get.find<CustomStorageService>();

  final Rx<LoginState> _state = LoginState.Initial.obs;
  LoginState get state => _state.value;
  set state(LoginState value) => _state.value = value;

  final Rx<bool> _rememberMe = false.obs;
  bool get rememberMe => _rememberMe.value;
  set rememberMe(bool value) => _rememberMe.value = value;

  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  LoginModel loginModel = LoginModel();

  @override
  void onInit() {
    ever(_state, (LoginState value) {
      switch (value) {
        case LoginState.Busy:
          Get.showProgressDialog();
          break;
        case LoginState.Loaded:
          if (!Get.isOverlaysClosed) Get.back();
          break;
        case LoginState.Error:
          if (!Get.isOverlaysClosed) Get.back();
          break;
        default:
      }
    });
    super.onInit();
  }

  Future<void> login() async {
    if (formKey.currentState?.validate() ?? false) {
      formKey.currentState?.save();
      if ((loginModel.email ?? "").isEmpty || (loginModel.password ?? "").isEmpty) return;
      await errorHandler(
        tryMethod: () async {
          state = LoginState.Busy;
          User? result = await authRepository.signIn(loginModel: loginModel);
          if (result == null) {
            Get.showToast(LocaleKeys.common_login_error.tr, toastStyle: ToastStyle.WARNING);
            state = LoginState.Error;
            return;
          }
          state = LoginState.Loaded;
          if (rememberMe) {
            await storageService.write(StorageKeys.email.name, loginModel.email);
            await storageService.write(StorageKeys.password.name, loginModel.password);
            await storageService.write(StorageKeys.rememberMe.name, rememberMe);
          }
          userController.user = result;
          Get.offAndToNamed(AppRoutes.home.path);
        },
        onErr: () async {
          state = LoginState.Error;
        },
      );
    }
  }

  void register() => Get.offAndToNamed(AppRoutes.register.path);
  Future<void> forgotPassword() async {}
  Future<void> googleSignIn() async {}
  Future<void> facebookSignIn() async {}
  Future<void> appleSignIn() async {}
}
