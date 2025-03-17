import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../logic/controller/game_controller.dart';
import '../../logic/controller/words_controller.dart';
import '../widget/animated_title.dart';
import 'game.dart';

class InstructionsPage extends StatelessWidget {
  const InstructionsPage({super.key});

  Widget _buildInstructionContent() {
    return Column(
      children: [
        Text("title".tr, style: TextStyle(color: Colors.black, fontSize: 23)),
        const SizedBox(height: 23),
        Row(
          children: [
            Text(
              "instructions1".tr,
              style: TextStyle(color: Colors.black, fontSize: 17),
            ),
          ],
        ),
        const SizedBox(height: 13),
        Text(
          "instructions2".tr,
          style: TextStyle(color: Colors.black, fontSize: 17),
        ),

        const SizedBox(height: 45),
        const AnimatedTitle(),
        const SizedBox(height: 23),
        Row(
          children: [
            Container(height: 25, width: 25, color: Colors.green),
            const SizedBox(width: 11),
            Expanded(
              child: Text(
                "instructionsGreen".tr,
                style: const TextStyle(color: Colors.black, fontSize: 15),
              ),
            ),
          ],
        ),
        const SizedBox(height: 23),
        Row(
          children: [
            Container(height: 25, width: 25, color: Colors.yellow),
            const SizedBox(width: 11),
            Expanded(
              child: Text(
                "instructionsYellow".tr,
                style: const TextStyle(color: Colors.black, fontSize: 15),
              ),
            ),
          ],
        ),
        const SizedBox(height: 23),
        Row(
          children: [
            Container(height: 25, width: 25, color: Colors.grey),
            const SizedBox(width: 11),

            Expanded(
              child: Text(
                "instructionsGray".tr,
                style: const TextStyle(color: Colors.black, fontSize: 15),
              ),
            ),
          ],
        ),
        const SizedBox(height: 23),
        Row(
          children: [
            Container(
              height: 25,
              width: 25,
              decoration: BoxDecoration(border: Border.all()),
            ),
            const SizedBox(width: 11),
            Expanded(
              child: Text(
                "instructionsTransparent".tr,
                style: const TextStyle(color: Colors.black, fontSize: 15),
              ),
            ),
          ],
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 19, vertical: 55),
          child: Column(
            children: [
              Expanded(
                child: SingleChildScrollView(child: _buildInstructionContent()),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 40,
                    vertical: 12,
                  ),
                ),
                onPressed: () async {
                  await Get.find<WordsController>().loadWords();
                  await Get.find<GameController>().startGame();

                  Get.offAll(() => Game(), transition: Transition.upToDown);
                },
                child: Text(
                  "button".tr,
                  style: TextStyle(fontSize: 19, color: Colors.white),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
