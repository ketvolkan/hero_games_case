import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../../../../../core/utils/utils.dart';

class IconWithBackground extends StatelessWidget {
  ///child verilirse icon ve image path girdisi ezilir
  final Widget? child;

  ///Svg image Asset path'i, image path verilirse icon girdisi ezilir
  final String? iconPath;

  ///Icons.arrow şeklinde icon data alır gösterir
  final IconData? icon;

  final Color? backgroundColor;
  final Color? iconColor;
  final bool isDense;
  final double? borderRadius;

  final bool showBorder;

  ///Asset ile kullanmak istiyorsanız. Ancak svg olmak zorunda.
  const IconWithBackground.withAsset(
      {Key? key,
      this.child,
      this.iconPath,
      this.icon,
      this.backgroundColor,
      this.iconColor,
      this.isDense = true,
      this.showBorder = false,
      this.borderRadius})
      : super(key: key);

  ///iconData ile kullanmak istiyorsanız.
  const IconWithBackground.withIcon(
      {Key? key,
      this.child,
      this.iconPath,
      required this.icon,
      this.backgroundColor,
      this.iconColor,
      this.isDense = true,
      this.showBorder = false,
      this.borderRadius})
      : super(key: key);

  ///kendi child widgetınız ile kullanmak istiyorsanız.
  const IconWithBackground.withChild(
      {Key? key,
      required this.child,
      this.iconPath,
      this.icon,
      this.backgroundColor,
      this.iconColor,
      this.isDense = true,
      this.showBorder = false,
      this.borderRadius})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: isDense ? Utils.extraHighIconSize : null,
      height: isDense ? Utils.extraHighIconSize : null,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(borderRadius ?? Utils.extraLowRadius),
        color: backgroundColor ?? Get.theme.primaryColorLight,
        border: showBorder ? Border.all() : null,
      ),
      padding: EdgeInsets.all(Utils.extraLowPadding),
      child: Stack(
        children: [
          Align(
            alignment: Alignment.center,
            child: child ??
                (iconPath != null
                    ? SvgPicture.asset(
                        iconPath!,
                        color: iconColor ?? Get.theme.primaryColor,
                        height: Utils.normalIconSize,
                        width: Utils.normalIconSize,
                      )
                    : Icon(
                        icon,
                        color: iconColor ?? Get.theme.primaryColor,
                        size: Utils.normalIconSize,
                      )),
          ),
        ],
      ),
    );
  }
}
