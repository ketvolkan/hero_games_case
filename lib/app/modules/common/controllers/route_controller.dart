import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:get/get.dart';

import '../../../../core/utils/utils.dart';
import '../../../routes/app_routes.dart';
import '../widgets/appbar/bottom_app_bar/bottom_app_bar.dart';

class RouteController extends GetxController {
  final Rx<bool> _showDashboard = false.obs;
  bool get showDashboard => _showDashboard.value;
  set showDashboard(bool val) => _showDashboard.value = val;

  final Rx<bool> _isBottomSheetOpened = false.obs;
  bool get isBottomSheetOpened => _isBottomSheetOpened.value;
  set isBottomSheetOpened(bool val) => _isBottomSheetOpened.value = val;

  final Rx<bool> _isDialogOpened = false.obs;
  bool get isDialogOpened => _isDialogOpened.value;
  set isDialogOpened(bool val) => _isDialogOpened.value = val;

  List<String> withoutDashboardPages = [
    AppRoutes.splash.path,
    AppRoutes.login.path,
    AppRoutes.register.path,
  ];

  Widget materialRouteBuilder(BuildContext context, Widget? child) {
    return Overlay(
      initialEntries: [
        OverlayEntry(
          builder: (context) {
            return Scaffold(
              extendBodyBehindAppBar: true,
              extendBody: true,
              body: KeyboardVisibilityBuilder(builder: (context, isKeyboardOpen) {
                return Obx(
                  () => Padding(
                    padding: EdgeInsets.only(
                        bottom: showDashboard && !isKeyboardOpen && !isBottomSheetOpened
                            ? Platform.isIOS
                                ? Utils.bottomBarHeight * 1.65
                                : Utils.bottomBarHeight
                            : isBottomSheetOpened
                                ? Utils.bottomBarHeight
                                : 0),
                    child: child ?? const SizedBox(),
                  ),
                );
              }),
              bottomNavigationBar: Obx(() => (showDashboard) ? CustomBottomAppBar(isDialogOpened: isDialogOpened) : const SizedBox.shrink()),
            );
          },
        )
      ],
    );
  }

  void materialRouteCallBack(Routing? routing) {
    if (routing?.current == AppRoutes.splash.path) return;
    checkHasDashboard(routing?.current ?? "/");
  }

  void checkHasDashboard(String page) => showDashboard = !(withoutDashboardPages.contains(page));
}
