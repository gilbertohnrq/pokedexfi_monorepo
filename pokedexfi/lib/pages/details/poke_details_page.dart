import 'package:cached_network_image/cached_network_image.dart';
import 'package:dexfi_ui/dexfi_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pokedexfi/core/domain/enums/poke_stats.dart';
import 'package:pokedexfi/core/extensions/string_extensions.dart';
import 'package:pokedexfi/core/widgets/loading.dart';
import 'package:pokedexfi/core/widgets/vector.dart';
import 'package:pokedexfi/pages/details/args/poke_details_args.dart';
import 'package:pokedexfi/pages/details/cubit/poke_details_cubit.dart';
import 'package:pokedexfi/pages/details/widgets/pokemon_attributes.dart';
import 'package:pokedexfi/pages/details/widgets/progress_bar.dart';

import '../../core/domain/models/pokemon/poke_model.dart';

class PokeDetailsPage extends StatefulWidget {
  final PokeDetailsArgs args;

  const PokeDetailsPage(this.args, {Key? key}) : super(key: key);

  @override
  State<PokeDetailsPage> createState() => _PokeDetailsPageState();
}

class _PokeDetailsPageState extends State<PokeDetailsPage> {
  late PageController _pageController;
  late Poke poke;
  int currentPage = 0;
  final cubit = PokeDetailsCubit();

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: widget.args.index);
    cubit.init(widget.args.listPokes);
    currentPage = widget.args.index;
    poke = cubit.state.pokemons[currentPage];
  }

  @override
  void dispose() {
    super.dispose();
    _pageController.dispose();
    cubit.close();
  }

  void nextPokemon() {
    if (currentPage < cubit.state.pokemons.length - 1) {
      currentPage++;
      final newPoke = cubit.state.pokemons[currentPage];
      setState(() {
        poke = newPoke;
      });
      if (currentPage >= cubit.state.pokemons.length - 1) {
        cubit.getMorePokemonsWhenListIsOver(currentPage);
      }
      _pageController.jumpToPage(currentPage);
    }
  }

  void previousPokemon() {
    if (currentPage > 0) {
      currentPage--;
      final newPoke = cubit.state.pokemons[currentPage];
      setState(() {
        poke = newPoke;
      });
      _pageController.jumpToPage(currentPage);
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<PokeDetailsCubit, PokeDetailsState>(
      bloc: cubit,
      listener: (_, state) {},
      builder: (context, state) {
        if (state is Loading) {
          return Center(
            child: Container(
              color: poke.types.first.color,
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              child: const LoadingWidget(size: 100),
            ),
          );
        }
        return Scaffold(
          backgroundColor: poke.types.first.color,
          extendBodyBehindAppBar: true,
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            leading: IconButton(
              onPressed: Navigator.of(context).pop,
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
                  controller: _pageController,
                  physics: const NeverScrollableScrollPhysics(),
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
                            physics: const BouncingScrollPhysics(),
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
                                      child: PokemonAttributes(
                                        icon: Vectors.weight,
                                        iconColor: DexColors.darkText,
                                        moves: [poke.formattedWeight],
                                        label: 'Weight',
                                      ),
                                    ),
                                    const DexVerticalDivider(),
                                    Expanded(
                                      child: PokemonAttributes(
                                        icon: Vectors.straighten,
                                        iconColor: DexColors.darkText,
                                        moves: [poke.formattedHeight],
                                        label: 'Height',
                                      ),
                                    ),
                                    const DexVerticalDivider(),
                                    Expanded(
                                      child: PokemonAttributes(
                                        moves: poke.abilities
                                            .take(2)
                                            .map((ability) =>
                                                ability.ability.name)
                                            .toList(),
                                        label: 'Moves',
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(height: DexSpacings.s16),
                              const Text(
                                'There is a plant seed on its back right from the day this Pokémon is born. The seed slowly grows larger.',
                                textAlign: TextAlign.justify,
                              ).body3Regular(color: DexColors.darkText),
                              const SizedBox(height: DexSpacings.s16),
                              Column(
                                children: [
                                  const Text('Base Stats').subtitle1Bold(
                                    color: poke.types.first.color,
                                  ),
                                  const SizedBox(height: DexSpacings.s16),
                                  Table(
                                    columnWidths: const {
                                      0: FlexColumnWidth(),
                                      1: FlexColumnWidth(1),
                                      2: FlexColumnWidth(5),
                                    },
                                    defaultVerticalAlignment:
                                        TableCellVerticalAlignment.middle,
                                    children: [
                                      ...poke.stats.map(
                                        (e) => TableRow(
                                          children: <Widget>[
                                            Container(
                                              decoration: BoxDecoration(
                                                border: Border(
                                                  right: BorderSide(
                                                      width: 1,
                                                      color: Colors.grey[400]!),
                                                ),
                                              ),
                                              child: Padding(
                                                padding: const EdgeInsets.only(
                                                    right: 10),
                                                child: Align(
                                                  alignment:
                                                      Alignment.centerRight,
                                                  child: Text(e.pokeStat.title)
                                                      .subtitle3Bold(
                                                    color:
                                                        poke.types.first.color,
                                                  ),
                                                ),
                                              ),
                                            ),
                                            Center(
                                              child: Text(e.baseStatFormatted)
                                                  .body3Regular(
                                                color: DexColors.darkText,
                                              ),
                                            ),
                                            AnimatedProgressBar(
                                              value:
                                                  e.baseStat?.toDouble() ?? 0,
                                              color: poke.types.first.color!,
                                            )
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        Align(
                          alignment: Alignment.topCenter,
                          child: CachedNetworkImage(
                            imageBuilder: (context, imageProvider) =>
                                Image(image: imageProvider),
                            imageUrl: poke.image,
                            height: 200,
                            width: 200,
                          ),
                        ),
                        Visibility(
                          visible: currentPage > 0,
                          child: Positioned(
                            top: 104,
                            left: DexSpacings.s24,
                            child: InkWell(
                              onTap: previousPokemon,
                              child: const Icon(
                                Icons.chevron_left,
                                color: DexColors.white,
                                size: 24,
                              ),
                            ),
                          ),
                        ),
                        Positioned(
                          top: 104,
                          right: DexSpacings.s24,
                          child: InkWell(
                            onTap: nextPokemon,
                            child: const Icon(
                              Icons.chevron_right,
                              color: DexColors.white,
                              size: 24,
                            ),
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
      },
    );
  }
}
