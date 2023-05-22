import 'package:dexfi_ui/dexfi_ui.dart';
import 'package:flutter/material.dart';
import 'package:pokedexfi/core/extensions/string_extensions.dart';
import 'package:pokedexfi/core/widgets/vector.dart';

class PokemonAttributes extends StatelessWidget {
  final Vectors? icon;
  final Color? iconColor;
  final List<String> moves;
  final String label;

  const PokemonAttributes({
    Key? key,
    this.icon,
    this.iconColor,
    required this.moves,
    required this.label,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final moveTexts = moves.map((move) {
      return Text(move.capitalize()).body3Regular(color: DexColors.darkText);
    }).toList();

    return Container(
      padding: const EdgeInsets.only(top: DexSpacings.s8),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              if (icon != null) Vector(icon!, color: iconColor),
              if (icon != null) const SizedBox(width: DexSpacings.s10),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: moveTexts,
              ),
            ],
          ),
          const SizedBox(height: DexSpacings.s12),
          Text(label, textAlign: TextAlign.center).captionRegular(),
        ],
      ),
    );
  }
}
