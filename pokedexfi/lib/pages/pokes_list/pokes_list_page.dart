import 'package:dexfi_ui/dexfi_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pokedexfi/core/routes/app_router.dart';
import 'package:pokedexfi/pages/details/args/poke_details_args.dart';
import 'package:pokedexfi/pages/pokes_list/cubit/pokes_list_cubit.dart';
import 'package:pokedexfi/pages/pokes_list/widgets/poke_card.dart';

import '../../core/domain/models/pokemon/poke_model.dart';
import '../../core/helpers/debouncer.dart';
import '../../core/widgets/loading.dart';
import '../../core/widgets/vector.dart';

class PokesListPage extends StatefulWidget {
  const PokesListPage({Key? key}) : super(key: key);

  @override
  State<PokesListPage> createState() => _PokesListPageState();
}

class _PokesListPageState extends State<PokesListPage> {
  final PokesListCubit cubit = PokesListCubit();
  final _scrollController = ScrollController();
  final _searchController = TextEditingController();
  final _debouncer = Debounce();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(() {
      if (_scrollController.position.pixels >
              _scrollController.position.maxScrollExtent * 0.7 &&
          _scrollController.position.userScrollDirection ==
              ScrollDirection.reverse) {
        cubit.fetchMorePokemons();
      }
    });

    _searchController.addListener(() {
      _debouncer.run(() {
        final searchTerm = _searchController.text.trim();
        if (searchTerm.isEmpty) {
          cubit.getPokemons();
        } else {
          cubit.searchPokemonByName(searchTerm);
        }
      });
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final orientation = MediaQuery.of(context).orientation;

    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        backgroundColor: DexColors.primary,
        appBar: DexAppBar(
          color: DexColors.primary,
          title: Padding(
            padding: const EdgeInsets.fromLTRB(
              DexSpacings.s16,
              DexSpacings.s16,
              DexSpacings.s16,
              DexSpacings.s0,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  children: [
                    const Vector(Vectors.pokeball,
                        size: 24, color: DexColors.white),
                    const SizedBox(width: DexSpacings.s16),
                    const Text('Pokédex').headlineBold(
                      style: const TextStyle(color: DexColors.white),
                    ),
                  ],
                ),
                const SizedBox(height: DexSpacings.s8),
                Row(
                  children: [
                    Flexible(
                      flex: 6,
                      child: SearchBar(
                        controller: _searchController,
                        trailing: [
                          if (_searchController.text.isNotEmpty)
                            IconButton(
                              onPressed: () {
                                _searchController.clear();
                                cubit.getPokemons();
                              },
                              icon: const Icon(
                                Icons.close,
                                color: DexColors.primary,
                              ),
                            )
                        ],
                        onChanged: (value) {
                          _debouncer.run(() {
                            final searchTerm = value.trim();
                            if (searchTerm.isEmpty) {
                              cubit.getPokemons();
                            } else {
                              cubit.searchPokemonByName(searchTerm);
                            }
                          });
                        },
                        padding: const MaterialStatePropertyAll(
                          EdgeInsets.only(
                            bottom: DexSpacings.s2,
                            left: DexSpacings.s12,
                          ),
                        ),
                        textStyle: MaterialStateProperty.all(
                          const Text('').body3Regular().style,
                        ),
                        leading:
                            const Icon(Icons.search, color: DexColors.primary),
                        constraints: BoxConstraints(
                          maxHeight: orientation == Orientation.portrait
                              ? size.height * 0.05
                              : size.height * 0.1,
                          maxWidth: size.width * 0.7778,
                        ),
                        backgroundColor:
                            const MaterialStatePropertyAll(DexColors.white),
                        hintText: 'Search',
                        hintStyle: MaterialStateProperty.all(
                          const Text('').body3Regular().style,
                        ),
                      ),
                    ),
                    const SizedBox(width: DexSpacings.s8),
                    Flexible(
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          shape: const CircleBorder(),
                          backgroundColor: DexColors.white,
                        ),
                        onPressed: () {},
                        child: const Text('#').body2Regular(
                          style: const TextStyle(color: DexColors.primary),
                        ),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
        body: BlocBuilder<PokesListCubit, PokesListState>(
          bloc: cubit,
          builder: (context, state) {
            if (state is Initial || state is Loading) {
              return const Center(child: LoadingWidget());
            }

            if (state is LoadingMore || state is Loaded) {
              List<Poke> pokemons = state is LoadingMore
                  ? state.pokemons
                  : (state as Loaded).pokemons;
              return RefreshIndicator.adaptive(
                backgroundColor: DexColors.white,
                color: DexColors.primary,
                onRefresh: () async => await cubit.getPokemons(),
                child: Padding(
                  padding: const EdgeInsets.all(DexSpacings.s4),
                  child: Stack(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          boxShadow: DexElevation.innerShadow1,
                          borderRadius: BorderRadius.circular(DexRadius.r8),
                          color: DexColors.white,
                        ),
                      ),
                      GridView.builder(
                        controller: _scrollController,
                        physics: const BouncingScrollPhysics(),
                        padding: EdgeInsets.only(
                          left: DexSpacings.s12,
                          right: DexSpacings.s12,
                          top: DexSpacings.s24,
                          bottom: state is LoadingMore
                              ? DexSpacings.s56
                              : DexSpacings.s24,
                        ),
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 3,
                          crossAxisSpacing: DexSpacings.s8,
                          mainAxisSpacing: DexSpacings.s8,
                        ),
                        itemCount: pokemons.length,
                        itemBuilder: (context, index) {
                          final pokemon = pokemons[index];

                          return PokeCard(
                            pokemon,
                            onTap: () {
                              Navigator.of(context).pushNamed(
                                Routes.detailsPage.route,
                                arguments: PokeDetailsArgs(
                                  listPokes: pokemons,
                                  index: index,
                                ),
                              );
                            },
                          );
                        },
                      ),
                      if (state is LoadingMore)
                        const Positioned.fill(
                          bottom: DexSpacings.s8,
                          child: Align(
                            alignment: Alignment.bottomCenter,
                            child: Padding(
                              padding: EdgeInsets.only(top: DexSpacings.s72),
                              child: LoadingWidget(
                                size: 32,
                                color: DexColors.primary,
                              ),
                            ),
                          ),
                        ),
                    ],
                  ),
                ),
              );
            }

            if (state is Error) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    const Text('Something went wrong!')
                        .headlineBold(color: DexColors.white),
                    const SizedBox(height: DexSpacings.s16),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        foregroundColor: DexColors.primary,
                        backgroundColor: DexColors.white,
                        textStyle: const Text('')
                            .body1Regular(color: DexColors.white)
                            .style,
                      ),
                      child: const Text('Try Again'),
                      onPressed: () {
                        cubit.getPokemons();
                      },
                    ),
                  ],
                ),
              );
            }

            return const Center(child: Text('Empty'));
          },
        ),
      ),
    );
  }
}
