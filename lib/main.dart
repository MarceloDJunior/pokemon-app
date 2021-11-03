import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pokemon_app/bloc/pokemon/pokemon_bloc.dart';
import 'package:pokemon_app/bloc/theme/theme_cubit.dart';
import 'package:pokemon_app/bloc/theme/theme_state.dart';
import 'package:pokemon_app/repositories/pokemon_repository.dart';
import 'package:pokemon_app/utils/themes.dart';

import 'package:pokemon_app/screens/home/home.dart';

void main() async {
  await runZonedGuarded(
    () async {
      WidgetsFlutterBinding.ensureInitialized();
      bool isDarkMode = await Themes.isDarkMode();
      runApp(
        MultiBlocProvider(
          providers: [
            BlocProvider<ThemeCubit>(
                create: (context) => ThemeCubit(
                    isDarkMode ? Themes.darkTheme : Themes.lightTheme)),
            BlocProvider<PokemonBloc>(
                create: (context) => PokemonBloc(PokemonRepository())),
          ],
          child: App(),
        ),
      );
    },
    (error, st) => print(error),
  );
}

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeCubit, ThemeState>(
      builder: (context, ThemeState state) {
        return MaterialApp(
          title: "Pokémon App",
          home: Home(),
          debugShowCheckedModeBanner: false,
          theme: state.appTheme,
        );
      },
    );
  }
}
