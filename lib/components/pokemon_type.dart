import 'package:flutter/material.dart';
import 'package:pokemon_app/model/type_enum.dart';

final Map<String, int> colors = {
  TypeEnum.normal.name: 0xFFA7A877,
  TypeEnum.fire.name: 0xFFEF8130,
  TypeEnum.fighting.name: 0xFFC03028,
  TypeEnum.water.name: 0xFF6790EF,
  TypeEnum.flying.name: 0xFFA791F0,
  TypeEnum.grass.name: 0xFF78C850,
  TypeEnum.poison.name: 0xFFA0409F,
  TypeEnum.electric.name: 0xFFF8CF31,
  TypeEnum.ground.name: 0xFFE1BF68,
  TypeEnum.psychic.name: 0xFFF85887,
  TypeEnum.rock.name: 0xFFB89F39,
  TypeEnum.ice.name: 0xFF99D7D8,
  TypeEnum.bug.name: 0xFFA9B721,
  TypeEnum.dragon.name: 0xFF7138F8,
  TypeEnum.ghost.name: 0xFF705898,
  TypeEnum.dark.name: 0xFF705848,
  TypeEnum.steel.name: 0xFFB8B7D0,
  TypeEnum.fairy.name: 0xFFEE99AC,
};

class PokemonType extends StatelessWidget {
  const PokemonType({Key? key, required this.type}) : super(key: key);

  final String type;

  @override
  Widget build(BuildContext context) {
    return FilterChip(
      backgroundColor: Color(colors[type] ?? 0xFFA7A877),
      label: Container(
        width: 46,
        child: Text(
          type,
          style: TextStyle(
            color: Colors.white,
            fontSize: 12.0,
          ),
        ),
        alignment: Alignment.center,
      ),
      onSelected: (b) {},
    );
  }
}
