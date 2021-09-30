import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pokemon_app/controllers/theme_controller.dart';
import 'package:provider/provider.dart';
import 'package:pokemon_app/components/app_search_bar.dart';
import 'package:pokemon_app/controllers/pokemon_controller.dart';
import 'package:pokemon_app/model/pokemon.dart';
import 'package:pokemon_app/screens/home/pokemon_list.dart';
import 'package:pokemon_app/services/pokemon_service.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final double toolbarHeight = kToolbarHeight + 110;

  @override
  void initState() {
    super.initState();
    getPokemons();
  }

  getPokemons() async {
    final PokemonController pokemonController =
        Provider.of<PokemonController>(context, listen: false);

    await Future.delayed(Duration(milliseconds: 400));

    List<Pokemon>? pokemonList = await PokemonService.getPokemons();
    pokemonController.setPokemonList(pokemonList);
  }

  reloadPokemons() {
    final PokemonController pokemonController =
        Provider.of<PokemonController>(context, listen: false);
    pokemonController.setPokemonList(null);

    getPokemons();
  }

  @override
  Widget build(BuildContext context) {
    final ThemeController themeController = Provider.of<ThemeController>(context);
    final PokemonController pokemonController =
        Provider.of<PokemonController>(context);
    List<Pokemon>? pokemonList = pokemonController.filteredList;

    return AnnotatedRegion(
      value: themeController.isDarkMode()
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
                        pokemonController.setFilterText(text);
                      }),
                  floating: false,
                  pinned: false,
                ),
              ),
            ];
          },
          body: pokemonList == null
              ? Center(child: CircularProgressIndicator())
              : PokemonList(pokemonList: List.from(pokemonList)),
        ),
        floatingActionButton: FloatingActionButton(
          backgroundColor: Theme.of(context).primaryColor,
          onPressed: () {
            reloadPokemons();
          },
          child: Icon(Icons.refresh, color: Theme.of(context).buttonColor),
        ),
      ),
    );
  }
}
