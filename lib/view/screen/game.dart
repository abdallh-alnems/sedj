import 'package:flutter/material.dart';
import '../widget/app_bar.dart';
import '../widget/banner.dart';
import '../widget/game_grid.dart';
import '../widget/keyboard.dart';

class Game extends StatelessWidget {
  const Game({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarHome(),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children:  [GameGrid(), Keyboard()],
      ),
      bottomNavigationBar: const BannerAdWidget(),
    );
  }
}
