import 'package:flutter/foundation.dart';
import 'package:pokemon_app/model/pokemon.dart';

class PokemonController extends ChangeNotifier {
  List<Pokemon>? pokemonList;

  void setPokemonList(List<Pokemon> pokemonList) {
    this.pokemonList = pokemonList;
    notifyListeners();
  }

  Pokemon getPokemonByNumber(String number) {
    Pokemon pokemon = this.pokemonList!.where((element) => element.num == number).first;
    return pokemon;
  }
}
