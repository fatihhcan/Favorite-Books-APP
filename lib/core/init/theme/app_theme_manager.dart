import 'package:favorite_books_app/core/init/theme/color/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'app_theme.dart';
import 'text_theme/text_theme.dart';

class AppThemeManager extends AppTheme {
  static AppThemeManager? _instance;
  static AppThemeManager get instance {
    return _instance ??= AppThemeManager._init();
  }

  AppThemeManager._init();

  @override
  ThemeData get lightTheme => ThemeData(
      brightness: Brightness.light,
      scaffoldBackgroundColor: LightColors().scaffoldBackgroundColor,
      fontFamily: GoogleFonts.poppins().fontFamily,
      textTheme: TextThemeManager.instance.textTheme(),
      appBarTheme: buildAppBarTheme(LightColors().scaffoldBackgroundColor, LightColors().scaffoldBackgroundColor),
      bottomSheetTheme: BottomSheetThemeData(
        backgroundColor: LightColors().scaffoldBackgroundColor,
      ));

  @override
  ThemeData get darkTheme => ThemeData(
      brightness: Brightness.dark,
      scaffoldBackgroundColor: DarkColors().scaffoldBackgroundColor,
      fontFamily: GoogleFonts.poppins().fontFamily,
      textTheme: TextThemeManager.instance.textTheme(isDark: true),
      appBarTheme: buildAppBarTheme(DarkColors().appBarTextColor, DarkColors().scaffoldBackgroundColor),
      bottomSheetTheme: BottomSheetThemeData(
        backgroundColor: DarkColors().scaffoldBackgroundColor,
      ));

  AppBarTheme buildAppBarTheme(Color textColor, Color backgroundColor) {
    return AppBarTheme(
      centerTitle: true,
      backgroundColor: backgroundColor,
      titleTextStyle: TextStyle(
        color: textColor,
        fontSize: 20,
      ),
      actionsIconTheme: IconThemeData(
        color: textColor,
      ),
      elevation: 0.5,
    );
  }
}
