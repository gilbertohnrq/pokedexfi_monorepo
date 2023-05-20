import 'package:flutter/material.dart';
import 'package:dexfi_ui/dexfi_ui.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pokedexfi/pages/pokes_list/cubit/pokes_list_cubit.dart';
import 'package:pokedexfi/pages/pokes_list/widgets/poke_card.dart';

import '../../core/widgets/loading.dart';
import '../../core/widgets/vector.dart';

class PokesListPage extends StatefulWidget {
  const PokesListPage({Key? key}) : super(key: key);

  @override
  State<PokesListPage> createState() => _PokesListPageState();
}

class _PokesListPageState extends State<PokesListPage> {
  final PokesListCubit cubit = PokesListCubit();

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final orientation = MediaQuery.of(context).orientation;

    return Scaffold(
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
                  SearchBar(
                    onChanged: (value) {
                      print(value);
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
                    leading: const Icon(Icons.search, color: DexColors.primary),
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
                ],
              )
            ],
          ),
        ),
      ),
      body: BlocBuilder<PokesListCubit, PokesListState>(
        bloc: cubit,
        builder: (context, state) {
          if (state is Loading) {
            return const Center(child: LoadingWidget());
          }

          if (state is Loaded) {
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
                      padding: const EdgeInsets.symmetric(
                        horizontal: DexSpacings.s12,
                        vertical: DexSpacings.s24,
                      ),
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        // childAspectRatio: 0.8,
                        crossAxisCount: 3,
                        crossAxisSpacing: DexSpacings.s8,
                        mainAxisSpacing: DexSpacings.s8,
                      ),
                      itemCount: state.pokemons.length,
                      itemBuilder: (context, index) {
                        final pokemon = state.pokemons[index];

                        return PokeCard(pokemon);
                      },
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
                  Text(state.message),
                  ElevatedButton(
                    child: const Text('Retry'),
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
    );
  }
}