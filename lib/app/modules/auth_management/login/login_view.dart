import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../core/constants/app_constants.dart';
import '../../../../core/utils/utils.dart';
import '../../../../core/variables/colors.dart';
import '../../../../generated/locales.g.dart';
import '../../common/widgets/buttons/custom_elevated_button.dart';
import '../../common/widgets/buttons/social_button.dart';
import '../../common/widgets/other/custom_checkbox.dart';
import '../../common/widgets/other/custom_scaffold.dart';
import '../../common/widgets/textfield/custom_text_form_field.dart';
import '../../common/widgets/texts/custom_text.dart';
import 'login_controller.dart';

class LoginView extends GetView<LoginController> {
  const LoginView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      backgroundColor: Get.theme.primaryColor,
      bodyPadding: EdgeInsets.zero,
      body: Column(mainAxisAlignment: MainAxisAlignment.end, children: [logoSide, borderedBoxSide()]),
    );
  }

  SizedBox borderedBoxSide() {
    return SizedBox(
      height: Get.height * 0.7,
      child: DecoratedBox(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.vertical(top: Radius.circular(Utils.extraHighRadius)),
          color: ColorTable.getReversedTextColor,
        ),
        child: loginFormAndButtonSide(),
      ),
    );
  }

  Padding loginFormAndButtonSide() {
    return Padding(
      padding: EdgeInsets.all(Utils.normalPadding),
      child: Column(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [formSide(), loginButton()]),
    );
  }

  Widget get logoSide => Image(image: const AssetImage(AppConstants.logoPath), color: ColorTable.getReversedTextColor);

  Form formSide() {
    return Form(
      key: controller.formKey,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(height: Utils.extraHighPadding),
          emailField(),
          SizedBox(height: Utils.highPadding),
          passwordField(),
          SizedBox(height: Utils.highPadding),
          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [forgotPassword(), rememberMe()]),
          SizedBox(height: Utils.extraHighPadding),
          SocialButton(
            socialEnum: SocialEnum.apple,
            onPressed: (buttonType) async => controller.appleSignIn(),
          ),
          SizedBox(height: Utils.lowPadding),
          SocialButton(
            socialEnum: SocialEnum.facebook,
            onPressed: (buttonType) async => controller.facebookSignIn(),
          ),
          SizedBox(height: Utils.lowPadding),
          SocialButton(
            socialEnum: SocialEnum.google,
            onPressed: (buttonType) async => controller.googleSignIn(),
          ),
          SizedBox(height: Utils.extraHighPadding),
          InkWell(onTap: () => controller.register(), child: CustomText("Halen hesabın yok mu? Kayıt Ol!")),
        ],
      ),
    );
  }

  Obx rememberMe() {
    return Obx(
      () => InkWell(
        onTap: () => controller.rememberMe = !controller.rememberMe,
        child: Row(
          children: [
            CustomCheckBox(value: controller.rememberMe, onChanged: (val) => controller.rememberMe = val ?? false),
            SizedBox(width: Utils.lowPadding),
            CustomText(LocaleKeys.common_remember_me.tr),
          ],
        ),
      ),
    );
  }

  InkWell forgotPassword() => InkWell(
        onTap: () => forgotPassword(),
        child: CustomText(LocaleKeys.common_forgot_password.tr),
      );

  Padding loginButton() => Padding(
        padding: EdgeInsets.only(bottom: Utils.extraHighPadding),
        child: CustomElevatedButton(
          minimumWith: Get.width,
          borderRadius: Utils.normalRadius,
          backgroundColor: Get.theme.primaryColor,
          overlayColor: Get.theme.primaryColor,
          child: CustomText.high(LocaleKeys.common_login.tr, bold: true, textColor: ColorTable.getReversedTextColor),
          onPressed: () => controller.login(),
        ),
      );

  CustomTextFormField passwordField() {
    return CustomTextFormField(
      label: LocaleKeys.common_password_label.tr,
      hintText: LocaleKeys.common_password_hint.tr,
      onSaved: (value) => controller.loginModel.password = value ?? "",
      obscureText: true,
      isRequired: true,
    );
  }

  CustomTextFormField emailField() {
    return CustomTextFormField(
      label: LocaleKeys.common_email_label.tr,
      hintText: LocaleKeys.common_email_hint.tr,
      onSaved: (value) => controller.loginModel.email = value ?? "",
      isRequired: true,
    );
  }
}
