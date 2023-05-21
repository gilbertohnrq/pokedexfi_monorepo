import 'package:cached_network_image/cached_network_image.dart';
import 'package:dexfi_ui/dexfi_ui.dart';
import 'package:flutter/material.dart';
import 'package:pokedexfi/pages/details/args/poke_details_args.dart';
import 'package:pokedexfi/core/widgets/vector.dart';

class PokeDetailsPage extends StatelessWidget {
  final PokeDetailsArgs args;

  const PokeDetailsPage(this.args, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final poke = args.pokemon[args.index];

    return Stack(
      children: [
        Container(
          color: poke.types.first.color,
          height: size.height,
          width: size.width,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: DexSpacings.s10,
            vertical: DexSpacings.s20,
          ),
          child: Align(
            alignment: Alignment.topRight,
            child: Vector(
              Vectors.pokeball,
              size: 250,
              color: DexColors.white.withOpacity(0.1),
            ),
          ),
        ),
        Scaffold(
          backgroundColor: Colors.transparent,
          body: CustomScrollView(
            slivers: [
              SliverAppBar(
                backgroundColor: Colors.transparent,
                expandedHeight: size.height * 0.35,
                toolbarHeight: size.height * 0.35,
                title: Stack(
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        InkWell(
                          onTap: () => Navigator.of(context).pop(),
                          child: Icon(
                            Icons.arrow_back,
                            size: 28,
                            shadows: DexElevation.dropShadow2,
                          ),
                        ),
                        const SizedBox(width: DexSpacings.s8),
                        Text(poke.formattedName).headlineBold(
                          color: DexColors.white,
                        ),
                        const Spacer(),
                        Padding(
                          padding:
                              const EdgeInsets.only(right: DexSpacings.s12),
                          child: Text(poke.formattedId)
                              .subtitle2Bold(color: DexColors.white),
                        ),
                      ],
                    ),
                    SizedBox.square(
                      dimension: size.height * 0.312,
                      child: CachedNetworkImage(imageUrl: poke.image),
                    ),
                  ],
                ),
                automaticallyImplyLeading: false,
              ),
              // Add your SliverList or SliverGrid below
            ],
          ),
        ),
      ],
    );
  }
}
