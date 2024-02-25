import 'package:favorite_books_app/core/init/theme/color/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TextThemeManager {
  static TextThemeManager? _instance;
  static TextThemeManager get instance {
    return _instance ??= TextThemeManager.init();
  }

  TextThemeManager.init();

  TextTheme textTheme({bool isDark = false}) {
    return TextTheme(
      headline1: TextStyle(
        fontSize: 25.sp,
        fontWeight: FontWeight.w700,
        color: isDark ? DarkColors().headLineTextColor : LightColors().headLineTextColor,
      ),
      headline2: TextStyle(
        fontSize: 21,
        color: isDark ? DarkColors().appBarTextColor : LightColors().appBarTextColor,
      ),
      headline3: TextStyle(
        fontSize: 20,
        color: isDark ? DarkColors().appBarTextColor : LightColors().appBarTextColor,
      ),
      headline4: TextStyle(
        fontSize: 20,
        color: isDark ? DarkColors().appBarTextColor : LightColors().appBarTextColor,
      ),
      headline5: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w500,
        color: isDark ? DarkColors().headLineTextColor : LightColors().headLineTextColor,
      ),
      headline6: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w700,
        color: isDark ? DarkColors().appBarTextColor : LightColors().appBarTextColor,
      ),
      overline: TextStyle(
        fontSize: 14,
        color: isDark ? DarkColors().appBarTextColor : LightColors().appBarTextColor,
      ),
      bodyText1: TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w500,
        color: isDark ? DarkColors().appBarTextColor : LightColors().appBarTextColor,
      ),
      bodyText2: TextStyle(
        fontSize: 13,
        color: isDark ? DarkColors().headLineTextColor : LightColors().headLineTextColor,
      ),
      subtitle1: const TextStyle(
        fontSize: 12,
        fontWeight: FontWeight.w600,
      ),
    );
  }
}
