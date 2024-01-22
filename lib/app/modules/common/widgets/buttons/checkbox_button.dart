import 'package:flutter/material.dart';

import '../../../../../core/utils/utils.dart';
import '../other/custom_checkbox.dart';
import '../texts/custom_text.dart';
import 'custom_inkwell.dart';

class CheckboxButton extends StatelessWidget {
  final VoidCallback onTap;
  final bool value;
  final String text;
  const CheckboxButton({Key? key, required this.onTap, required this.value, required this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomInkwell(
      onTap: onTap,
      padding: EdgeInsets.all(Utils.extraLowPadding),
      child: Row(
        children: [
          CustomCheckBox(
            value: value,
            onChanged: (value) => onTap(),
          ),
          SizedBox(width: Utils.extraLowPadding),
          CustomText(text),
        ],
      ),
    );
  }
}
