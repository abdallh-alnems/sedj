import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class HelpController extends GetxController {
  final GetStorage storage = GetStorage();
  static const String kRemainingHintsKey = 'remaining_hints';

  int remainingHints = 3;

  @override
  void onInit() {
    super.onInit();

    remainingHints = storage.read(kRemainingHintsKey) ?? 3;
    update();
  }

  bool useHint() {
    if (remainingHints > 0) {
      remainingHints--;
      storage.write(kRemainingHintsKey, remainingHints);
      update();
      return true;
    }
    return false;
  }

  void resetHints() {
    remainingHints = 3;
    storage.write(kRemainingHintsKey, remainingHints);
    update();
  }

  void addHint() {
    remainingHints++;
    storage.write(kRemainingHintsKey, remainingHints);
    update();
  }
}
