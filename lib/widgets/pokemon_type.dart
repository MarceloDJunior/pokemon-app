import 'package:flutter/material.dart';
import 'package:pokemon_app/model/type_enum.dart';
import 'package:pokemon_app/utils/constants.dart';

enum TypeSize { small, medium }

class PokemonType extends StatelessWidget {
  const PokemonType({Key? key, required this.type, this.size = TypeSize.medium})
      : super(key: key);

  final String type;
  final TypeSize size;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: size == TypeSize.small ? 3 : 5),
      child: FilterChip(
        backgroundColor: Color(typesColors[type] ?? 0xFFA7A877),
        visualDensity: size == TypeSize.small
            ? VisualDensity(horizontal: 0.0, vertical: -4)
            : null,
        labelPadding: size == TypeSize.small
            ? EdgeInsets.symmetric(horizontal: 4, vertical: -2)
            : null,
        padding: size == TypeSize.small
            ? EdgeInsets.symmetric(vertical: 0, horizontal: 4)
            : null,
        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
        label: Container(
          width: size == TypeSize.medium ? 46 : 32,
          child: Text(
            type,
            style: TextStyle(
              color: type == TypeEnum.electric.name || type == TypeEnum.ice.name
                  ? Colors.black
                  : Theme.of(context).textTheme.bodyText2?.color,
              fontSize: size == TypeSize.medium ? 12.0 : 8.0,
            ),
          ),
          alignment: Alignment.center,
        ),
        onSelected: (_) {},
      ),
    );
  }
}
