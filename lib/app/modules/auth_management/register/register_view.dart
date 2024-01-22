import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../core/constants/app_constants.dart';
import '../../../../core/utils/utils.dart';
import '../../../../core/variables/colors.dart';
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
          Row(
            children: [
              Expanded(child: nameField()),
              SizedBox(width: Utils.normalPadding),
              Expanded(child: surnameField()),
            ],
          ),
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
          InkWell(onTap: () => controller.login(), child: CustomText("Hesabın Var Mı? Giriş Yap!")),
        ],
      ),
    );
  }

  InkWell forgotPassword() => InkWell(
        onTap: () => forgotPassword(),
        child: CustomText("Şifremi Unuttum"),
      );

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
    return const CustomTextFormField(
      label: "Şifre",
      hintText: "Şifre Giriniz",
      obscureText: true,
      isRequired: true,
    );
  }

  CustomTextFormField passwordRepeatField() {
    return const CustomTextFormField(
      label: "Şifre Tekrar",
      hintText: "Şifreyi Tekrar Giriniz",
      obscureText: true,
      isRequired: true,
    );
  }

  CustomTextFormField emailField() {
    return CustomTextFormField(
      label: "Email",
      validator: (val) => validateMail(val),
      hintText: "Email",
      isRequired: true,
    );
  }

  CustomTextFormField nameField() {
    return const CustomTextFormField(
      label: "Ad",
      hintText: "Ad",
      isRequired: true,
    );
  }

  CustomTextFormField surnameField() {
    return const CustomTextFormField(
      label: "Soyad",
      hintText: "Soyad",
      isRequired: true,
    );
  }
}
