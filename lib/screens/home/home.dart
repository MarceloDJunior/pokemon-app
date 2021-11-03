import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pokemon_app/bloc/pokemon/pokemon_bloc.dart';
import 'package:pokemon_app/bloc/theme/theme_cubit.dart';
import 'package:pokemon_app/components/no_results.dart';
import 'package:provider/provider.dart';
import 'package:pokemon_app/components/app_search_bar.dart';
import 'package:pokemon_app/screens/home/pokemon_list.dart';

class Home extends StatefulWidget {
  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  String filterText = '';

  @override
  void initState() {
    super.initState();
    BlocProvider.of<PokemonBloc>(context).add(GetPokemons());
  }

  @override
  Widget build(BuildContext context) {
    final double toolbarHeight = kToolbarHeight + 110;
    final ThemeCubit themeCubit = context.read<ThemeCubit>();

    return AnnotatedRegion(
      value: themeCubit.isDarkMode()
          ? SystemUiOverlayStyle.light
          : SystemUiOverlayStyle.dark,
      child: Scaffold(
        backgroundColor: Theme.of(context).backgroundColor,
        body: NestedScrollView(
          clipBehavior: Clip.none,
          floatHeaderSlivers: true,
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
            return [
              SliverOverlapAbsorber(
                handle:
                    NestedScrollView.sliverOverlapAbsorberHandleFor(context),
                sliver: SliverAppBar(
                  backgroundColor: Colors.transparent,
                  collapsedHeight: toolbarHeight,
                  expandedHeight: toolbarHeight,
                  flexibleSpace: AppSearchBar(
                      preferredSize: Size.fromHeight(toolbarHeight),
                      onQueryChange: (String text) {
                        BlocProvider.of<PokemonBloc>(context)
                            .add(FilterPokemons(text));
                      }),
                  floating: true,
                  pinned: false,
                  snap: true,
                  elevation: 0,
                ),
              ),
            ];
          },
          body: BlocBuilder(
            builder: (context, state) {
              if (state is PokemonLoaded) {
                return PokemonList(pokemonList: state.pokemonList);
              } else if (state is PokemonLoading) {
                return Center(child: CircularProgressIndicator(color: Theme.of(context).colorScheme.onSurface));
              } else if (state is PokemonError) {
                return NoResults(
                    description: 'No pokémon found matching your search.');
              } else {
                return Center(child: CircularProgressIndicator(color: Theme.of(context).colorScheme.onSurface));
              }
            },
            bloc: BlocProvider.of<PokemonBloc>(context),
          ),
        ),
        floatingActionButton: FloatingActionButton(
          backgroundColor: Theme.of(context).primaryColor,
          splashColor: Theme.of(context).colorScheme.primaryVariant,
          onPressed: () {
            BlocProvider.of<PokemonBloc>(context).add(GetPokemons());
          },
          child: Icon(Icons.refresh,
              color: Theme.of(context).colorScheme.onPrimary),
        ),
      ),
    );
  }
}
