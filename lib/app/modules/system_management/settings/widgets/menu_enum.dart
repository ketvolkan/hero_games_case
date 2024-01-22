import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:get/get.dart';

import '../../../../../core/constants/app_constants.dart';
import '../../../../../core/services/languages/language_service.dart';
import '../../../../../generated/locales.g.dart';
import '../../../common/widgets/appbar/bottom_app_bar/bottom_app_bar_controller.dart';
import '../../../common/widgets/icons/icon_with_background.dart';
import '../settings_controller.dart';
import 'menu_button.dart';
import 'menu_view.dart';

enum MenuEnums {
  GeneralManagementMenuView,
  HobbyManagementMenuView,
  LanguageManagementMenuView,
  MenuNotFOUND,
}

extension GetMenuViews on MenuEnums {
  static SettingsController managementController = Get.find<SettingsController>();

  MenuView getView({
    Function(MenuEnums parentMenu)? onPressedBack,
    required Function(MenuEnums clickedMenu) menuOnPressed,
    String? appVersion,
  }) {
    BottomAppBarController bottomAppBarController = Get.find<BottomAppBarController>();
    //Menu View enum ile kontrol edilip varsa çağılır yoksa bulunamadı sayfası döndürülür
    switch (this) {
      case MenuEnums.GeneralManagementMenuView:
        return MenuView(
          appBarTitle: LocaleKeys.common_settings.tr,
          leadingIcon: const IconWithBackground.withIcon(icon: FeatherIcons.settings),
          onLeadingPressed: () => bottomAppBarController.changeTabIndex(index: 0),
          showLeadingBackIcon: true,
          menuButtons: [
            MenuButton(
              //Müşteri yönetimi
              menuName: LocaleKeys.hobby_management.tr,
              icon: FeatherIcons.activity,
              onTap: () => menuOnPressed(MenuEnums.HobbyManagementMenuView),
            ),
            MenuButton(
              //Müşteri yönetimi
              menuName: LocaleKeys.common_change_language.tr,
              icon: Icons.language,
              onTap: () => menuOnPressed(MenuEnums.LanguageManagementMenuView),
            ),
            MenuButton(
              //Çıkış
              onTap: () async => managementController.logoutUser(),
              menuName: LocaleKeys.common_log_out.tr,
              icon: Icons.logout_rounded,
              showTrailingIcon: false,
            ),
          ],
        );
      case MenuEnums.HobbyManagementMenuView:
        return MenuView(
          appBarTitle: LocaleKeys.hobby_management.tr,
          leadingIcon: const IconWithBackground.withIcon(icon: FeatherIcons.activity),
          onLeadingPressed: () =>
              onPressedBack != null ? onPressedBack(MenuEnums.GeneralManagementMenuView) : null, //Parent menüyü burada geri döndürün
          menuButtons: [
            MenuButton(
              //Hobilerim
              menuName: LocaleKeys.common_hobbies.tr,
              icon: FeatherIcons.activity,
              onTap: () => bottomAppBarController.changeTabIndex(index: 0),
            ),
          ],
        );
      case MenuEnums.LanguageManagementMenuView:
        return MenuView(
          appBarTitle: LocaleKeys.common_change_language.tr,
          leadingIcon: const IconWithBackground.withIcon(icon: Icons.language),
          onLeadingPressed: () =>
              onPressedBack != null ? onPressedBack(MenuEnums.GeneralManagementMenuView) : null, //Parent menüyü burada geri döndürün
          menuButtons: [
            for (LocaleLanguages language in LocaleLanguages.values)
              MenuButton(
                menuName: language.text,
                flagPath: AppConstants.flagPath(flagName: language.name),
                onTap: () => managementController.changeLanguage(language),
              ),
          ],
        );
      default:
        return MenuView(
            appBarTitle: LocaleKeys.common_menu_not_found.tr,
            onLeadingPressed: () => onPressedBack != null ? onPressedBack(MenuEnums.GeneralManagementMenuView) : null,
            menuButtons: const []);
    }
  }

  String get value => toString();
}
