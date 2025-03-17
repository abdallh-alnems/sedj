import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import '../../core/play_sound.dart';
import '../../logic/controller/game_controller.dart';
import '../../logic/controller/help_controller.dart';

Widget buildGift() {
  return GetBuilder<HelpController>(
    builder: (controller) {
      GameController gameController = Get.find<GameController>();
      return Padding(
        padding: const EdgeInsets.only(right: 13),
        child: GestureDetector(
          onTap: () {
            AudioHelper.playSound(AudioHelper.gift);
            gameController.revealHintOnKeyboard();
            if (!controller.useHint()) {
              _watchAd(gameController);
            }
          },
          child: Stack(
            children: [
              Image.asset(
                "assets/images/gift_box.png",
                scale: 3.7,
              ).animate().slideX(
                begin: 1,
                end: 0,
                duration: NumDurationExtensions(2).seconds,
                curve: Curves.easeOut,
              ),
              if (controller.remainingHints > 0)
                Positioned(
                  right: 0,
                  top: 0,
                  child: Container(
                    padding: const EdgeInsets.all(4),
                    decoration: const BoxDecoration(
                      color: Colors.red,
                      shape: BoxShape.circle,
                    ),
                    child: Text(
                      "${controller.remainingHints}",
                      style: const TextStyle(fontSize: 12, color: Colors.white),
                    ),
                  ),
                ),
            ],
          ),
        ),
      );
    },
  );
}

void _watchAd(GameController gameController) {
  RewardedAd.load(
    adUnitId: "ca-app-pub-8595701567488603/3250127676",
    request: const AdRequest(), 
    rewardedAdLoadCallback: RewardedAdLoadCallback(
      onAdLoaded: (ad) {
        ad.fullScreenContentCallback = FullScreenContentCallback(
          onAdDismissedFullScreenContent: (ad) {
            ad.dispose();
          },
          onAdFailedToShowFullScreenContent: (ad, error) {
            ad.dispose();
          },
        );
        ad.show(onUserEarnedReward: (ad, reward) {});
      },
      onAdFailedToLoad: (error) {},
    ),
  );
}
