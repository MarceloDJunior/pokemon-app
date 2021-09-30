import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:pokemon_app/components/pokemon_type.dart';
import 'package:pokemon_app/model/pokemon.dart';
import 'package:pokemon_app/screens/home/pokemon_list.dart';
import 'package:pokemon_app/screens/pokemon_detail/pokemon_detail.dart';

class PokemonItem extends StatelessWidget {
  const PokemonItem({Key? key, required this.pokemon}) : super(key: key);

  final Pokemon pokemon;

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double itemWidth = (screenWidth -
            ((PokemonList.crossAxisCount - 1) * PokemonList.crossAxisSpacing)) /
        PokemonList.crossAxisCount;
    double itemHeight = itemWidth / PokemonList.childAspectRatio;
    double imageSize = itemHeight / 2;

    return Padding(
      padding: EdgeInsets.all(2.0),
      child: InkWell(
        onTap: () {
          Navigator.push(
            context,
            PageTransition(
              type: PageTransitionType.fade,
              child: PokemonDetail(pokemon: pokemon),
            ),
          );
        },
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          elevation: 2.0,
          child: Padding(
            padding: EdgeInsets.only(top: 14, left: 14, right: 14, bottom: 10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      height: 20.0,
                      child: Text(pokemon.name,
                          textAlign: TextAlign.left,
                          style: Theme.of(context).textTheme.headline6),
                    ),
                    Container(
                      alignment: Alignment.center,
                      child: Text(
                        '#${pokemon.num}',
                        textAlign: TextAlign.right,
                        style: TextStyle(
                          color: Theme.of(context).textTheme.bodyText1!.color,
                          fontWeight: FontWeight.w500,
                          fontSize: 10,
                        ),
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: EdgeInsets.only(top: 6.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Column(
                        children: pokemon.type
                            .map(
                              (type) =>
                                  PokemonType(type: type, size: TypeSize.small),
                            )
                            .toList(),
                      ),
                      Hero(
                        tag: pokemon.img,
                        child: CachedNetworkImage(
                          imageUrl: pokemon.img,
                          imageBuilder: (context, imageProvider) => Container(
                            height: imageSize,
                            width: imageSize,
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                image: imageProvider,
                              ),
                            ),
                          ),
                          placeholder: (context, url) => Container(
                            height: imageSize,
                            width: imageSize,
                            child: Padding(
                              padding: EdgeInsets.all(32.0),
                              child: CircularProgressIndicator(
                                color: Theme.of(context).indicatorColor,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
