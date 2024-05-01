import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AppTheme {
  static _border([Color color = Colors.grey]) => OutlineInputBorder(
      borderSide: BorderSide(color: color),
      borderRadius: BorderRadius.circular(20));

  static  appThemeModeDark ({required BuildContext context})=> ThemeData.dark(
    useMaterial3: true,
  ).copyWith(
    inputDecorationTheme: InputDecorationTheme(
      contentPadding: const EdgeInsets.all(20),
      enabledBorder: _border(),
      focusedBorder: _border(Colors.green),
    ),
  );
  static final appThemeModeLight = ThemeData.light(
    useMaterial3: true,
  );
}
