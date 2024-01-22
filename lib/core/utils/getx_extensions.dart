// ignore_for_file: depend_on_referenced_packages, constant_identifier_names

import 'dart:async';

import 'package:async/async.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:hero_games_case/app/modules/common/controllers/route_controller.dart';
import 'package:hero_games_case/generated/locales.g.dart';

import '../../app/modules/common/widgets/buttons/custom_inkwell.dart';
import '../../app/modules/common/widgets/dialog/awesome_dialog/custom_awesome_dialog.dart';
import '../../app/modules/common/widgets/texts/custom_text.dart';
import '../constants/app_constants.dart';
import '../variables/colors.dart';
import 'utils.dart';

extension CustomGetDialogExtension on GetInterface {
  Future showErrorDialog(String subtitle, {String? title}) async {
    await Get.showAwesomeDialog(
      title: title ?? LocaleKeys.common_warning.tr,
      subtitle: subtitle,
      dialogType: DialogType.ERROR,
      headerIconColor: ColorTable.errorColor,
      disableBtnOk: true,
      btnCancelText: LocaleKeys.common_ok.tr,
      btnCancelOnPressed: () {
        Get.back();
        if (Get.isDialogOpen ?? false) Get.back();
      },
    );
  }

  ///Awesome dialog gösterir
  ///Counter ile okey butonunda geri sayım yaptırılabilir
  Future showAwesomeDialog({
    String? title,
    String? subtitle,
    Widget? body,
    String? btnCancelText,
    String? btnOkText,
    Color? headerIconColor,
    bool disableBtnOk = false,
    bool disableBtnCancel = false,
    Function()? btnOkOnPressed,
    Function()? btnCancelOnPressed,
    int counter = 0,
    bool dismissOnTouchOutside = true,
    Widget? customHeader,
    bool isDisableHeader = false,
    DialogType dialogType = DialogType.INFO,
    bool dismissOnBackKeyPress = false,
    bool showCloseIcon = false,
    Function(DismissType type)? onDissmisCallBack,
  }) async {
    final context = Get.context;
    if (context != null) {
      CancelableOperation? cancellableOperation;
      Widget buildButton({
        required String text,
        required Color textColor,
        required Color backgroundColor,
        required Function()? onPressed,
      }) =>
          CustomInkwell(
            onTap: onPressed,
            padding: EdgeInsets.zero,
            child: Container(
              decoration: BoxDecoration(
                color: backgroundColor,
                borderRadius: BorderRadius.circular(Utils.normalRadius),
              ),
              alignment: Alignment.center,
              padding: EdgeInsets.all(Utils.lowPadding),
              child: CustomText(text, textColor: textColor),
            ),
          );
      RouteController routeController = Get.find<RouteController>();
      routeController.isDialogOpened = true;
      CustomAwesomeDialog(
              dialogBackgroundColor: Get.theme.scaffoldBackgroundColor,
              context: Get.context!,
              showCloseIcon: showCloseIcon,
              onDissmissCallback: (type) {
                routeController.isDialogOpened = false;
                if (onDissmisCallBack != null) onDissmisCallBack(type);
              },
              dismissOnTouchOutside: dismissOnTouchOutside,
              animType: AnimType.BOTTOMSLIDE,
              dialogType: isDisableHeader ? DialogType.NO_HEADER : dialogType,
              title: title,
              customHeader: isDisableHeader ? null : customHeader,
              desc: subtitle,
              body: body,
              btnCancel: disableBtnCancel
                  ? null
                  : buildButton(
                      text: btnCancelText ?? LocaleKeys.common_cancel.tr,
                      textColor: ColorTable.errorColor,
                      backgroundColor: ColorTable.errorColorLight,
                      onPressed: btnCancelOnPressed ?? () => Get.back()),
              btnOk: disableBtnOk
                  ? null
                  : StatefulBuilder(
                      builder: (context, setState) {
                        if (counter > 0) {
                          cancellableOperation = CancelableOperation.fromFuture(
                            Future.delayed(const Duration(seconds: 1)),
                            onCancel: () => {},
                          );
                          cancellableOperation?.value.whenComplete(() => setState(() => counter--));
                          return buildButton(
                            text: '${LocaleKeys.common_wait.tr}($counter)',
                            textColor: ColorTable.getTextColor,
                            backgroundColor: Colors.grey.withOpacity(0.5),
                            onPressed: null,
                          );
                        }
                        return buildButton(
                          text: btnOkText ?? LocaleKeys.common_ok.tr,
                          textColor: Colors.green,
                          backgroundColor: Colors.greenAccent.withOpacity(0.5),
                          onPressed: () {
                            if (btnOkOnPressed != null) btnOkOnPressed();
                          },
                        );
                      },
                    ))
          .show()
          .whenComplete(() => cancellableOperation?.cancel());
    }
  }

  Future showProgressDialog() async {
    await Get.dialog(
      Stack(
        alignment: Alignment.center,
        children: [
          Image(
            image: const AssetImage(AppConstants.logoPath),
            color: ColorTable.getReversedTextColor,
            width: Get.height * 0.07,
            height: Get.height * 0.07,
          ),
          SizedBox.square(
            dimension: Get.height * 0.125,
            child: CircularProgressIndicator(
              strokeWidth: 4,
              color: Get.theme.primaryColor.withOpacity(0.75),
              backgroundColor: ColorTable.getReversedTextColor.withOpacity(0.15),
            ),
          )
        ],
      ),
      barrierDismissible: false,
    );
  }
}

enum ToastStyle { SUCCESS, ERROR, NORMAL, WARNING }

extension CustomToastExtension on GetInterface {
  Future<bool?> showToast(String text, {ToastStyle? toastStyle = ToastStyle.NORMAL, ToastGravity? toastGravity}) {
    late Color backgroundColor;
    late Color textColor;
    switch (toastStyle) {
      case ToastStyle.SUCCESS:
        backgroundColor = Colors.green;
        textColor = Colors.white;
        break;
      case ToastStyle.ERROR:
        backgroundColor = Colors.red;
        textColor = Colors.white;
        break;
      case ToastStyle.WARNING:
        backgroundColor = Colors.orange;
        textColor = Colors.white;
        break;
      default:
        backgroundColor = const Color(0xFFD1CDCD);
        textColor = ColorTable.getTextColor;
    }
    return Future.microtask(
      () => Fluttertoast.showToast(
        msg: text,
        backgroundColor: backgroundColor,
        textColor: textColor,
        fontSize: Utils.highTextSize,
        gravity: toastGravity ?? ToastGravity.CENTER,
      ),
    );
  }
}
