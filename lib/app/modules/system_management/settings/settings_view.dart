import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../common/widgets/appbar/default_app_bar.dart';
// import '../../common/controllers/app_controller.dart';
import '../../common/widgets/other/custom_scaffold.dart';
import '../../common/widgets/texts/custom_text.dart';
import 'settings_controller.dart';

class SettingsView extends GetView<SettingsController> {
  const SettingsView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      appBar: Obx(
        () => DefaultAppBar(
          title: CustomText.extraHigh(controller.currentMenu?.appBarTitle.tr, textColor: Get.theme.primaryColor),
          showLeadingBackIcon: controller.currentMenu?.showLeadingBackIcon ?? true,
          leadingIcon: controller.currentMenu?.leadingIcon,
          onLeadingPressed: controller.currentMenu?.onLeadingPressed,
        ),
      ),
      bodyPadding: EdgeInsets.zero,
      useSingleChildScrollView: false,
      body: Obx(() => controller.currentMenu ?? const Center(child: CircularProgressIndicator())),
    );
  }
}
