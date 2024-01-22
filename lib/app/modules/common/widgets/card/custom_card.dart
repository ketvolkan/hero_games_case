import 'package:flutter/material.dart';

import '../../../../../core/utils/utils.dart';
import '../buttons/custom_inkwell.dart';

class CustomCard extends StatelessWidget {
  final Function()? onTap;
  final Widget? child;
  final ShapeBorder? shape;
  final EdgeInsets? padding;
  final double? elevation;
  final Color? backgroundColor;
  const CustomCard({super.key, this.onTap, this.child, this.shape, this.padding, this.elevation, this.backgroundColor});

  @override
  Widget build(BuildContext context) {
    return CustomInkwell(
      padding: EdgeInsets.zero,
      disableTabEfect: true,
      onTap: onTap,
      child: Card(
        color: backgroundColor,
        shape: shape ?? RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(Utils.lowRadius))),
        margin: EdgeInsets.zero,
        elevation: elevation,
        child: Padding(
          padding: padding ?? EdgeInsets.all(Utils.normalPadding),
          child: child,
        ),
      ),
    );
  }
}
