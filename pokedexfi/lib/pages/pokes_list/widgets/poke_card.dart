import 'package:cached_network_image/cached_network_image.dart';
import 'package:dexfi_ui/dexfi_ui.dart';
import 'package:flutter/material.dart';
import 'package:pokedexfi/core/domain/models/pokemon/poke_model.dart';
import 'package:pokedexfi/core/widgets/bouncing.dart';
import 'package:pokedexfi/core/widgets/vector.dart';

class PokeCard extends StatelessWidget {
  const PokeCard(this.poke, {Key? key, required this.onTap}) : super(key: key);

  final Poke poke;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Bouncing(
      onTap: onTap,
      child: Hero(
        tag: poke.id,
        child: Container(
          decoration: BoxDecoration(
            color: DexColors.white,
            boxShadow: DexElevation.dropShadow2,
            borderRadius: BorderRadius.circular(DexRadius.r8),
          ),
          child: Center(
            child: Stack(
              children: [
                Positioned.fill(
                  child: Align(
                    alignment: Alignment.bottomCenter,
                    child: Container(
                      padding: const EdgeInsets.only(
                        top: DexSpacings.s24,
                        bottom: DexSpacings.s4,
                        right: DexSpacings.s8,
                        left: DexSpacings.s8,
                      ),
                      height: 44,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: DexColors.background,
                        borderRadius: BorderRadius.circular(DexRadius.r8),
                      ),
                      child: Center(
                        child: Text(poke.formattedName).body3Regular(
                          style: const TextStyle(color: DexColors.darkText),
                        ),
                      ),
                    ),
                  ),
                ),
                Positioned.fill(
                  top: DexSpacings.s4,
                  right: DexSpacings.s8,
                  child: Align(
                    alignment: Alignment.topRight,
                    child: Text(poke.formattedId).captionRegular(
                      style: const TextStyle(color: DexColors.mediumGray),
                    ),
                  ),
                ),
                Positioned.fill(
                  child: poke.other.officialArtwork.frontDefault == null
                      ? const SizedBox()
                      : LayoutBuilder(
                          builder: (context, constraints) {
                            return Align(
                              alignment: Alignment.center,
                              child: CachedNetworkImage(
                                imageUrl:
                                    poke.other.officialArtwork.frontDefault!,
                                fit: BoxFit.cover,
                                height: constraints.maxWidth * 0.7,
                                width: constraints.maxWidth * 0.7,
                                placeholder: (context, url) => const Center(
                                  child: Vector(
                                    Vectors.pokePlaceholder,
                                    path: 'images',
                                    size: 72,
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
