import 'package:flutter/material.dart';
import 'package:pokemon_app/screens/home/pokemon_item.dart';
import 'package:pokemon_app/model/pokemon.dart';

class PokemonList extends StatelessWidget {
  const PokemonList({Key? key, required this.pokemonList}) : super(key: key);

  final List<Pokemon> pokemonList;

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      crossAxisCount: 2,
      children: pokemonList.map((poke) => PokemonItem(pokemon: poke)).toList(),
    );
  }
}
