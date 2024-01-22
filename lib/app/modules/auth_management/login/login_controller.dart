import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../core/utils/getx_extensions.dart';
import '../../../../core/utils/utils.dart';
import '../../../routes/app_routes.dart';

enum LoginState { Initial, Busy, Loaded, Error }

class LoginController extends GetxController {
  final Rx<LoginState> _state = LoginState.Initial.obs;
  LoginState get state => _state.value;
  set state(LoginState value) => _state.value = value;

  final Rx<bool> _rememberMe = false.obs;
  bool get rememberMe => _rememberMe.value;
  set rememberMe(bool value) => _rememberMe.value = value;

  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  String email = '';
  String password = '';

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
      if (email.isEmpty || password.isEmpty) return;
      await errorHandler(
        tryMethod: () async {
          state = LoginState.Busy;
          //TODO
          state = LoginState.Loaded;
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
