// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cached_network_image/cached_network_image.dart';
import 'package:dexfi_ui/dexfi_ui.dart';
import 'package:flutter/material.dart';

import 'package:pokedexfi/core/extensions/string_extensions.dart';
import 'package:pokedexfi/core/widgets/vector.dart';
import 'package:pokedexfi/pages/details/args/poke_details_args.dart';
import 'package:pokedexfi/pages/details/widgets/pokemon_attributes_widget.dart';

class PokeDetailsPage extends StatelessWidget {
  final PokeDetailsArgs args;

  const PokeDetailsPage(this.args, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final poke = args.pokemon[args.index];

    return Scaffold(
      backgroundColor: poke.types.first.color,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        leading: IconButton(
          onPressed: () {},
          icon: Icon(
            Icons.arrow_back,
            shadows: DexElevation.dropShadow2,
          ),
        ),
        titleSpacing: DexSpacings.s0,
        title: Row(
          children: [
            Text(
              poke.formattedName,
              style: const TextStyle(
                color: DexColors.white,
                fontSize: 24,
                fontWeight: FontWeight.bold,
                fontFamily: 'Poppins',
              ),
            ),
            const Spacer(),
            Text(
              poke.formattedId,
              style: const TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.bold,
                color: DexColors.white,
                fontFamily: 'Poppins',
              ),
            ),
            const SizedBox(width: DexSpacings.s24),
          ],
        ),
      ),
      body: Stack(
        children: [
          Positioned(
            right: DexSpacings.s10,
            top: DexSpacings.s8,
            child: Vector(
              Vectors.pokeball,
              size: 208,
              color: DexColors.white.withOpacity(0.1),
            ),
          ),
          Positioned.fill(
            top: DexSpacings.s76,
            child: PageView(
              children: [
                Stack(
                  children: [
                    Container(
                      margin: const EdgeInsets.only(
                        top: 200 - 56,
                        left: DexSpacings.s4,
                        right: DexSpacings.s4,
                        bottom: DexSpacings.s4,
                      ),
                      decoration: BoxDecoration(
                        color: DexColors.white,
                        boxShadow: DexElevation.innerShadow1,
                        borderRadius: BorderRadius.circular(DexRadius.r8),
                      ),
                      child: ListView(
                        padding: const EdgeInsets.only(
                          top: 0,
                          bottom: DexSpacings.s20,
                          left: DexSpacings.s20,
                          right: DexSpacings.s20,
                        ),
                        children: [
                          const SizedBox(height: 56),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: poke.types.map(
                              (type) {
                                return Padding(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: DexSpacings.s8,
                                  ),
                                  child: Chip(
                                    backgroundColor: type.color,
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: DexSpacings.s8,
                                      vertical: DexSpacings.s2,
                                    ),
                                    label: Text(
                                      type.name?.capitalize() ?? '',
                                      style: const TextStyle(
                                        color: DexColors.white,
                                        fontSize: 10,
                                        fontWeight: FontWeight.bold,
                                        fontFamily: 'Poppins',
                                      ),
                                    ),
                                  ),
                                );
                              },
                            ).toList(),
                          ),
                          const SizedBox(height: DexSpacings.s16),
                          Center(
                            child: const Text('About').subtitle1Bold(
                              color: poke.types.first.color,
                            ),
                          ),
                          const SizedBox(height: DexSpacings.s16),
                          IntrinsicHeight(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Expanded(
                                  child: PokemonAttributesWidget(
                                    icon: Vectors.weight,
                                    iconColor: DexColors.darkText,
                                    moves: [poke.formattedWeight],
                                    label: 'Weight',
                                  ),
                                ),
                                const DexVerticalDivider(),
                                Expanded(
                                  child: PokemonAttributesWidget(
                                    icon: Vectors.straighten,
                                    iconColor: DexColors.darkText,
                                    moves: [poke.formattedHeight],
                                    label: 'Height',
                                  ),
                                ),
                                const DexVerticalDivider(),
                                Expanded(
                                  child: PokemonAttributesWidget(
                                    moves: poke.abilities
                                        .take(2)
                                        .map((ability) => ability.ability.name)
                                        .toList(),
                                    label: 'Moves',
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    Align(
                      alignment: Alignment.topCenter,
                      child: CachedNetworkImage(
                        imageBuilder: (context, imageProvider) => Opacity(
                          opacity: poke.name == 'bulbasaur' ? 0.8 : 1,
                          child: Image(image: imageProvider),
                        ),
                        imageUrl: poke.image,
                        height: 200,
                        width: 200,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
