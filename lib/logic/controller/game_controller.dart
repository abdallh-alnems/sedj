import 'dart:math';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'help_controller.dart';
import 'words_controller.dart';

class Cell {
  String letter;
  Color color;
  Cell({this.letter = "", this.color = Colors.white});
}

class GameController extends GetxController {
  RxList<List<Cell>> grid = <List<Cell>>[].obs;
  int currentRow = 0;
  int currentCol = 0;
  String solution = "";
  RxBool shakeCurrentRow = false.obs;

  RxMap<String, Color> keyboardColors = <String, Color>{}.obs;

  bool get isArabic => Get.locale?.languageCode == 'ar';

  @override
  void onInit() {
    super.onInit();
    startGame();
  }

  Future<void> startGame() async {
    keyboardColors.clear();

    WordsController wordsController = Get.find<WordsController>();
    if (wordsController.words.isEmpty) {
      await wordsController.loadWords();
    }

    solution =
        wordsController.words[Random().nextInt(wordsController.words.length)];

    print("الكلمة المختارة: $solution");
    grid.assignAll(
      List.generate(6, (_) => List.generate(solution.length, (_) => Cell())),
    );
    currentRow = 0;
    currentCol = 0;
    update();
  }

  void addLetter(String letter) {
    if (currentRow < 6 && currentCol < solution.length) {
      int index = isArabic ? (solution.length - 1 - currentCol) : currentCol;
      grid[currentRow][index].letter = letter;
      currentCol++;
      grid.refresh();
    }
  }

  void deleteLetter() {
    if (currentCol > 0) {
      currentCol--;
      int index = isArabic ? (solution.length - 1 - currentCol) : currentCol;
      grid[currentRow][index].letter = "";
      grid.refresh();
    }
  }

  void clearCurrentRow() {
    if (currentRow < grid.length) {
      for (int i = 0; i < grid[currentRow].length; i++) {
        grid[currentRow][i].letter = "";
      }
      currentCol = 0;
      grid.refresh();
      update();
    }
  }

  void submitRow() {
    if (currentCol < solution.length) return;

    String guess = grid[currentRow].map((cell) => (cell.letter)).join();

    if (isArabic) {
      guess = guess.split('').reversed.join();
    }



    List<Color> colors = List.filled(solution.length, Colors.grey);

    List<String?> solutionLetters = List<String?>.from(solution.split(''));

    for (int i = 0; i < solution.length; i++) {
      if (guess[i] == solution[i]) {
        colors[i] = Colors.green;
        solutionLetters[i] = null;
      }
    }

    for (int i = 0; i < solution.length; i++) {
      if (colors[i] != Colors.green && solutionLetters.contains(guess[i])) {
        colors[i] = Colors.yellow;
        int index = solutionLetters.indexOf(guess[i]);
        if (index != -1) {
          solutionLetters[index] = null;
        }
      }
    }

    if (currentRow < grid.length) {
      for (int i = 0; i < solution.length; i++) {
        int index = isArabic ? (solution.length - 1 - i) : i;
        grid[currentRow][index].color = colors[i];
      }
    }
    grid.refresh();

    for (int i = 0; i < solution.length; i++) {
      String letter = guess[i];
      Color newColor;
      if (guess[i] == solution[i]) {
        newColor = Colors.green;
      } else if (solution.contains(guess[i])) {
        newColor = Colors.yellow;
      } else {
        newColor = Colors.grey;
      }
      if (!keyboardColors.containsKey(letter)) {
        keyboardColors[letter] = newColor;
      } else {
        Color currentColor = keyboardColors[letter]!;
        if (currentColor == Colors.grey &&
            (newColor == Colors.green || newColor == Colors.yellow)) {
          keyboardColors[letter] = newColor;
        } else if (currentColor == Colors.yellow && newColor == Colors.green) {
          keyboardColors[letter] = newColor;
        }
      }
    }

    if (guess == solution) {
      Get.find<HelpController>().addHint();
      Future.delayed(Duration(milliseconds: 500), () {
        startGame();
      });
    } else {
      currentRow++;
      currentCol = 0;
      if (currentRow >= 6) {
        Get.defaultDialog(
          title: "titleAttempts".tr,
          middleText: "middleTextAttempts".trParams({'solution': solution}),
          backgroundColor: Colors.white,
          titleStyle: const TextStyle(
            color: Colors.black,
            fontSize: 22,
            fontWeight: FontWeight.bold,
          ),
          middleTextStyle: const TextStyle(color: Colors.black87, fontSize: 18),
          textConfirm: "textConfirm".tr,
          confirmTextColor: Colors.white,
          buttonColor: Colors.green,
          onConfirm: () {
            startGame();
            Get.back();
          },
        );
      }
    }
  }

  bool hasProgress() {
    for (var row in grid) {
      if (row.any((cell) => cell.letter.isNotEmpty)) {
        return true;
      }
    }
    return false;
  }

  void resetProgress() {
    for (var row in grid) {
      for (var cell in row) {
        cell.letter = "";
        cell.color = Colors.white;
      }
    }
    currentRow = 0;
    currentCol = 0;
    update();
  }

  void revealHintOnKeyboard() {
    List<String> candidates = [];
    for (var letter in solution.split('')) {
      Color? currentColor = keyboardColors[letter];
      if (currentColor == null || currentColor == Colors.grey) {
        candidates.add(letter);
      }
    }
    if (candidates.isNotEmpty) {
      String letterToReveal = candidates[Random().nextInt(candidates.length)];

      keyboardColors[letterToReveal] = Colors.yellow;
      update();
    }
  }
}
