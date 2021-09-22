import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:pokemon_app/components/pokemon_type.dart';
import 'package:pokemon_app/controllers/pokemon_controller.dart';
import 'package:pokemon_app/model/pokemon.dart';
import 'package:provider/provider.dart';

class PokemonDetail extends StatefulWidget {
  const PokemonDetail({Key? key, required this.pokemon}) : super(key: key);

  final Pokemon pokemon;

  @override
  _PokemonDetail createState() => _PokemonDetail();
}

class _PokemonDetail extends State<PokemonDetail> {
  double imageSize = 200;
  double imageOpacity = 1;

  late ScrollController _scrollController;

  _scrollListener() {
    double imageSize = 200;
    double imageOpacity = 1;
    imageSize = imageSize - _scrollController.offset;
    imageOpacity = imageSize * 0.01;

    if (imageOpacity > 1) imageOpacity = 1;
    if (imageOpacity < 0) imageOpacity = 0;

    setState(() {
      if (imageSize >= 130) {
        this.imageSize = imageSize;
        this.imageOpacity = 1;
      } else {
        this.imageSize = 130;
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

  evolutionItem(BuildContext context, String number) {
    PokemonController pokemonController =
        Provider.of<PokemonController>(context, listen: false);
    Pokemon pokemon = pokemonController.getPokemonByNumber(number);

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
            child: PokemonDetail(pokemon: pokemon),
          ),
        );
      },
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
                padding: EdgeInsets.only(left: 3.0, right: 3.0),
                child: evolutionItem(context, evolution.num),
              ),
            )
            .toList(),
      ),
    );
  }

  body(BuildContext context) {
    return SingleChildScrollView(
      controller: _scrollController,
      child: Stack(
        children: [
          Padding(
            padding: EdgeInsets.only(
                left: 20.0, right: 20.0, top: 90.0, bottom: 20.0),
            child: Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15.0),
              ),
              child: Padding(
                padding: EdgeInsets.all(14.0),
                child: Container(
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Expanded(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            SizedBox(
                              height: 100.0,
                            ),
                            Text(
                              widget.pokemon.name,
                              style: TextStyle(
                                fontSize: 25.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(top: 12.0),
                              child: Text("Height: ${widget.pokemon.height}"),
                            ),
                            Padding(
                              padding: EdgeInsets.only(top: 10.0),
                              child: Text("Weight: ${widget.pokemon.weight}"),
                            ),
                            Padding(
                              padding: EdgeInsets.only(top: 16.0),
                              child: Text(
                                "Types",
                                style: TextStyle(fontWeight: FontWeight.bold),
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
                              padding: EdgeInsets.only(top: 16.0),
                              child: Text(
                                "Weakness",
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(top: 10.0),
                              child: Wrap(
                                alignment: WrapAlignment.center,
                                children: widget.pokemon.weaknesses
                                    .map(
                                      (weakness) => Padding(
                                        padding: EdgeInsets.only(
                                            left: 5.0, right: 5.0),
                                        child: PokemonType(type: weakness),
                                      ),
                                    )
                                    .toList(),
                              ),
                            ),
                            if (widget.pokemon.nextEvolution != null &&
                                widget.pokemon.nextEvolution!.isNotEmpty)
                              Column(children: [
                                Padding(
                                  padding: EdgeInsets.only(top: 16.0),
                                  child: Text(
                                    "Next Evolution",
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                ),
                                nextEvolutions(context)
                              ])
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          Align(
            alignment: Alignment.topCenter,
            child: Container(
              alignment: Alignment.bottomCenter,
              height: 200,
              width: 200,
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
                    ),
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.cyan,
      appBar: AppBar(
        elevation: 0.0,
        title: Text(widget.pokemon.name),
        backgroundColor: Colors.cyan.withOpacity(0.4),
      ),
      body: body(context),
    );
  }
}
