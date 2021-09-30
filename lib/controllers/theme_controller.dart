import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:pokemon_app/utils/themes.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeController extends ChangeNotifier {
  ThemeData? appTheme;

  ThemeController(ThemeData appTheme) {
    this.appTheme = appTheme;
  }

  void setTheme(ThemeData? theme) async {
    this.appTheme = theme;

    SharedPreferences _prefs = await SharedPreferences.getInstance();
    _prefs.setBool('isDarkMode', theme == Themes.darkTheme);

    notifyListeners();
  }

  bool isDarkMode() {
    return this.appTheme == Themes.darkTheme;
  }
}
