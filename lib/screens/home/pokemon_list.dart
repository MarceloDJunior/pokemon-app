import 'package:flutter/material.dart';
import 'package:pokemon_app/components/no_results.dart';
import 'package:pokemon_app/screens/home/pokemon_item.dart';
import 'package:pokemon_app/model/pokemon.dart';

class PokemonList extends StatelessWidget {
  const PokemonList({Key? key, required this.pokemonList}) : super(key: key);

  final List<Pokemon> pokemonList;

  static double mainAxisSpacing = 2;
  static double crossAxisSpacing = 2;
  static double childAspectRatio = 1.25;
  static int crossAxisCount = 2;

  @override
  Widget build(BuildContext context) {
    if (pokemonList.length == 0) {
      return NoResults(description: 'No pokémon found matching your search.');
    }

    return GridView.count(
      padding: EdgeInsets.all(12),
      crossAxisCount: crossAxisCount,
      children:
          pokemonList.map((pokemon) => PokemonItem(pokemon: pokemon)).toList(),
      mainAxisSpacing: mainAxisSpacing,
      crossAxisSpacing: crossAxisSpacing,
      childAspectRatio: childAspectRatio,
    );
  }
}
