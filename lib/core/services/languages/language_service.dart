import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../storage/custom_storage_service.dart';
import '../storage/storage_key_enums.dart';

enum LocaleLanguages {
  en,
  tr,
  nl,
  ru,
  ar;

  String get text {
    switch (this) {
      case LocaleLanguages.en:
        return "İngilizce";
      case LocaleLanguages.tr:
        return "Türkçe";
      case LocaleLanguages.nl:
        return "Flemenkçe";
      case LocaleLanguages.ru:
        return "Rusça";
      case LocaleLanguages.ar:
        return "Arapça";
      default:
        return "Türkçe";
    }
  }
}

Map<LocaleLanguages, Locale> locales = {
  LocaleLanguages.en: const Locale('en', 'US'),
  LocaleLanguages.tr: const Locale('tr', 'TR'),
  LocaleLanguages.nl: const Locale('nl', 'NL'),
  LocaleLanguages.ru: const Locale('ru', 'RU'),
  LocaleLanguages.ar: const Locale('ar', 'AE'),
};

class LanguageService extends GetxService {
  final _storageService = Get.find<CustomStorageService>();
  // Eğer cihazın dili desteklemediğimiz bir dilse belirttiğimiz dil döner
  static const Locale fallbackLocale = Locale('en', 'US');
  Locale currentLocale = const Locale('en', 'US');

  @override
  void onInit() {
    final locale = _storageService.read(StorageKeys.language.name);
    if (locale is String) {
      currentLocale = Locale.fromSubtags(languageCode: locale);
    } else {
      currentLocale = Get.deviceLocale ?? fallbackLocale;
    }

    super.onInit();
  }

  Future<void> setLocale(Locale locale) async {
    await _storageService.write(StorageKeys.language.name, locale.languageCode);
    await Get.updateLocale(locale);
  }
}
