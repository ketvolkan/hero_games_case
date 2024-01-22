import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../app/modules/common/controllers/app_controller.dart';
import '../../generated/locales.g.dart';
import '../constants/endpoints.dart';
import '../contracts/response_models/user_internet_info_model.dart';

Future<R?> errorHandler<R>({required Future<R?> Function() tryMethod, required Future<R?> Function() onErr}) async {
  try {
    return await tryMethod();
  } catch (exception) {
    debugPrint(exception.toString());
    return await onErr();
  }
}

class Utils {
  static double get extraLowTextSize => Get.height * 0.012;
  static double get lowTextSize => Get.height * 0.015;
  static double get normalTextSize => Get.height * 0.018;
  static double get highTextSize => Get.height * 0.022;
  static double get extraHighTextSize => Get.height * 0.025;

  static double get extraLowPadding => Get.height * 0.005;
  static double get lowPadding => Get.height * 0.01;
  static double get normalPadding => Get.height * 0.015;
  static double get highPadding => Get.height * 0.02;
  static double get extraHighPadding => Get.height * 0.025;

  //Radius
  static double get extraLowRadius => Get.height * 0.01;
  static double get lowRadius => Get.height * 0.015;
  static double get normalRadius => Get.height * 0.02;
  static double get highRadius => Get.height * 0.025;
  static double get extraHighRadius => Get.height * 0.035;

  //Icons
  static double get extraLowIconSize => Get.height * 0.015;
  static double get lowIconSize => Get.height * 0.02;
  static double get normalIconSize => Get.height * 0.025;
  static double get highIconSize => Get.height * 0.033;
  static double get extraHighIconSize => Get.height * 0.04;

  static double get appBarHeight => Get.height * 0.07;
  static double get bottomBarHeight => Get.height * 0.065;
  static RegExp regexEmoji = RegExp(r'(\u00a9|\u00ae|\ud83c[\ud000-\udfff]|\ud83d[\ud000-\udfff]|\ud83e[\ud000-\udfff])');

  static Duration get animationDuration => const Duration(milliseconds: 300);

  static String? toBackendDate({DateTime? dateTime}) {
    return dateTime == null ? null : DateFormat('yyyy-MM-dd').format(dateTime);
  }

  static String? formatDate({DateTime? dateTime}) {
    return dateTime == null ? null : DateFormat('yyyy-MM-dd H:m:s').format(dateTime);
  }

  static String dateWithHourAndMinuteFormatDate({DateTime? dateTime}) {
    return dateTime == null ? "" : DateFormat("dd.MM.yyyy (HH:mm)").format(dateTime);
  }

  static final DateFormat formatter = DateFormat('yyyy-MM-dd');
}

String? validateMail(String? value, {bool isRequired = false}) {
  RegExp regExpEmail = RegExp(r"^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$");
  if (value == null || value.isEmpty) {
    if (!isRequired) return null;
    return LocaleKeys.common_not_null_error.tr;
  } else if (!regExpEmail.hasMatch(value)) {
    return LocaleKeys.common_email_validate_err.tr;
  }
  return null;
}

extension CustomDateTimeExtensions on DateTime {
  int differanceWithTimeOfDayInMinutes(TimeOfDay timeOfDay) {
    return (hour - timeOfDay.hour) * 60 + (minute - timeOfDay.minute);
  }

  int daysBetween(DateTime to) {
    DateTime from = DateTime(year, month, day);
    to = DateTime(to.year, to.month, to.day);
    return (to.difference(from).inHours / 24).round();
  }

  bool isSameDay(DateTime other) {
    return year == other.year && month == other.month && day == other.day;
  }

  bool isSameMonth(DateTime other) {
    return year == other.year && month == other.month;
  }

  String get filterDateForBody {
    return DateFormat("dd.MM.yyyy").format(this);
  }
}

extension CustomBoolExtension on bool {
  int get toInt => this ? 1 : 0;
}

extension CustomNumExtension on num {
  num addIfNotNull(num? value) => value != null ? this + value : this;
}

extension CustomIntExtension on int {
  bool get integerToBoolZeroAndOneControl {
    return this == 1 ? true : false;
  }
}

extension CustomStringExtensions on String {
  Color toColor() {
    final hexCode = replaceAll('#', '');
    return Color(int.parse('FF$hexCode', radix: 16));
  }

  Color? toColorNullable() {
    try {
      final hexCode = replaceAll('#', '');
      return Color(int.parse('FF$hexCode', radix: 16));
    } catch (_) {
      return null;
    }
  }

  DateTime? getBackendDateToDateTime() {
    return DateTime.tryParse(this)?.add(const Duration(hours: 3, minutes: 0, microseconds: 0, milliseconds: 0));
  }

  String get getFirstLetter {
    if (isEmpty) return "";
    return this[0];
  }

  bool containsWithTurkishChars(String key) {
    return replaceTurkishChars.contains(key.replaceTurkishChars);
  }

  String get replaceTurkishChars {
    var replaced = toLowerCase();
    replaced = replaced.replaceAll('ş', 's');
    replaced = replaced.replaceAll('ı', 'i');
    replaced = replaced.replaceAll('ğ', 'g');
    replaced = replaced.replaceAll('ç', 'c');
    replaced = replaced.replaceAll('ö', 'o');
    replaced = replaced.replaceAll('ü', 'u');
    return replaced;
  }

  String checkSubstring(int start, int end) {
    if (length < end) {
      return this;
    }
    return substring(start, end);
  }

  bool get isValidEmail => RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-\=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(this);

  String lastChars(int n) {
    if (length < n) return "";
    return substring(length - n);
  }
}

Future<UserInternetInfoModel?> getUserInternetInformation() async {
  errorHandler(
    tryMethod: () async {
      final appController = Get.find<AppController>();
      final request = Dio(
        BaseOptions(
          baseUrl: Endpoints.userInternetInfo.path,
          connectTimeout: const Duration(milliseconds: 2000),
          contentType: "application/json",
        ),
      );
      final response = await request.get("");
      UserInternetInfoModel userInternetInfoModel = UserInternetInfoModel.fromJson(response.data);
      appController.userInternetInfoModel = userInternetInfoModel;
      return userInternetInfoModel;
    },
    onErr: () async {},
  );
  return null;
}
