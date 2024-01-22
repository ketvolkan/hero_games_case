import 'package:flutter/material.dart';

import '../../../../../core/utils/utils.dart';
import 'custom_inkwell.dart';

class CustomIconButton extends StatelessWidget {
  final EdgeInsets? padding;
  final double? iconSize;
  final IconData icon;
  final Color? iconColor;
  const CustomIconButton({Key? key, this.padding, this.iconSize, required this.icon, this.iconColor}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomInkwell(
      padding: padding ?? EdgeInsets.all(Utils.lowPadding),
      onTap: () {},
      child: Icon(
        icon,
        size: Utils.highIconSize,
        color: iconColor,
      ),
    );
  }
}
