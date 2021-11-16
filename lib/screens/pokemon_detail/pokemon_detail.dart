import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:page_transition/page_transition.dart';
import 'package:pokemon_app/bloc/pokemon/pokemon_bloc.dart';
import 'package:pokemon_app/bloc/theme/theme_cubit.dart';
import 'package:pokemon_app/widgets/pokemon_type.dart';
import 'package:pokemon_app/model/pokemon.dart';
import 'package:pokemon_app/utils/constants.dart';

class PokemonDetail extends StatefulWidget {
  const PokemonDetail({Key? key, required this.pokemon}) : super(key: key);

  final Pokemon pokemon;

  @override
  _PokemonDetail createState() => _PokemonDetail();
}

class _PokemonDetail extends State<PokemonDetail> {
  double imageSize = 220;
  double imageOpacity = 1;

  late ScrollController _scrollController;

  _scrollListener() {
    double imageSize = 220;
    double imageOpacity = 1;
    imageSize = imageSize * 1.3 - _scrollController.offset;
    imageOpacity = imageSize * 0.01;

    if (imageOpacity > 1) imageOpacity = 1;
    if (imageOpacity < 0) imageOpacity = 0;

    setState(() {
      if (imageSize >= 150) {
        if (imageSize > 220) {
          this.imageSize = 220;
        } else {
          this.imageSize = imageSize;
        }
        this.imageOpacity = 1;
      } else {
        this.imageSize = 150;
        this.imageOpacity = imageOpacity;
      }
    });
  }

  @override
  void initState() {
    _scrollController = ScrollController();
    _scrollController.addListener(_scrollListener);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    late Color backgroundColor;
    final ThemeCubit themeCubit = context.read<ThemeCubit>();

    if (themeCubit.isDarkMode()) {
      backgroundColor = Theme.of(context).primaryColor;
    } else {
      backgroundColor =
          Color(typesColors[widget.pokemon.type.first] ?? 0xFFA7A877);
    }

    return WillPopScope(
      onWillPop: () async {
        Navigator.popUntil(context, (route) => route.isFirst);
        return false;
      },
      child: Scaffold(
        backgroundColor: backgroundColor,
        appBar: AppBar(
          elevation: 0.0,
          backgroundColor: backgroundColor,
        ),
        body: body(context),
      ),
    );
  }

