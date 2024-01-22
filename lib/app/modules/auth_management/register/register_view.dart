import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../core/constants/app_constants.dart';
import '../../../../core/utils/utils.dart';
import '../../../../core/variables/colors.dart';
import '../../../../generated/locales.g.dart';
import '../../common/widgets/buttons/custom_elevated_button.dart';
import '../../common/widgets/buttons/social_button.dart';
import '../../common/widgets/other/custom_scaffold.dart';
import '../../common/widgets/textfield/custom_text_form_field.dart';
import '../../common/widgets/texts/custom_text.dart';
import 'register_controller.dart';

class RegisterView extends GetView<RegisterController> {
  const RegisterView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      backgroundColor: Get.theme.primaryColor,
      bodyPadding: EdgeInsets.zero,
      body: SingleChildScrollView(
        child: SizedBox(
          height: Get.height,
          child: Column(mainAxisAlignment: MainAxisAlignment.end, children: [Expanded(child: logoSide), borderedBoxSide()]),
        ),
      ),
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
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(height: Utils.extraHighPadding),
          nameField(),
          SizedBox(height: Utils.highPadding),
          emailField(),
          SizedBox(height: Utils.highPadding),
          Row(
            children: [
              Expanded(child: passwordField()),
              SizedBox(width: Utils.normalPadding),
              Expanded(child: passwordRepeatField()),
            ],
          ),
          SizedBox(height: Utils.extraHighPadding),
          SocialButton(
            socialEnum: SocialEnum.apple,
            isRegister: true,
            onPressed: (buttonType) async => controller.appleRegister(),
          ),
          SizedBox(height: Utils.lowPadding),
          SocialButton(
            socialEnum: SocialEnum.facebook,
            isRegister: true,
            onPressed: (buttonType) async => controller.facebookRegister(),
          ),
          SizedBox(height: Utils.lowPadding),
          SocialButton(
            socialEnum: SocialEnum.google,
            isRegister: true,
            onPressed: (buttonType) async => controller.googleRegister(),
          ),
          SizedBox(height: Utils.extraHighPadding),
          InkWell(onTap: () => controller.login(), child: CustomText(LocaleKeys.login_info_text.tr)),
        ],
      ),
    );
  }

  Padding loginButton() => Padding(
        padding: EdgeInsets.only(bottom: Utils.extraHighPadding),
        child: CustomElevatedButton(
          minimumWith: Get.width,
          borderRadius: Utils.normalRadius,
          backgroundColor: Get.theme.primaryColor,
          overlayColor: Get.theme.primaryColor,
          child: CustomText.high("Kayıt Ol", bold: true, textColor: ColorTable.getReversedTextColor),
          onPressed: () => controller.register(),
        ),
      );

  CustomTextFormField passwordField() {
    return CustomTextFormField(
      label: LocaleKeys.common_password_label.tr,
      hintText: LocaleKeys.common_password_hint.tr,
      obscureText: true,
      isRequired: true,
      onChangeComplete: (val) => controller.registerModel.password = val ?? "",
    );
  }

  CustomTextFormField passwordRepeatField() {
    return CustomTextFormField(
      label: LocaleKeys.common_password_repeat.tr,
      hintText: LocaleKeys.common_password_repeat_hint.tr,
      obscureText: true,
      isRequired: true,
      validator: (val) {
        if (val != controller.registerModel.password) {
          return LocaleKeys.common_password_repeat_error.tr;
        }
        return null;
      },
    );
  }

  CustomTextFormField emailField() {
    return CustomTextFormField(
      label: LocaleKeys.common_email_label.tr,
      validator: (val) => validateMail(val),
      hintText: LocaleKeys.common_email_hint.tr,
      isRequired: true,
      onSaved: (val) => controller.registerModel.email = val ?? "",
    );
  }

  CustomTextFormField nameField() {
    return CustomTextFormField(
      label: LocaleKeys.common_username_label.tr,
      hintText: LocaleKeys.common_username_hint.tr,
      isRequired: true,
      onSaved: (val) => controller.registerModel.name = val ?? "",
    );
  }
}
