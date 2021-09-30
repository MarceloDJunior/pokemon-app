import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:pokemon_app/controllers/theme_controller.dart';
import 'package:pokemon_app/controllers/pokemon_controller.dart';
import 'package:pokemon_app/utils/themes.dart';
import 'package:provider/provider.dart';

import 'package:pokemon_app/screens/home/home.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  await runZonedGuarded(
    () async {
      WidgetsFlutterBinding.ensureInitialized();

      // Check if dark mode is enabled in app
      final prefs = await SharedPreferences.getInstance();
      bool isDarkModeSettedByUser = prefs.getBool('isDarkMode') != null;
      bool? isAppDarkMode = prefs.getBool('isDarkMode') == true;

      // Check if device is in dark mode
      Brightness brightness =
          SchedulerBinding.instance!.window.platformBrightness;
      bool isDeviceDarkMode = brightness == Brightness.dark;

      bool isDarkMode =
          isDarkModeSettedByUser ? isAppDarkMode : isDeviceDarkMode;
      runApp(
        MultiProvider(
          providers: [
            ChangeNotifierProvider(
              create: (_) => ThemeController(
                  isDarkMode ? Themes.darkTheme : Themes.lightTheme),
            ),
            ChangeNotifierProvider(create: (_) => PokemonController()),
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
    final ThemeController themeController = Provider.of<ThemeController>(context);
    ThemeData? appTheme = themeController.appTheme;
    return MaterialApp(
      title: "Pokémon App",
      home: Home(),
      debugShowCheckedModeBanner: false,
      theme: appTheme ?? Themes.lightTheme,
    );
  }
}
