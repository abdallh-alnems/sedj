import 'package:flutter/material.dart';
import 'gift.dart';
import 'setting.dart';
import 'animated_title.dart'; // تأكد من استيراد AnimatedTitle

class AppBarHome extends StatelessWidget implements PreferredSizeWidget {
  const AppBarHome({super.key});

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.ltr, // إجبار الاتجاه من اليسار إلى اليمين
      child: AppBar(
        title: const AnimatedTitle(),
        centerTitle: true,
        leading: buildSettingsButton(),
        actions: [buildGift()],
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
