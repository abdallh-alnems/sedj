import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import '../../logic/controller/banner_controller.dart';

class BannerAdWidget extends StatelessWidget {
  const BannerAdWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final BannerAdController adController = Get.find<BannerAdController>();
    return Obx(() {
      if (adController.isAdLoaded.value && adController.bannerAd != null) {
        return SizedBox(
          width: double.infinity,
          height: adController.bannerAd!.size.height.toDouble(),
          child: AdWidget(ad: adController.bannerAd!),
        );
      } else {
        return const SizedBox(); 
      }
    });
  }
}
