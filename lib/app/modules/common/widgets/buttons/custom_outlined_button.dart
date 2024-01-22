import 'package:flutter/material.dart';

import '../../../../../core/utils/utils.dart';
import '../../../../../core/variables/colors.dart';

class CustomOutlinedButton extends StatelessWidget {
  final Widget child;
  final Color? overlayColor;
  final BorderSide? borderSide;
  final double? borderRadius;
  final double? minimumWith;
  final double? minimumHeight;
  final EdgeInsets? padding;
  final Color? borderColor;
  final void Function()? onPressed;
  const CustomOutlinedButton({
    Key? key,
    required this.child,
    this.onPressed,
    this.overlayColor,
    this.borderSide,
    this.borderColor,
    this.borderRadius,
    this.minimumWith,
    this.minimumHeight,
    this.padding,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      onPressed: onPressed,
      style: ButtonStyle(
        overlayColor: overlayColor != null ? MaterialStateProperty.all<Color>(overlayColor!) : null,
        side: MaterialStateProperty.all<BorderSide>(
          borderSide ?? BorderSide(color: borderColor ?? ColorTable.getTextColor),
        ),
        minimumSize: MaterialStateProperty.all<Size>(
          Size(minimumWith ?? 1, minimumHeight ?? 1),
        ),
        shape: MaterialStateProperty.all<RoundedRectangleBorder>(RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(borderRadius ?? Utils.extraLowRadius)),
        )),
        padding: MaterialStateProperty.all<EdgeInsets>(padding ?? EdgeInsets.all(Utils.normalPadding)),
      ),
      child: child,
    );
  }
}
