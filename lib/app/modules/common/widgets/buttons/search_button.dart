import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../core/utils/utils.dart';
import '../../../../../libraries/searchable_dropdown/utils/custom_inkwell.dart';
import '../icons/icon_with_background.dart';

class SearchButton extends StatelessWidget {
  final VoidCallback onTap;
  const SearchButton({super.key, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return searchButton;
  }

  Widget get searchButton => CustomInkwell(
        padding: EdgeInsets.all(Utils.extraLowPadding),
        onTap: onTap,
        child: IconWithBackground.withIcon(
          icon: Icons.search,
          iconColor: Colors.white,
          backgroundColor: Get.theme.primaryColor,
        ),
      );
}
