import 'dart:convert';

import 'package:flutter/services.dart' show rootBundle;
import 'package:pokemon_app/model/poke_hub.dart';
import 'package:pokemon_app/model/pokemon.dart';

class PokemonRepository {
  
  PokemonRepository();

  Future<List<Pokemon>> getPokemons() async {
    String json = await rootBundle.loadString('db/data.json');
    Map<String, dynamic> decodedJson = jsonDecode(json);

    return PokeHub.fromJson(decodedJson).pokemon;
  }
}
