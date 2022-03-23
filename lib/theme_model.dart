import 'package:flutter/material.dart';

class ThemeModel  {
  late ThemeData theme;

  late Color secondBackgroundColor;
  late Color secondTextColor;

  static const Color _lightBackgroundColor = Colors.white;
  static const Color _lightTextColor = Color(0xFF3E4958);
  static const Color _accentColor = Colors.blue;
  static const MaterialColor swatch =Colors.blue;


  ThemeModel() {

      secondBackgroundColor =const  Color(0xFFF7F8F9);
      secondTextColor =const Color(0xFFD5DDE0);
      theme=ThemeData(
        brightness: Brightness.light,
        floatingActionButtonTheme:
        const FloatingActionButtonThemeData(backgroundColor: _accentColor),

        appBarTheme:const AppBarTheme(
          titleTextStyle: TextStyle(
              fontWeight: FontWeight.w700,
              fontSize: 18,
              color: Colors.white)
        ),
        dialogBackgroundColor: _lightBackgroundColor,
        inputDecorationTheme: const InputDecorationTheme(
          labelStyle: TextStyle(
              height: 1.1,
              fontWeight: FontWeight.w400,
              fontSize: 13,
              color: _lightTextColor),
          hintStyle: TextStyle(
              height: 1.1,
              fontWeight: FontWeight.w400,
              fontSize: 13,
              color: _lightTextColor),
        ),

        textButtonTheme: TextButtonThemeData(
            style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(_accentColor))),
        iconTheme: const IconThemeData(
          color: _lightTextColor,
        ),
        // brightness: Brightness.light,
        shadowColor: const Color(0xFF232323).withOpacity(0.1),
        // primarySwatch: lightSwatch,
        primaryColor: swatch,
        primaryColorDark: swatch,
        toggleableActiveColor: _accentColor,
        backgroundColor: _lightBackgroundColor,
        scaffoldBackgroundColor: _lightBackgroundColor,
        bottomSheetTheme: const BottomSheetThemeData(backgroundColor: Colors.transparent),
        bottomNavigationBarTheme: const BottomNavigationBarThemeData(
            backgroundColor: _lightBackgroundColor,
            selectedItemColor: _lightTextColor,
            unselectedItemColor: Color(0xFFD5DDE0),
            elevation: 0),
        textSelectionTheme: const TextSelectionThemeData(
          cursorColor: _accentColor,
        ),

        textTheme: const TextTheme(
          headline1: TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 22,
              color: _lightTextColor),
          headline2: TextStyle(
              fontWeight: FontWeight.w700,
              fontSize: 18,
              color: _lightTextColor),
          headline3: TextStyle(
              fontWeight: FontWeight.w700,
              fontSize: 16,
              color: _lightTextColor),
          headline4: TextStyle(
              fontWeight: FontWeight.w700,
              fontSize: 14,
              color: _lightTextColor),
          headline5: TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 14,
              color: _lightTextColor),
          headline6: TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 14,
              color: _lightTextColor),
          bodyText1: TextStyle(
              height: 1.1,
              fontWeight: FontWeight.w400,
              fontSize: 13,
              color: _lightTextColor),
          bodyText2: TextStyle(
              height: 1.1,
              fontWeight: FontWeight.w400,
              fontSize: 13,
              color: _lightTextColor),
          subtitle1: TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 12,
              color: _lightTextColor),
          subtitle2: TextStyle(
              fontWeight: FontWeight.w400,
              fontSize: 12,
              color: _lightTextColor),
        ), colorScheme: ColorScheme.fromSwatch().copyWith(secondary: _accentColor),
      );


  }









}