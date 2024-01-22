import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

import '../../../../../core/utils/utils.dart';
import '../../../../../core/variables/colors.dart';
import '../texts/custom_text.dart';
import 'custom_inkwell.dart';

class CardButton extends StatelessWidget {
  final Color? backgroundColor;
  final Color? textColor;
  final Widget? icon;
  final double? width;
  final double? height;
  final double? borderRadius;
  final double? elevation;
  final String title;
  final bool autoSizedText;
  final double? textSize;
  final int? textMaxLine;
  final Function()? onPressed;
  final EdgeInsetsGeometry? padding;
  final double? paddingWithIcon;
  final Axis direction;

  const CardButton(
      {Key? key,
      this.backgroundColor,
      this.onPressed,
      this.icon,
      required this.title,
      this.width,
      this.height,
      this.elevation,
      this.textSize,
      this.textColor,
      this.autoSizedText = false,
      this.padding,
      this.direction = Axis.vertical,
      this.borderRadius,
      this.paddingWithIcon,
      this.textMaxLine})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomInkwell(
      disableTabEfect: true,
      padding: EdgeInsets.zero,
      onTap: onPressed,
      child: Card(
        color: Colors.white,
        elevation: elevation,
        margin: EdgeInsets.zero,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(borderRadius ?? Utils.lowRadius)),
        child: Container(
          width: width,
          height: height,
          decoration: BoxDecoration(
            color: backgroundColor,
            borderRadius: BorderRadius.circular(borderRadius ?? Utils.lowRadius),
          ),
          child: Padding(
            padding: padding ??
                (icon != null
                    ? EdgeInsets.only(
                        left: Utils.extraLowPadding,
                        right: Utils.extraLowPadding,
                        top: Utils.normalPadding,
                        bottom: Utils.extraLowPadding,
                      )
                    : EdgeInsets.all(Utils.lowPadding)),
            child: direction == Axis.vertical
                ? Column(mainAxisAlignment: MainAxisAlignment.center, children: buttonCountents)
                : Row(children: buttonCountents),
          ),
        ),
      ),
    );
  }

  List<Widget> get buttonCountents => [
        if (icon != null)
          Center(
            child: Padding(
              padding: EdgeInsets.only(
                bottom: direction == Axis.vertical ? paddingWithIcon ?? Utils.extraLowPadding : 0,
                right: direction == Axis.horizontal ? Utils.extraLowPadding : 0,
              ),
              child: icon!,
            ),
          ),
        if (autoSizedText)
          Flexible(
            child: titleText(),
          ),
        if (!autoSizedText) CustomText.custom(title, textSize: textSize, textColor: textColor, centerText: true, maxlines: textMaxLine)
      ];

  AutoSizeText titleText() {
    return AutoSizeText(
      title,
      maxLines: 3,
      textAlign: TextAlign.center,
      minFontSize: Utils.extraLowTextSize.roundToDouble(),
      style: TextStyle(color: textColor ?? ColorTable.getTextColor, fontSize: textSize ?? Utils.normalTextSize),
      overflow: TextOverflow.fade,
    );
  }
}
