import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:country_flags/country_flags.dart';
import '../../logic/controller/language_controller.dart';
import 'instructions.dart';

class LanguageSelectionPage extends StatelessWidget {
  LanguageSelectionPage({super.key});

  final LocaleController localeController = Get.find<LocaleController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.amber.shade100,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "choose_language".tr,
            style: TextStyle(fontSize: 27.sp, fontWeight: FontWeight.bold),
          ),
          Center(
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: localeController.languageDetails.length,
              itemBuilder: (context, index) {
                final lang = localeController.languageDetails[index];
                return Padding(
                  padding: EdgeInsets.symmetric(
                    vertical: 9.h,
                    horizontal: 21.w,
                  ),
                  child: GestureDetector(
                    onTap: () {
                      localeController.changeLang(lang["code"]!);
                      Get.off(
                        () => InstructionsPage(),
                        transition: Transition.upToDown,
                      );
                    },
                    child: Container(
                      padding: EdgeInsets.symmetric(
                        vertical: 13.h,
                        horizontal: 17.w,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(15),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black26,
                            blurRadius: 6,
                            offset: Offset(2, 4),
                          ),
                        ],
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          CountryFlag.fromCountryCode(
                            lang["flag"]!,
                            height: 17.h,
                            width: 29.w,
                          ),
                          SizedBox(width: 13.w),
                          Text(
                            lang["name"]!,
                            style: TextStyle(
                              fontSize: 19.sp,
                              fontWeight: FontWeight.w600,
                              color: Colors.black87,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
