import 'package:flutter/material.dart';
import 'package:pokemon_app/controllers/pokemon_controller.dart';
import 'package:pokemon_app/model/pokemon.dart';
import 'package:pokemon_app/screens/home/pokemon_list.dart';
import 'package:pokemon_app/services/pokemon_service.dart';
import 'package:provider/provider.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  void initState() {
    super.initState();
    getPokemons();
  }

  getPokemons() async {
    List<Pokemon>? pokemonList = await PokemonService.getPokemons();
    Provider.of<PokemonController>(context, listen: false).setPokemonList(pokemonList);
  }

  @override
  Widget build(BuildContext context) {
    final PokemonController pokemonController =
        Provider.of<PokemonController>(context);
    List<Pokemon>? pokemonList = pokemonController.pokemonList;
    return Scaffold(
      appBar: AppBar(
        title: Text("Pokemon App"),
        backgroundColor: Colors.cyan,
      ),
      body: pokemonList == null
          ? Center(child: CircularProgressIndicator())
          : PokemonList(pokemonList: List.from(pokemonList)),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {
            pokemonList = null;
          });
          // set some delay to show spinner while loads
          Future.delayed(Duration(milliseconds: 800), () {
            getPokemons();
          });
        },
        child: Icon(
          Icons.refresh,
        ),
      ),
    );
  }
}
