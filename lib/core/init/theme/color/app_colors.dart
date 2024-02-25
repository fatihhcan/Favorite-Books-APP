import 'package:favorite_books_app/core/extensions/string_extensions.dart';
import 'package:flutter/material.dart';

abstract class AppColors {
  //Unique Colors
  Color mirage = '1a252b'.color;
  Color shark = '1C1C1D'.color;
  Color white = 'FFFFFF'.color;
  Color dodgerBlue = '1F95F2'.color;
  Color violetRed = 'F33582'.color;

  //Overrided Colors
  late Color scaffoldBackgroundColor;
}

class LightColors extends AppColors {
  @override
  Color get scaffoldBackgroundColor => mirage;
  Color get headLineTextColor => white;
  Color get appBarTextColor => white;
}

class DarkColors extends AppColors {
  @override
  Color get scaffoldBackgroundColor => mirage;
  Color get headLineTextColor => white;
  Color get appBarTextColor => white;
}
