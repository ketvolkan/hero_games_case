import 'package:flutter/material.dart';

import '../../../../../core/utils/utils.dart';
import '../buttons/custom_inkwell.dart';
import 'custom_text.dart';

class TextCard extends StatelessWidget {
  final String? label;
  final double? labelTextSize;
  final Widget? labelTrailing;
  final Widget? text;
  final Widget? child;
  final Function()? onTap;

  const TextCard({
    Key? key,
    this.label,
    this.labelTextSize,
    this.text,
    this.child,
    this.onTap,
    this.labelTrailing,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: Utils.normalPadding),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              if (label != null) CustomText.custom(label!, textSize: labelTextSize ?? Utils.highTextSize),
              if (labelTrailing != null) labelTrailing!,
            ],
          ),
        ),
        SizedBox(
          width: double.infinity,
          child: CustomInkwell(
            onTap: onTap,
            disableTabEfect: true,
            padding: EdgeInsets.zero,
            child: child ??
                Card(
                  margin: EdgeInsets.zero,
                  elevation: 3,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(Utils.lowRadius))),
                  child: Padding(
                    padding: EdgeInsets.all(Utils.normalPadding),
                    child: text,
                  ),
                ),
          ),
        ),
      ],
    );
  }
}
