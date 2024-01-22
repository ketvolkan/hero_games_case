import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../core/utils/utils.dart';
import '../../../../../core/variables/colors.dart';

class CustomExtendedFabButton extends FloatingActionButton {
  final Widget label;
  final Widget icon;
  final bool isExtraHigh;
  final Function()? onTap;
  const CustomExtendedFabButton({
    Key? key,
    this.onTap,
    required this.label,
    required this.icon,
    this.isExtraHigh = false,
  }) : super(key: key, onPressed: onTap);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.zero,
      child: SizedBox(
        height: isExtraHigh ? Get.height * 0.07 : Get.height * 0.06,
        child: FittedBox(
          fit: BoxFit.fitHeight,
          child: FloatingActionButton.extended(
            elevation: 0,
            backgroundColor: Get.theme.primaryColor,
            extendedPadding: EdgeInsets.all(Utils.lowPadding),
            icon: CircleAvatar(radius: kMinInteractiveDimension * 0.4, backgroundColor: ColorTable.getReversedTextColor, child: icon),
            label: label,
            onPressed: onTap,
          ),
        ),
      ),
    );
  }
}
