// Bayraklar

import 'package:hero_games_case/core/constants/app_constants.dart';

enum Flags {
  tr,
  en;

  String get getFlag => AppConstants.flagPath(flagName: name);
}
