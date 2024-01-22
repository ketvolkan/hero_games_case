import 'package:async/async.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

import '../../../../../core/utils/getx_extensions.dart';
import '../../../../../core/utils/utils.dart';
import '../../../../../core/variables/colors.dart';
import '../../../../../generated/locales.g.dart';
import '../texts/custom_text.dart';

class CustomTextFormField extends StatelessWidget {
  final String? label;
  final String? hintText;
  final String? suffixText;
  final String? prefixText;
  final String? initialValue;
  final Widget? description;
  final bool isRequired;
  final bool isRequiredText;
  final int? maxlines;
  final FocusNode? focusNode;
  final String? initialSelectedCountry;

  ///Fieldin altında 0/3 gibi maxLength yazısı gösterir
  final bool showmaxLength;
  final bool obscureText;
  final bool readOnly;
  final bool autoCorrect;
  // ReadOnly aktifse ve mesajın kopyalanmasını istemiyorsan false yapabilirsin
  final bool showCopyMessage;

  ///Fieldin alabileceği maximum karakter sayısı
  final int? maxLength;
  final TextInputType? keyboardType;
  final List<TextInputFormatter>? inputFormatters;
  final String? Function(String?)? validator;
  final Function(String?)? onSaved;
  final Function(String?)? onChangeComplete;
  final TextEditingController? controller;
  final ScrollPhysics? scrollPhysics;
  final IconData? leadingIcon;

  ///Klavyeden değer girme işlemi bittikten kaç milisaniye sonra on change complete fonksiyonunun tetikleneceğini belirler
  final Duration changeCompletionDelay;
  final EdgeInsets? labelPadding;
  final double? elevation;
  final EdgeInsets? padding;
  final double? labelTextSize;
  final double? hintTextSize;
  final AutovalidateMode? autovalidateMode;
  final Function()? onTap;

  final Widget? suffix;
  final bool isDense;
  final Color? labelColor;

  const CustomTextFormField(
      {Key? key,
      this.label,
      this.labelColor,
      this.elevation,
      this.initialSelectedCountry,
      this.showCopyMessage = true,
      this.hintText,
      this.validator,
      this.onSaved,
      this.isRequired = false,
      this.initialValue,
      this.suffixText,
      this.keyboardType,
      this.inputFormatters,
      this.maxLength,
      this.scrollPhysics,
      this.onChangeComplete,
      this.showmaxLength = false,
      this.description,
      this.obscureText = false,
      this.controller,
      //changeCompletionDelay Normalde 600'dü editleme sayfasında değişiklik uyarısı için 100 milisaniyeye düşürdüm
      this.changeCompletionDelay = const Duration(milliseconds: 100),
      this.maxlines,
      this.readOnly = false,
      this.labelPadding,
      this.padding,
      this.focusNode,
      this.labelTextSize,
      this.prefixText,
      this.autoCorrect = true,
      this.onTap,
      this.isRequiredText = true,
      this.autovalidateMode,
      this.leadingIcon,
      this.hintTextSize,
      this.isDense = true,
      this.suffix})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    CancelableOperation? cancelableOpertaion;

    void startCancelableOperation() {
      cancelableOpertaion = CancelableOperation.fromFuture(
        Future.delayed(changeCompletionDelay),
        onCancel: () {},
      );
    }

    void copyTextOnTap() {
      if (!readOnly) return;
      if (!showCopyMessage) return;

      Clipboard.setData(ClipboardData(text: controller != null ? controller?.text ?? "" : (initialValue ?? '')));
      Get.showToast("Kopyalandı", toastStyle: ToastStyle.NORMAL, toastGravity: ToastGravity.BOTTOM);
    }

    return InkWell(
      onTap: (readOnly) ? copyTextOnTap : null,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (label != null)
            Padding(
              padding: labelPadding ?? EdgeInsets.only(left: Utils.lowPadding),
              child: CustomText.custom(
                "$label ${isRequired && isRequiredText ? '*' : ''}",
                textColor: labelColor ?? ColorTable.getTextColor,
                textSize: labelTextSize ?? Utils.normalTextSize,
                bold: true,
              ),
            ),
          if (label != null) SizedBox(height: Utils.extraLowPadding),
          SizedBox(
            width: double.infinity,
            child: Card(
              margin: EdgeInsets.zero,
              elevation: elevation ?? 5,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(Utils.extraLowRadius))),
              child: Row(
                children: [
                  Expanded(
                    child: Padding(
                      padding: padding ?? EdgeInsets.all(Utils.normalPadding),
                      child: TextFormField(
                        readOnly: readOnly,
                        focusNode: focusNode,
                        onTap: (readOnly || onTap != null)
                            ? () {
                                copyTextOnTap();
                                if (onTap != null) onTap!();
                              }
                            : null,
                        controller: controller,
                        onChanged: (value) async {
                          await cancelableOpertaion?.cancel();
                          startCancelableOperation();
                          cancelableOpertaion?.value.whenComplete(() async {
                            if (onChangeComplete != null) onChangeComplete!(value);
                          });
                        },
                        maxLines: maxlines ?? 1,
                        maxLength: maxLength,
                        initialValue: initialValue,
                        scrollPhysics: scrollPhysics,
                        keyboardType: keyboardType,
                        inputFormatters: inputFormatters,
                        obscureText: obscureText,
                        autocorrect: autoCorrect,
                        autovalidateMode: autovalidateMode,
                        validator: isRequired
                            ? (value) {
                                if (value == null || value.isEmpty) return LocaleKeys.common_not_null_error.tr;
                                return validator != null ? validator!(value) : null;
                              }
                            : validator,
                        onSaved: onSaved,
                        style: TextStyle(color: ColorTable.getTextColor),
                        decoration: InputDecoration(
                            contentPadding: !isDense ? EdgeInsets.all(Utils.lowPadding) : EdgeInsets.zero,
                            isDense: isDense,
                            border: InputBorder.none,
                            icon: leadingIcon != null ? Icon(leadingIcon, size: Utils.normalIconSize) : null,
                            hintText: (hintText ?? "") + (isRequired && isRequiredText ? '*' : ''),
                            hintStyle: TextStyle(color: ColorTable.getTextColor.withOpacity(0.6), fontSize: hintTextSize ?? Utils.normalTextSize),
                            suffixText: suffixText,
                            suffixIcon: suffix,
                            suffixIconConstraints: BoxConstraints(minHeight: Utils.lowIconSize, minWidth: Utils.lowIconSize),
                            prefixText: prefixText,
                            counterText: showmaxLength ? null : ''),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          if (description != null) Padding(padding: EdgeInsets.only(top: Utils.extraLowPadding), child: description),
        ],
      ),
    );
  }
}
