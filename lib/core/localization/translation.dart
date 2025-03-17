import 'package:get/get.dart';

import 'language/ar.dart';
import 'language/de.dart';
import 'language/en.dart';
import 'language/es.dart';
import 'language/fr.dart';
import 'language/pt.dart';

class MyTranslation extends Translations {
  @override
  Map<String, Map<String, String>> get keys => {
    // ============================ Arabic ============================
    "ar": ArabicTranslations.ar,

    // ============================ English ============================
    "en": EnglishTranslations.en,

    // ============================ Spanish ============================
    "es": SpanishTranslations.es,

    // ============================ French ============================
    "fr": FrenchTranslations.fr,

    // ============================ German ============================
    "de": GermanTranslations.de,

    // ============================ Russian ============================
    "pt": PortugueseTranslations.pt,
  };
}
