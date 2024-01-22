import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../core/variables/colors.dart';

class AppThemes {
  static ThemeData light = ThemeData(
    primaryColorDark: ColorTable.primaryColorDark,
    primaryColor: ColorTable.primaryColor,
    useMaterial3: false,
    primaryColorLight: ColorTable.primaryColorLight,
    colorScheme: ColorScheme.fromSwatch().copyWith(
      brightness: Brightness.light,
      primary: ColorTable.primaryColor,
      secondary: const Color.fromARGB(30, 53, 56, 151),
    ),
    floatingActionButtonTheme: FloatingActionButtonThemeData(backgroundColor: ColorTable.fabButtonColor),
    iconTheme: IconThemeData(color: ColorTable.primaryColor),
    fontFamily: 'Segoe',
    appBarTheme: const AppBarTheme(systemOverlayStyle: SystemUiOverlayStyle.dark),
  );
}
