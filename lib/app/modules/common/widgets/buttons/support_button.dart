import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../../core/utils/utils.dart';
import '../../../../../../core/variables/colors.dart';
import '../texts/custom_text.dart';
import 'custom_elevated_button.dart';

class SupportButton extends StatelessWidget {
  final Widget icon;
  final String text;
  final Function()? onPressed;
  const SupportButton({Key? key, required this.icon, required this.text, this.onPressed}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomElevatedButton(
      minimumWith: Get.width,
      backgroundColor: Get.theme.primaryColor,
      overlayColor: Get.theme.primaryColor,
      borderRadius: Utils.extraHighRadius,
      onPressed: onPressed,
      child: Row(
        children: [
          CircleAvatar(backgroundColor: ColorTable.getReversedTextColor, maxRadius: Utils.lowIconSize, child: icon),
          Expanded(child: Center(child: CustomText.high(text, textColor: ColorTable.getReversedTextColor))),
        ],
      ),
    );
  }
}
