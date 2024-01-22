import 'package:flutter/material.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:get/get.dart';

import '../../../../../../core/utils/utils.dart';
import '../../../../../core/variables/colors.dart';
import '../../../../../libraries/searchable_dropdown/utils/custom_inkwell.dart';

class BottomSheetBase extends StatelessWidget {
  final double? height;
  final double? width;
  final Widget child;
  const BottomSheetBase({Key? key, this.height, required this.child, this.width}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return KeyboardDismissOnTap(
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: Utils.highPadding),
        padding: EdgeInsets.all(Utils.extraLowPadding),
        height: height,
        width: width,
        decoration: bottomSheetMainContainerDecoration,
        child: Column(
          children: [
            cancelIcon,
            SizedBox(height: Utils.normalPadding),
            Expanded(child: SingleChildScrollView(child: child)),
          ],
        ),
      ),
    );
  }

  Row get cancelIcon => Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          CustomInkwell(
            padding: EdgeInsets.zero,
            child: Icon(Icons.cancel_outlined, size: Utils.highIconSize),
            onTap: () => Get.back(),
          )
        ],
      );

  BoxDecoration get bottomSheetMainContainerDecoration => BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(Utils.normalRadius),
        topRight: Radius.circular(Utils.normalRadius),
      ),
      border: Border.all(color: ColorTable.getTextColor.withOpacity(0.5)));
}
