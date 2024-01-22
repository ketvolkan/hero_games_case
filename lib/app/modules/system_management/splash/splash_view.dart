import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../core/constants/app_constants.dart';
import '../../../../core/utils/utils.dart';
import '../../common/widgets/other/custom_scaffold.dart';
import '../../common/widgets/texts/custom_text.dart';
import 'splash_controller.dart';

class SplashView extends GetView<SplashController> {
  const SplashView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Stack(children: [logoSide(), circularProgressSplash()]),
            SizedBox(height: Utils.normalPadding),
            CustomText(controller.loading),
          ],
        ),
      ),
    );
  }

  Image logoSide() => Image(
        image: const AssetImage(AppConstants.logoPath),
        color: Get.theme.primaryColor,
        height: Get.height * 0.2,
      );

  SizedBox circularProgressSplash() {
    return SizedBox.square(
      dimension: Get.height * 0.2,
      child: CircularProgressIndicator(
        strokeWidth: 3,
        color: Get.theme.primaryColor,
        backgroundColor: Get.theme.primaryColor.withOpacity(0.15),
      ),
    );
  }
}
