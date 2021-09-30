import 'package:flutter/foundation.dart';
import 'package:pokemon_app/model/pokemon.dart';

class PokemonController extends ChangeNotifier {
  List<Pokemon>? pokemonList;
  List<Pokemon>? filteredList;
  String filterText = '';

  void setPokemonList(List<Pokemon>? pokemonList) {
    this.pokemonList = pokemonList;
    filterList(pokemonList);
  }

  void setFilterText(String text) {
    this.filterText = text;
    filterList(this.pokemonList);
  }

  void filterList(List<Pokemon>? pokemonList) {
    this.filteredList = pokemonList
            ?.where((pokemon) => pokemon.name
                .toLowerCase()
                .contains(this.filterText.toLowerCase().trim()))
            .toList() ??
        null;

    notifyListeners();
  }

  Pokemon? getPokemonByNumber(String number) {
    if (pokemonList != null) {
      Pokemon pokemon =
          this.pokemonList!.where((element) => element.num == number).first;
      return pokemon;
    }
    return null;
  }
}
