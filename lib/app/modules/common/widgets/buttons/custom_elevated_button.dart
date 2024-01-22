import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../core/utils/utils.dart';
import '../../../../../core/variables/colors.dart';

class CustomElevatedButton extends StatelessWidget {
  final Widget child;
  final Color? overlayColor;
  final Color? backgroundColor;
  final double? borderRadius;
  final double? minimumWith;
  final double? minimumHeight;
  final double? fontSize;
  final EdgeInsets? padding;
  final Color? borderColor;
  final bool isActive;
  final bool showShadow;
  final void Function()? onPressed;
  final MaterialTapTargetSize? tapTargetSize;
  final bool isGradient;
  final List<Color>? gradientColors;

  const CustomElevatedButton(
      {Key? key,
      required this.child,
      this.onPressed,
      this.overlayColor,
      this.borderColor,
      this.borderRadius,
      this.minimumWith,
      this.minimumHeight,
      this.padding,
      this.fontSize,
      this.backgroundColor,
      this.tapTargetSize,
      this.isActive = true,
      this.isGradient = false,
      this.showShadow = true,
      this.gradientColors})
      : assert(isGradient ? gradientColors != null : gradientColors == null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        gradient: isGradient ? LinearGradient(begin: Alignment.topRight, end: Alignment.bottomLeft, colors: gradientColors!) : null,
        borderRadius: BorderRadius.all(Radius.circular(borderRadius ?? Utils.extraLowRadius)),
      ),
      child: ElevatedButton(
        onPressed: isActive ? onPressed : null,
        style: ElevatedButton.styleFrom(
          padding: padding ?? EdgeInsets.all(Utils.normalPadding),
          elevation: showShadow ? null : 50,
          shadowColor: isGradient ? Colors.transparent : null,
          backgroundColor: isGradient
              ? Colors.transparent
              : backgroundColor != null
                  ? backgroundColor!
                  : isActive
                      ? Get.theme.primaryColor
                      : Colors.transparent,
          minimumSize: Size(minimumWith ?? 1, minimumHeight ?? 1),
          side: !isActive ? BorderSide(color: ColorTable.getTextColor) : null,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(borderRadius ?? Utils.extraLowRadius)),
          ),
          tapTargetSize: tapTargetSize,
        ),
        child: child,
      ),
    );
  }
}
/* 
   overlayColor: overlayColor != null
              ? MaterialStateProperty.all<Color>(HSLColor.fromColor(overlayColor!).withLightness(0.25).toColor())
              : MaterialStateProperty.all<Color>(HSLColor.fromColor(ColorTable.successColorLight).withLightness(0.25).toColor()),
*/