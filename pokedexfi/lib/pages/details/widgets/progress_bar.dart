import 'package:dexfi_ui/dexfi_ui.dart';
import 'package:flutter/material.dart';

class AnimatedProgressBar extends StatelessWidget {
  const AnimatedProgressBar({
    Key? key,
    required this.value,
    required this.color,
  }) : super(key: key);

  final double value;
  final Color color;

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Container(
      width: screenWidth,
      height: 4,
      decoration: BoxDecoration(
        color: color.withOpacity(0.2),
        borderRadius: BorderRadius.circular(DexRadius.r4),
      ),
      child: Align(
        alignment: Alignment.centerLeft,
        child: TweenAnimationBuilder(
          tween: Tween<double>(begin: 0, end: value),
          duration: const Duration(milliseconds: 250),
          builder: (context, double value, child) {
            return Container(
              width: value,
              decoration: BoxDecoration(
                color: color,
                borderRadius: BorderRadius.circular(DexRadius.r4),
              ),
            );
          },
        ),
      ),
    );
  }
}
