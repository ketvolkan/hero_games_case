import 'package:flutter/material.dart';

import '../../../../../core/utils/utils.dart';

class MenuView extends StatelessWidget {
  final String appBarTitle;
  final Widget? leadingIcon;
  final bool showLeadingBackIcon;
  final Function()? onLeadingPressed;
  final List<Widget> menuButtons;
  final String? appVersion;
  final VoidCallback? onPressed;
  const MenuView({
    Key? key,
    required this.appBarTitle,
    required this.menuButtons,
    this.showLeadingBackIcon = true,
    this.leadingIcon,
    this.onLeadingPressed,
    this.appVersion,
    this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListView.separated(
          padding: EdgeInsets.symmetric(vertical: Utils.highPadding, horizontal: Utils.normalPadding),
          shrinkWrap: true,
          itemCount: menuButtons.length,
          separatorBuilder: (c, i) => SizedBox(height: Utils.highPadding),
          itemBuilder: (context, index) {
            return menuButtons[index];
          },
        ),
      ],
    );
  }
}
