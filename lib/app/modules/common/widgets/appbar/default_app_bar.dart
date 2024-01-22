import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../core/utils/utils.dart';

class DefaultAppBar extends StatelessWidget {
  ///App bar title
  final Widget? title;

  ///Geri butonunu gösterir veya gizler
  final bool showLeadingBackIcon;

  ///Title widgetını ortalar
  final bool centerTitle;

  final Widget? leadingIcon;

  ///App barın sağında listelenecek olan widgetlar
  final List<Widget>? actions;

  final Function()? onLeadingPressed;
  final double? leadingWidth;
  final bool isWeb;
  const DefaultAppBar(
      {Key? key,
      this.title,
      this.isWeb = false,
      this.showLeadingBackIcon = true,
      this.leadingIcon,
      this.actions,
      this.onLeadingPressed,
      this.centerTitle = false,
      this.leadingWidth})
      : super(key: key);

  const DefaultAppBar.forWeb(
      {Key? key,
      this.title,
      this.isWeb = true,
      this.showLeadingBackIcon = false,
      this.leadingIcon,
      this.actions,
      this.onLeadingPressed,
      this.centerTitle = false,
      this.leadingWidth})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.white,
      elevation: 0,
      toolbarHeight: Utils.appBarHeight,
      centerTitle: centerTitle,
      leadingWidth: showLeadingBackIcon ? leadingWidth ?? Get.width * 0.1 : 0,
      automaticallyImplyLeading: showLeadingBackIcon,
      leading: showLeadingBackIcon
          ? onLeadingPressed == null
              ? null
              : IconButton(
                  focusColor: Colors.transparent,
                  splashColor: Colors.transparent,
                  highlightColor: Colors.transparent,
                  hoverColor: Colors.transparent,
                  onPressed: onLeadingPressed ?? () {},
                  icon: Icon(
                    Icons.arrow_back_ios_new_rounded,
                    size: Utils.highIconSize,
                    color: Get.theme.primaryColor,
                  ),
                )
          : null,
      title: SizedBox(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: centerTitle ? MainAxisAlignment.center : MainAxisAlignment.start,
          children: [
            if (leadingIcon != null) leadingIcon!,
            Expanded(
              child: Padding(
                padding: leadingIcon != null ? EdgeInsets.symmetric(horizontal: Utils.normalPadding) : EdgeInsets.zero,
                child: title,
              ),
            ),
          ],
        ),
      ),
      actions: actions != null
          ? [
              Padding(
                padding: EdgeInsets.only(right: Utils.lowIconSize),
                child: Wrap(runAlignment: WrapAlignment.center, direction: Axis.horizontal, children: actions!),
              )
            ]
          : null,
    );
  }
}
