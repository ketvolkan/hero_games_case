import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ColorTable {
  static Color cardBackgroundColor = Colors.white;
  static Color darkModeBg = const Color(0xff292929);
  static Color lightModeBg = const Color.fromARGB(255, 246, 246, 246);
  static Color splashBg = const Color(0xff010303);
  static Color errorColor = Colors.red[400]!;
  static Color buttonColor = const Color.fromARGB(255, 246, 246, 246);
  static Color errorColorLight = const Color.fromRGBO(254, 221, 229, 1);
  static Color successColorLight = const Color.fromRGBO(213, 251, 224, 1);
  static Color successColor = const Color.fromARGB(255, 22, 148, 58);
  static Color processColorLight = const Color.fromARGB(255, 240, 213, 251);
  static Color processColor = const Color.fromARGB(255, 131, 22, 148);
  static Color stoppedColorLight = const Color.fromARGB(255, 213, 222, 251);
  static Color stoppedColor = const Color.fromARGB(255, 22, 30, 148);
  static Color waitingColorLight = const Color.fromARGB(255, 255, 174, 93);
  static Color toggleableBackgroundColor = const Color.fromRGBO(230, 230, 230, 1);
  static Color waitingColor = const Color.fromARGB(255, 255, 145, 0);
  static Color get getTextColor => Get.isDarkMode ? Colors.white : const Color.fromARGB(255, 107, 107, 107);
  static Color get getReversedTextColor => Get.isDarkMode ? Colors.black : Colors.white;
  static Color get disabledButtonColor => Colors.grey;
  static Color get directoryButtonColor => const Color.fromARGB(255, 139, 156, 255);
  static Color get getBlackTextColor => Colors.black;
  static Color primaryColor = const Color.fromARGB(255, 255, 53, 127);
  static Color primaryColorDark = const Color.fromARGB(255, 205, 16, 51);
  static Color primaryColorLight = const Color.fromARGB(31, 255, 145, 169);
  static Color fabButtonColor = const Color.fromARGB(255, 221, 151, 165);
}
