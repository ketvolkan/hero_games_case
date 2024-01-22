import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:get/get.dart';

import '../../../core/utils/utils.dart';
import '../../../core/variables/colors.dart';
import '../../../generated/locales.g.dart';
import '../../models/hobby_models/hobby_model.dart';
import '../common/widgets/appbar/default_app_bar.dart';
import '../common/widgets/buttons/custom_extended_fab_button.dart';
import '../common/widgets/icons/icon_with_background.dart';
import '../common/widgets/other/custom_scaffold.dart';
import '../common/widgets/texts/custom_text.dart';
import 'home_controller.dart';
import 'widgets/hobby_card.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      appBar: buildAppBar(),
      floatingActionButton: buildFabButton(),
      body: hobbyListview(),
    );
  }

  Obx hobbyListview() {
    return Obx(
      () => Padding(
        padding: EdgeInsets.only(top: Utils.normalPadding),
        child: ListView.separated(
            itemBuilder: (context, index) {
              HobbyModel hobbyModel = controller.hobbies[index];
              return HobbyCard(hobbyModel: hobbyModel, deleteOnTap: controller.deleteHobbyOnTap);
            },
            separatorBuilder: (context, index) => SizedBox(height: Utils.normalPadding),
            itemCount: controller.hobbies.length),
      ),
    );
  }

  CustomExtendedFabButton buildFabButton() {
    return CustomExtendedFabButton(
      label: CustomText("Hobi Ekle", textColor: ColorTable.getReversedTextColor, bold: true),
      onTap: () => controller.fabButtonOnTap(),
      icon: Icon(
        Icons.add_circle_outline_outlined,
        size: Utils.extraHighIconSize,
        color: Get.theme.primaryColor,
      ),
    );
  }

  DefaultAppBar buildAppBar() {
    return DefaultAppBar(
      title: CustomText.high(LocaleKeys.common_hobbies.tr),
      leadingIcon: IconWithBackground.withIcon(icon: FeatherIcons.activity, iconColor: Get.theme.primaryColor),
    );
  }
}
