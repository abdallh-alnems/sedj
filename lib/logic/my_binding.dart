import 'package:get/get.dart';

import 'controller/banner_controller.dart';
import 'controller/game_controller.dart';
import 'controller/help_controller.dart';
import 'controller/words_controller.dart';

class MyBindings extends Bindings {
  @override
  void dependencies() {
    Get.put(BannerAdController());
    Get.put(WordsController());
    Get.put(GameController());
    Get.put(HelpController());
  }
}
