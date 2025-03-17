import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:get/get.dart';
import 'package:sedj/logic/controller/game_controller.dart';
import 'package:sedj/core/play_sound.dart';

class Keyboard extends StatelessWidget {
  Keyboard({super.key});

  final GameController gameController = Get.find<GameController>();

  final Map<String, List<List<String>>> keyboardLayouts = {
    'en': [
      ["Q", "W", "E", "R", "T", "Y", "U", "I", "O", "P"],
      ["A", "S", "D", "F", "G", "H", "J", "K", "L", "⌫"],
      ["Z", "X", "C", "V", "B", "N", "M", "Enter"],
    ],
    'ar': [
      ["ض", "ص", "ث", "ق", "ف", "غ", "ع", "ه", "خ", "ح", "ج"],
      ["ش", "س", "ي", "ب", "ل", "ا", "ت", "ن", "م", "ك", "ط", "⌫"],
      ["ذ", "ئ", "ؤ", "ر", "ى", "ة", "و", "ز", "ظ", "د", "Enter"],
    ],
  };

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final currentLang = Get.locale?.languageCode ?? 'en';
      final layout = keyboardLayouts[currentLang] ?? keyboardLayouts['en']!;
      return Padding(
        padding: const EdgeInsets.symmetric(vertical: 13),
        child: Column(
          children:
              layout
                  .asMap()
                  .entries
                  .map((entry) => _buildKeyboardRow(entry.value, entry.key))
                  .toList(),
        ),
      );
    });
  }

  Widget _buildKeyboardRow(List<String> keys, int rowIndex) {
    return Padding(
      key: ValueKey(rowIndex),
      padding: const EdgeInsets.symmetric(vertical: 2.3),
      child: Row(
        textDirection: TextDirection.ltr,
        mainAxisAlignment: MainAxisAlignment.center,
        children:
            keys
                .asMap()
                .entries
                .map((entry) => _buildKeyButton(entry.value, entry.key))
                .toList(),
      ),
    );
  }

  Widget _buildKeyButton(String letter, int index) {
    int flex = (letter == "Enter") ? 3 : 1;

    Color keyColor =
        gameController.keyboardColors[letter] ?? Colors.amber.shade100;

    return Expanded(
      flex: flex,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 2),
        child: OutlinedButton(
          onPressed: () {
            if (letter == "Enter") {
              gameController.submitRow();
              AudioHelper.playSound(AudioHelper.enter);
            } else if (letter == "⌫") {
              gameController.deleteLetter();
              AudioHelper.playSound(AudioHelper.delete);
            } else {
              gameController.addLetter(letter);
              AudioHelper.playSound(AudioHelper.keyboard);
            }
            HapticFeedback.lightImpact();
          },
          onLongPress:
              letter == "⌫"
                  ? () {
                    gameController.clearCurrentRow();
                    AudioHelper.playSound(AudioHelper.delete);
                    HapticFeedback.mediumImpact();
                  }
                  : null,
          style: OutlinedButton.styleFrom(
            foregroundColor: Colors.brown.shade700,
            backgroundColor: keyColor,
            side: BorderSide(color: Colors.brown.shade600, width: 2),
            padding: const EdgeInsets.symmetric(vertical: 9),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(5),
            ),
          ),
          child: Text(
            letter,
            style: const TextStyle(fontSize: 19, fontWeight: FontWeight.bold),
          ),
        ).animate().scale(delay: 150.ms * index, duration: 500.ms),
      ),
    );
  }
}
