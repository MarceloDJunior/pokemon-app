import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pokemon_app/bloc/theme/theme_state.dart';
import 'package:pokemon_app/utils/themes.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeCubit extends Cubit<ThemeState> {
  ThemeData _appTheme = Themes.lightTheme;

  ThemeCubit(ThemeData appTheme) : super(ThemeState(appTheme: appTheme)) {
    this._appTheme = appTheme;
    emit(ThemeState(appTheme: appTheme));
  }

  void setTheme(ThemeData theme) async {
    this._appTheme = theme;

    SharedPreferences _prefs = await SharedPreferences.getInstance();
    _prefs.setBool('isDarkMode', theme == Themes.darkTheme);

    emit(ThemeState(appTheme: theme));
  }

  ThemeData getTheme() {
    return this._appTheme;
  }

  bool isDarkMode() {
    return this._appTheme == Themes.darkTheme;
  }
}
