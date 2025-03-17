import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'core/theme.dart';
import 'core/play_sound.dart';
import 'core/localization/translation.dart';
import 'logic/my_binding.dart';
import 'logic/controller/language_controller.dart';
import 'view/screen/game.dart';
import 'view/screen/language.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  MobileAds.instance.initialize();
  await GetStorage.init();
  AudioHelper.loadVolume();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final LocaleController controller = Get.put(LocaleController());

    return ScreenUtilInit(
      designSize: const Size(360, 690),
      minTextAdapt: true,
      builder: (context, child) {
        return GetMaterialApp(
          debugShowCheckedModeBanner: false,
          theme: AppTheme.lightTheme,
          translations: MyTranslation(),
          locale: controller.language.value,
          home: controller.isLangSelected ? Game() : LanguageSelectionPage(),
          initialBinding: MyBindings(),
        );
      },
    );
  }
}
