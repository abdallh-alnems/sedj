import 'package:get/get.dart';
import 'package:flutter/services.dart' show rootBundle;

class WordsController extends GetxController {
  var words = <String>[].obs; 

  @override
  void onInit() {
    super.onInit();
    loadWords(); 
  }

  Future<void> loadWords() async {
  
      
      String languageCode = (Get.locale?.languageCode ?? 'en').toLowerCase();
      String filePath = 'assets/lang/$languageCode.txt';
      String fileData = await rootBundle.loadString(filePath);

      List<String> loadedWords =
          fileData
              .split('\n')
              .map((e) => e.trim())
              .where((word) => word.isNotEmpty)
              .toList();

      if (languageCode == "ar") {
        words.assignAll(
          loadedWords.map((word) => normalizeArabic(word)).toList(),
        );
      } else {
        words.assignAll(loadedWords.map((word) => word.toUpperCase()).toList());
      }
      
      // ignore: avoid_print
      print("✅ عدد الكلمات المحملة: ${words.length} للغة: $languageCode");
    
  }

  
  bool checkWord(String inputWord) {
    String languageCode = (Get.locale?.languageCode ?? 'en').toLowerCase();
    if (languageCode == "ar") {
      return words.contains(normalizeArabic(inputWord));
    } else {
      return words.contains(inputWord.toUpperCase());
    }
  }

  
  String normalizeArabic(String input) {
    return input
        .replaceAll(
          RegExp(r'[ًٌٍَُِّْٰـ]'),
          '',
        ) 
        .replaceAll('أ', 'ا')
        .replaceAll('إ', 'ا')
        .replaceAll('آ', 'ا')
        .trim();
  }
}