  body(BuildContext context) {
    return CustomScrollView(
      controller: _scrollController,
      slivers: [
        SliverFillRemaining(
          hasScrollBody: false,
          child: Stack(
            children: [
              Container(
                child: Padding(
                  padding: EdgeInsets.only(top: 180.0),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Theme.of(context).cardColor,
                      borderRadius: BorderRadius.only(
                        topRight: Radius.circular(50),
                        topLeft: Radius.circular(50),
                      ),
                    ),
                    child: Padding(
                      padding: EdgeInsets.all(16.0),
                      child: Container(
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Expanded(
                              child: Column(
                                children: [
                                  SizedBox(
                                    height: 110.0,
                                  ),
                                  Text(
                                      "${widget.pokemon.name} #${widget.pokemon.num}",
                                      style: Theme.of(context)
                                          .textTheme
                                          .headline2),
                                  Padding(
                                    padding: EdgeInsets.only(top: 20.0),
                                    child: Text(
                                      "Height: ${widget.pokemon.height}",
                                      style:
                                          Theme.of(context).textTheme.bodyText1,
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(top: 10.0),
                                    child: Text(
                                      "Weight: ${widget.pokemon.weight}",
                                      style:
                                          Theme.of(context).textTheme.bodyText1,
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(top: 20.0),
                                    child: Text(
                                      "Types",
                                      style:
                                          Theme.of(context).textTheme.subtitle2,
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(top: 10.0),
                                    child: Wrap(
                                      alignment: WrapAlignment.center,
                                      children: widget.pokemon.type
                                          .map(
                                            (type) => Padding(
                                              padding: EdgeInsets.only(
                                                  left: 5.0, right: 5.0),
                                              child: PokemonType(type: type),
                                            ),
                                          )
                                          .toList(),
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(top: 20.0),
                                    child: Text(
                                      "Weakness",
                                      style:
                                          Theme.of(context).textTheme.subtitle2,
                                    ),
                                  ),
                                  Padding(
                                    padding:
                                        EdgeInsets.only(top: 10.0, bottom: 4.0),
                                    child: Wrap(
                                      alignment: WrapAlignment.center,
                                      children: widget.pokemon.weaknesses
                                          .map(
                                            (weakness) => Padding(
                                              padding: EdgeInsets.only(
                                                  left: 5.0, right: 5.0),
                                              child:
                                                  PokemonType(type: weakness),
                                            ),
                                          )
                                          .toList(),
                                    ),
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      if ((widget.pokemon.prevEvolution !=
                                              null &&
                                          widget.pokemon.prevEvolution!
                                              .isNotEmpty))
                                        Column(children: [
                                          Padding(
                                            padding: EdgeInsets.only(top: 16.0),
                                            child: Text(
                                              "Prev. Evolution",
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .subtitle2,
                                            ),
                                          ),
                                          prevEvolutions(context)
                                        ]),
                                      if ((widget.pokemon.nextEvolution !=
                                              null &&
                                          widget.pokemon.nextEvolution!
                                              .isNotEmpty))
                                        Column(children: [
                                          Padding(
                                            padding: EdgeInsets.only(top: 16.0),
                                            child: Text(
                                              "Next Evolution",
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .subtitle2,
                                            ),
                                          ),
                                          nextEvolutions(context)
                                        ])
                                    ],
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              pokemonPicture(context)
            ],
          ),
        ),
      ],
    );
  }

  pokemonPicture(BuildContext context) {
    return Align(
      alignment: Alignment.topCenter,
      child: Container(
        alignment: Alignment.bottomCenter,
        height: 290,
        width: 290,
        child: Container(
          height: imageSize,
          width: imageSize,
          child: Hero(
            tag: widget.pokemon.img,
            child: Opacity(
              opacity: imageOpacity,
              child: CachedNetworkImage(
                imageUrl: widget.pokemon.img,
                imageBuilder: (context, imageProvider) => Container(
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: imageProvider,
                    ),
                  ),
                ),
                placeholder: (context, url) => Container(
                  height: imageSize,
                  width: imageSize,
                  child: Center(
                    heightFactor: 1.8,
                    widthFactor: 1.8,
                    child: CircularProgressIndicator(
                      color: Theme.of(context).indicatorColor,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  prevEvolutions(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 10.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: widget.pokemon.prevEvolution!
            .map(
              (evolution) => Padding(
                padding: EdgeInsets.only(left: 3.0, right: 3.0),
                child: evolutionItem(context, evolution.num),
              ),
            )
            .toList(),
      ),
    );
  }

  nextEvolutions(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 10.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: widget.pokemon.nextEvolution!
            .map(
              (evolution) => Padding(
                padding: EdgeInsets.only(left: 4.0, right: 4.0),
                child: evolutionItem(context, evolution.num),
              ),
            )
            .toList(),
      ),
    );
  }

  evolutionItem(BuildContext context, String number) {
    Pokemon? pokemon = BlocProvider.of<PokemonBloc>(context).getPokemonByNumber(number);

    if (pokemon == null) {
      return null;
    }

    return InkWell(
      child: Container(
        child: Hero(
          tag: pokemon.img,
          child: CachedNetworkImage(
            imageUrl: pokemon.img,
            imageBuilder: (context, imageProvider) => Container(
              height: 80,
              width: 60,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: imageProvider,
                ),
              ),
            ),
          ),
        ),
        alignment: Alignment.center,
      ),
      onTap: () {
        Navigator.push(
          context,
          PageTransition(
            type: PageTransitionType.fade,
            duration: Duration(milliseconds: 200),
            reverseDuration: Duration(milliseconds: 200),
            child: PokemonDetail(pokemon: pokemon),
          ),
        );
      },
    );
  }
}
