import 'package:get/get.dart';

import '../../../../../routes/app_routes.dart';

class BottomAppBarController extends GetxController {
  final RxInt _tabIndex = 0.obs;
  int get tabIndex => _tabIndex.value;
  String? lastDashboardPage;

  void changeTabIndex({required int index, dynamic arguments}) {
    final tabbedDashboardPage = tabs[index];
    _tabIndex.value = index;
    if (tabbedDashboardPage == lastDashboardPage) return;
    Get.offNamedUntil(
      tabbedDashboardPage,
      (route) => route.settings.name == tabbedDashboardPage,
      arguments: arguments,
    );
    lastDashboardPage = tabs[index];
  }

  final tabs = [
    AppRoutes.home.path,
    AppRoutes.settings.path,
  ];
}
