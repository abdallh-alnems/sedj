import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

class BannerAdController extends GetxController {
  BannerAd? bannerAd;
  RxBool isAdLoaded = false.obs;

  @override
  void onInit() {
    super.onInit();
    loadBannerAd();
  }

  void loadBannerAd() {
    bannerAd = BannerAd(
      adUnitId: "ca-app-pub-8595701567488603/7174992448",
      size: AdSize.banner,
      request: const AdRequest(),
      listener: BannerAdListener(
        onAdLoaded: (ad) {
          isAdLoaded.value = true;
        },
        onAdFailedToLoad: (ad, error) {
          ad.dispose();
        },
      ),
    )..load();
  }

  @override
  void onClose() {
    bannerAd?.dispose();
    super.onClose();
  }
}
