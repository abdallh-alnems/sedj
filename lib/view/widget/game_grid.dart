import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:get/get.dart';
import 'package:sedj/logic/controller/game_controller.dart';

class GameGrid extends StatelessWidget {
  GameGrid({super.key});

  final GameController gameController = Get.find<GameController>();

  @override
Widget build(BuildContext context) {
    bool isArabic = Get.locale?.languageCode == 'ar';
    return Obx(
      () => Padding(
        padding: const EdgeInsets.only(top: 55),
        child: Column(
          children: List.generate(gameController.grid.length, (row) {
            // توليد قائمة خلايا الصف
            List<Widget> letterBoxes = List.generate(
              gameController.grid[row].length,
              (col) => _buildLetterBox(row, col, gameController.grid[row][col]),
            );
            // إذا كانت اللغة عربية، نقلب ترتيب الخلايا
            if (isArabic) {
              letterBoxes = letterBoxes.reversed.toList();
            }
            Widget rowWidget = Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: letterBoxes,
            );
            if (row == gameController.currentRow &&
                gameController.shakeCurrentRow.value) {
              rowWidget = rowWidget.animate().shake();
            }
            return rowWidget;
          }),
        ),
      ),
    );
  }



  Widget _buildLetterBox(int row, int col, cell) {
    return Container(
          margin: const EdgeInsets.all(5),
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            color: cell.color,
            border: Border.all(color: Colors.black54, width: 2),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Center(
            child: Text(
              cell.letter,
              style: const TextStyle(fontSize: 24, color: Colors.black87),
            ),
          ),
        )
        .animate()
        .fadeIn(
          duration: NumDurationExtensions(1).seconds,
          delay: (row * 100 + col * 50).ms,
        )
        .scaleXY(
          begin: 5,
          end: 1,
          duration: NumDurationExtensions(1).seconds,
          curve: Curves.easeOutBack,
        );
  }
}
