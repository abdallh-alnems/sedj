import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

class AnimatedTitle extends StatelessWidget {
  const AnimatedTitle({super.key});

  @override
  Widget build(BuildContext context) {
    
    final List<String> letters = "SEDJ".split("");
    
    final List<Color> containerColors = [
      Colors.green,
      Colors.yellow,
      Colors.grey,
      Colors.transparent,
    ];
    
    final List<Color> textColors = List.generate(
      letters.length,
      (_) => Colors.black,
    );

    return Row(
      mainAxisSize: MainAxisSize.min,
      textDirection: TextDirection.ltr, 
      children: List.generate(letters.length, (index) {
        return Container(
              margin: const EdgeInsets.symmetric(horizontal: 4),
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: containerColors[index % containerColors.length],
                border: Border.all(color: Colors.black, width: 2),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(
                letters[index],
                style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                  color: textColors[index],
                ),
              ),
            )
            .animate(delay: Duration(milliseconds: 100 * index))
            .slideY(
              begin: -1,
              end: 0,
              duration: const Duration(seconds: 2),
              curve: Curves.easeOut,
            );
      }),
    );
  }
}
