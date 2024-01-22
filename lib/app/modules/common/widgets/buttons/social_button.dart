import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../core/utils/utils.dart';
import '../../../../../core/variables/colors.dart';
import '../../../../../generated/locales.g.dart';
import '../texts/custom_text.dart';
import 'custom_elevated_button.dart';

enum SocialEnum { facebook, apple, google, phone, nologin }

extension SocialEnumExtension on SocialEnum {
  String get title {
    switch (this) {
      case SocialEnum.phone:
        return LocaleKeys.social_login_phone.tr;
      case SocialEnum.facebook:
        return LocaleKeys.social_login_facebook.tr;
      case SocialEnum.apple:
        return LocaleKeys.social_login_apple.tr;
      case SocialEnum.google:
        return LocaleKeys.social_login_google.tr;
      default:
        return LocaleKeys.social_login_default.tr;
    }
  }

  String get register {
    switch (this) {
      case SocialEnum.phone:
        return LocaleKeys.social_register_phone.tr;
      case SocialEnum.facebook:
        return LocaleKeys.social_register_facebook.tr;
      case SocialEnum.apple:
        return LocaleKeys.social_register_apple.tr;
      case SocialEnum.google:
        return LocaleKeys.social_register_google.tr;
      default:
        return LocaleKeys.social_register_default.tr;
    }
  }

  String baseUrl(String? value) {
    return "assets/png/$value.png";
  }

  String get images {
    switch (this) {
      case SocialEnum.phone:
        return baseUrl("phoneicon");
      case SocialEnum.facebook:
        return baseUrl(name);
      case SocialEnum.apple:
        return baseUrl(name);
      case SocialEnum.google:
        return baseUrl(name);
      default:
        return '';
    }
  }

  Color? get bgColor {
    switch (this) {
      case SocialEnum.phone:
        return const Color(0xFF47B04B);
      case SocialEnum.facebook:
        return const Color(0xFF165EEF);
      case SocialEnum.apple:
        return const Color(0xFF000000);
      case SocialEnum.google:
        return const Color(0xFFE12B29);
      case SocialEnum.nologin:
        return Colors.white;
      default:
        return null;
    }
  }
}

class SocialButton extends StatelessWidget {
  final String? text;
  final String? iconAsset;
  final Color? color;
  final Color? textcolor;
  final double? borderRadius;
  final Color borderColor;
  final SocialEnum socialEnum;
  final bool isRegister;
  final Function(String buttonType) onPressed;

  const SocialButton({
    Key? key,
    this.text,
    this.iconAsset,
    this.isRegister = false,
    this.color,
    this.borderRadius,
    this.borderColor = Colors.transparent,
    this.textcolor,
    required this.socialEnum,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomElevatedButton(
      backgroundColor: socialEnum.bgColor,
      borderRadius: Utils.normalRadius,
      overlayColor: socialEnum.bgColor,
      onPressed: () => onPressed(socialEnum.title),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          socialEnum.images.isNotEmpty
              ? Image.asset(socialEnum.images, width: Utils.lowIconSize, height: Utils.lowIconSize)
              : const SizedBox.shrink(),
          SizedBox(width: Utils.lowPadding),
          CustomText(isRegister ? socialEnum.register : socialEnum.title, bold: true, textColor: ColorTable.getReversedTextColor),
        ],
      ),
    );
  }
}
