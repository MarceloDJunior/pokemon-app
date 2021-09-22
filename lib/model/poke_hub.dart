import 'package:pokemon_app/model/pokemon.dart';

class PokeHub {
  List<Pokemon> pokemon = [];

  PokeHub({required this.pokemon});

  PokeHub.fromJson(Map<String, dynamic> json) {
    if (json['pokemon'] != null) {
      pokemon = [];
      json['pokemon'].forEach((v) {
        pokemon.add(new Pokemon.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['pokemon'] = this.pokemon.map((v) => v.toJson()).toList();
    return data;
  }
}
