import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:get/get.dart';

import '../../core/play_sound.dart';
import '../../logic/controller/game_controller.dart';
import '../../logic/controller/language_controller.dart';
import '../../logic/controller/words_controller.dart';

Widget buildSettingsButton() {
  return IconButton(
    icon: Icon(Icons.settings, color: Colors.black, size: 27)
        .animate()
        .slideX(
          begin: -1, // يبدأ من خارج الشاشة على اليسار
          end: 0, // ينتهي في موقعه الطبيعي
          duration: NumDurationExtensions(2).seconds,
          curve: Curves.easeOut,
        )
        .fadeIn(duration: 500.ms),
    onPressed: () {
      AudioHelper.playSound(AudioHelper.keyboard);
      _showCustomSettingsDialog();
    },
  );
}

void _showCustomSettingsDialog() {
  final localeController = Get.find<LocaleController>();
  final gameController = Get.find<GameController>();

  Get.dialog(
    Obx(
      () => AlertDialog(
        backgroundColor: Colors.blueGrey[900],
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        // إزالة الـ Center واستخدام textAlign لتثبيت النص من اليسار
        title: Text(
          "setting".tr,
          textAlign: TextAlign.center,
          style: const TextStyle(
            fontSize: 21,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        // تغليف المحتوى بـ Directionality مع ضبط textDirection إلى LTR
        content: Directionality(
          textDirection: TextDirection.ltr,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            
            children: [
              Row(
                children: [
                  Icon(
                    AudioHelper.volume.value == 0.0
                        ? Icons.volume_off
                        : Icons.volume_up,
                    color:
                        AudioHelper.volume.value == 0.0
                            ? Colors.redAccent
                            : Colors.greenAccent,
                    size: 30,
                  ),
                  Expanded(
                    child: Slider(
                      min: 0.0,
                      max: 1.0,
                      activeColor: Colors.cyanAccent,
                      inactiveColor: Colors.grey[700],
                      value: AudioHelper.volume.value,
                      onChanged: (val) {
                        AudioHelper.playSound(AudioHelper.keyboard);
                        AudioHelper.setVolume(val);
                      },
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 15),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.language, color: Colors.white, size: 25),
                  const SizedBox(width: 10),
                  DropdownButton<String>(
                    dropdownColor: Colors.blueGrey[800],
                    value: localeController.language.value.languageCode,
                    icon: const Icon(
                      Icons.arrow_drop_down,
                      color: Colors.white,
                    ),
                    style: const TextStyle(color: Colors.white, fontSize: 16),
                    underline: Container(height: 2, color: Colors.cyanAccent),
                    onChanged: (String? newLang) async {
                      if (newLang != null) {
                        if (gameController.hasProgress()) {
                          Get.defaultDialog(
                            title: "alert".tr,
                            middleText:
                                "middleText".tr,
                            backgroundColor: Colors.blueGrey[900],
                            titleStyle: const TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                            middleTextStyle: const TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                            ),
                            actions: [
                              TextButton(
                                onPressed: () {
                                  Get.back();
                                },
                                child:  Text(
                                  "cancel".tr,
                                  style: TextStyle(
                                    color: Colors.redAccent,
                                    fontSize: 18,
                                  ),
                                ),
                              ),
                              TextButton(
                                onPressed: () async {
                                  gameController.resetProgress();
                                  localeController.changeLang(newLang);
                                  await Get.find<WordsController>().loadWords();
                                  await gameController.startGame();
                                  AudioHelper.playSound(AudioHelper.keyboard);
                                  Get.back();
                                },
                                child:  Text(
                                  "ok".tr,
                                  style: TextStyle(
                                    color: Colors.greenAccent,
                                    fontSize: 18,
                                  ),
                                ),
                              ),
                            ],
                          );
                        } else {
                          localeController.changeLang(newLang);
                          await Get.find<WordsController>().loadWords();
                          await gameController.startGame();
                          AudioHelper.playSound(AudioHelper.keyboard);
                        }
                      }
                    },
                    items:
                        localeController.languageDetails
                            .map<DropdownMenuItem<String>>((lang) {
                              return DropdownMenuItem<String>(
                                value: lang["code"],
                                child: Text(
                                  lang["name"]!,
                                  style: const TextStyle(color: Colors.white),
                                ),
                              );
                            })
                            .toList(),
                  ),
                ],
              ),
            ],
          ),
        ),
        actionsAlignment: MainAxisAlignment.center,
        actions: [
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.redAccent,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 17, vertical: 9),
            ),
            onPressed: () {
              Get.back();
              AudioHelper.playSound(AudioHelper.keyboard);
            },
            child: Text(
              "close".tr,
              style: const TextStyle(
                fontSize: 17,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    ),
  );
}

