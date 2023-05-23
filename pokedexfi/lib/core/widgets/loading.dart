import 'package:dexfi_ui/dexfi_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:pokedexfi/core/widgets/vector.dart';

class LoadingWidget extends StatelessWidget {
  const LoadingWidget({
    Key? key,
    this.color = DexColors.white,
    this.size = 100,
  }) : super(key: key);

  final Color color;
  final double size;

  @override
  Widget build(BuildContext context) {
    return Vector(Vectors.pokeball, size: size, color: color)
        .animate(
          autoPlay: true,
          onComplete: (controller) {
            controller.repeat(reverse: true);
          },
        )
        .rotate(
          duration: 1200.ms,
          curve: Curves.linear,
        )
        .scale(
          begin: const Offset(0.7, 0.7),
          end: const Offset(1.5, 1.5),
          duration: 1200.ms,
          curve: Curves.easeInOut,
        )
        .fadeIn(
          duration: 800.ms,
          curve: Curves.easeIn,
          begin: 0.8,
        )
        .scale(
          begin: const Offset(1.5, 1.5),
          end: const Offset(0.7, 0.7),
          duration: 1200.ms,
          curve: Curves.easeInOut,
        );
  }
}
