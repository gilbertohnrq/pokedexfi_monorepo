import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:pokedexfi/core/widgets/vector.dart';

class LoadingWidget extends StatelessWidget {
  const LoadingWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Vector(Vectors.pokeball, size: 100)
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
