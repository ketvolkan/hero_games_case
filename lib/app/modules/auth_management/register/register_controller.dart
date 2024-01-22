import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hero_games_case/generated/locales.g.dart';

import '../../../../core/utils/getx_extensions.dart';
import '../../../../core/utils/utils.dart';
import '../../../models/auth_models/register_model.dart';
import '../../../repositories/auth_repository.dart';
import '../../../routes/app_routes.dart';
import '../../common/controllers/user_controller.dart';

enum RegisterState { Initial, Busy, Loaded, Error }

class RegisterController extends GetxController {
  AuthRepository authRepository = Get.find<AuthRepository>();
  UserController userController = Get.find<UserController>();

  final Rx<RegisterState> _state = RegisterState.Initial.obs;
  RegisterState get state => _state.value;
  set state(RegisterState value) => _state.value = value;

  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  RegisterModel registerModel = RegisterModel();
  @override
  void onInit() {
    ever(_state, (RegisterState value) {
      switch (value) {
        case RegisterState.Busy:
          Get.showProgressDialog();
          break;
        case RegisterState.Loaded:
          if (!Get.isOverlaysClosed) Get.back();
          break;
        case RegisterState.Error:
          if (!Get.isOverlaysClosed) Get.back();
          break;
        default:
      }
    });
    super.onInit();
  }

  Future<void> register() async {
    if (formKey.currentState?.validate() ?? false) {
      formKey.currentState?.save();
      await errorHandler(
        tryMethod: () async {
          state = RegisterState.Busy;
          User? result = await authRepository.register(registerModel: registerModel);
          if (result == null) {
            Get.showToast(LocaleKeys.common_register_error.tr, toastStyle: ToastStyle.ERROR);
            state = RegisterState.Error;
            return;
          }
          state = RegisterState.Loaded;
          userController.user = result;
          Get.offAndToNamed(AppRoutes.home.path);
        },
        onErr: () async {
          state = RegisterState.Error;
        },
      );
    }
  }

  void login() => Get.offAndToNamed(AppRoutes.login.path);
  Future<void> appleRegister() async {}
  Future<void> googleRegister() async {}
  Future<void> facebookRegister() async {}
}
