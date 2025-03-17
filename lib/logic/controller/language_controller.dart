import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class LocaleController extends GetxController {
  final languageLocale = GetStorage();
  var language = Rx<Locale>(Locale('ar'));

  static const List<String> supportedLanguages = [
    "ar",
    "en",
    "fr",
    "es",
    "de",
    "pt",
  ];

  final List<Map<String, String>> languageDetails = [
    {"code": "ar", "name": "العربية", "flag": "SA"},
    {"code": "en", "name": "English", "flag": "US"},
    {"code": "es", "name": "Español", "flag": "ES"},
    {"code": "fr", "name": "Français", "flag": "FR"},
    {"code": "de", "name": "Deutsch", "flag": "DE"},
    {"code": "pt", "name": "Português", "flag": "PT"},
  ];

  bool get isLangSelected => languageLocale.read("isLangSelected") ?? false;

  void changeLang(String codeLang) {
    Locale locale = Locale(codeLang);
    languageLocale.write("lang", codeLang);
    languageLocale.write("isLangSelected", true);
    language.value = locale;
    Get.updateLocale(locale);
  }

  @override
  void onInit() {
    super.onInit();
    String? getStorageLang = languageLocale.read("lang");

    if (getStorageLang != null && supportedLanguages.contains(getStorageLang)) {
      language.value = Locale(getStorageLang);
    } else {
      String systemLang = Get.deviceLocale?.languageCode ?? "en";
      language.value = Locale(
        supportedLanguages.contains(systemLang) ? systemLang : "en",
      );
      languageLocale.write("lang", language.value.languageCode);
    }

    Get.updateLocale(language.value);
  }
}
