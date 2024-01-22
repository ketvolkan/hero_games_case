import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:get/get.dart';

import '../../../../../../core/utils/utils.dart';
import '../../../../../../core/variables/colors.dart';
import 'bottom_app_bar_controller.dart';

class CustomBottomAppBar extends GetView<BottomAppBarController> {
  final bool isDialogOpened;
  const CustomBottomAppBar({super.key, required this.isDialogOpened});

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      child: Obx(
        () => Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            _bottomBarIconButton(iconData: FeatherIcons.activity, index: 0),
            _bottomBarIconButton(iconData: FeatherIcons.settings, index: 1),
          ],
        ),
      ),
    );
  }

  SizedBox _bottomBarIconButton({required IconData iconData, required int index}) {
    return SizedBox(
      height: Utils.bottomBarHeight,
      width: Utils.bottomBarHeight,
      child: IconButton(
        iconSize: Utils.normalIconSize * 1.25,
        icon: Icon(iconData),
        color: controller.tabIndex == index ? Get.theme.primaryColor : ColorTable.getTextColor,
        onPressed: () {
          if (isDialogOpened) return;
          if (Get.isOverlaysOpen) return;
          controller.changeTabIndex(index: index);
        },
      ),
    );
  }
}
