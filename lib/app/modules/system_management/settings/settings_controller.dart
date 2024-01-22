import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hero_games_case/generated/locales.g.dart';

import '../../../../core/services/languages/language_service.dart';
import '../../../../core/utils/getx_extensions.dart';
import '../../common/controllers/user_controller.dart';
import '../../common/widgets/appbar/bottom_app_bar/bottom_app_bar_controller.dart';
import 'widgets/menu_enum.dart';
import 'widgets/menu_view.dart';

enum SettingsState { Initial, Busy, Error, Loaded }

class SettingsController extends GetxController {
  final Rx<SettingsState> _state = SettingsState.Initial.obs;
  SettingsState get state => _state.value;
  set state(SettingsState val) => _state.value = val;

  final Rxn<MenuView> _currentMenu = Rxn<MenuView>();
  MenuView? get currentMenu => _currentMenu.value;
  set currentMenu(val) => _currentMenu.value = val;

  @override
  void onInit() {
    ever(_state, (SettingsState value) {
      switch (value) {
        case SettingsState.Busy:
          Get.showProgressDialog();
          break;
        case SettingsState.Loaded:
          if (!Get.isOverlaysClosed) Get.back();
          break;
        case SettingsState.Error:
          if (!Get.isOverlaysClosed) Get.back();
          break;
        default:
      }
    });
    super.onInit();
    switchMenu(MenuEnums.GeneralManagementMenuView);
  }

  Future<void> switchMenu(MenuEnums menu) async {
    switch (menu) {
      case MenuEnums.GeneralManagementMenuView:
        currentMenu = MenuEnums.GeneralManagementMenuView.getView(
          menuOnPressed: (clickedMenu) async {
            //Tıklanan menü enum ile kontrol edilip varsa fonksiyonu çağırılır yok menu view'i çağırılır
            switchMenu(clickedMenu);
          },
        );
        break;
      case MenuEnums.HobbyManagementMenuView:
        currentMenu = MenuEnums.HobbyManagementMenuView.getView(
            onPressedBack: (parentMenu) => switchMenu(parentMenu),
            menuOnPressed: (clickedMenu) {
              switch (clickedMenu) {
                default:
                  switchMenu(clickedMenu);
              }
            });
        break;
      case MenuEnums.LanguageManagementMenuView:
        currentMenu = MenuEnums.LanguageManagementMenuView.getView(
            onPressedBack: (parentMenu) => switchMenu(parentMenu),
            menuOnPressed: (clickedMenu) {
              switch (clickedMenu) {
                default:
                  switchMenu(clickedMenu);
              }
            });
        break;
      default:
        debugPrint('Böyle bir menü bulunamadı');
    }
  }

  Future<void> logoutUser() async {
    Get.showAwesomeDialog(
      title: LocaleKeys.common_warning.tr,
      dialogType: DialogType.WARNING,
      subtitle: LocaleKeys.common_logout_subtitle.tr,
      btnOkOnPressed: () async => Get.find<UserController>().logOut,
    );
  }

  Future<void> changeLanguage(LocaleLanguages language) async {
    Get.showAwesomeDialog(
      title: LocaleKeys.common_warning.tr,
      subtitle: LocaleKeys.common_language_subtitle.tr,
      dialogType: DialogType.WARNING,
      btnOkOnPressed: () async {
        await Get.find<LanguageService>().setLocale(locales[language]!);
        Get.back();
        Get.find<BottomAppBarController>().changeTabIndex(index: 0);
      },
      btnCancelOnPressed: () => Get.back(),
    );
  }
}
