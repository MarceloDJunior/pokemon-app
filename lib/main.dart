import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pokemon_app/controllers/pokemon_controller.dart';
import 'package:provider/provider.dart';

import 'package:pokemon_app/screens/home/home.dart';

void main() => runApp(
      MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) => PokemonController()),
        ],
        child: App(),
      ),
    );

class App extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Pokemon App",
      home: Home(),
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        appBarTheme: AppBarTheme(
          backwardsCompatibility: false, // 1
          systemOverlayStyle: SystemUiOverlayStyle.light, // 2
        ),
      ),
    );
  }
}
