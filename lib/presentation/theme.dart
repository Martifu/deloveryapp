import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class DeliveryColors {
  static final purple = Color(0xFF5117AC);
  static final green = Color(0xFF20D0C4);
  static final dark = Color(0xFF03091E);
  static final grey = Color(0xFF212738);
  static final lightGrey = Color(0xFFBBBBBB);
  static final veryLightGrey = Color(0xFFF3F3F3);
  static final white = Color(0xFFFFFFFF);
  static final pink = Color(0xFFF5638B);
}

final deliveryGradiants = [
  DeliveryColors.green,
  DeliveryColors.purple,
];

final _borderLight = OutlineInputBorder(
  borderRadius: BorderRadius.circular(10.0),
  borderSide: BorderSide(
    color: DeliveryColors.veryLightGrey,
    width: 2,
    style: BorderStyle.solid,
  ),
);

final _borderDark = OutlineInputBorder(
  borderRadius: BorderRadius.circular(10.0),
  borderSide: BorderSide(
    color: DeliveryColors.grey,
    width: 2,
    style: BorderStyle.solid,
  ),
);

final lightTheme = ThemeData(
  appBarTheme: AppBarTheme(
    elevation: 0,
    centerTitle: true,
    color: DeliveryColors.white,
    textTheme: GoogleFonts.poppinsTextTheme().copyWith(
      headline6: TextStyle(
        fontSize: 20,
        color: DeliveryColors.purple,
        fontWeight: FontWeight.bold,
      ),
    ),
  ),
  canvasColor: DeliveryColors.white,
  accentColor: DeliveryColors.purple,
  bottomAppBarColor: DeliveryColors.veryLightGrey,
  textTheme: GoogleFonts.poppinsTextTheme().apply(
    bodyColor: DeliveryColors.purple,
    displayColor: DeliveryColors.purple,
  ),
  inputDecorationTheme: InputDecorationTheme(
    labelStyle: TextStyle(color: DeliveryColors.purple),
    contentPadding: EdgeInsets.zero,
    border: _borderLight,
    enabledBorder: _borderLight,
    focusedBorder: _borderLight,
    hintStyle: GoogleFonts.poppins(
      color: DeliveryColors.lightGrey,
      fontSize: 12.0,
    ),
  ),
  iconTheme: IconThemeData(
    color: DeliveryColors.purple,
  ),
);

final darkTheme = ThemeData(
  appBarTheme: AppBarTheme(
    elevation: 0,
    centerTitle: true,
    color: DeliveryColors.purple,
    textTheme: GoogleFonts.poppinsTextTheme().copyWith(
      headline6: TextStyle(
        fontSize: 20,
        color: DeliveryColors.white,
        fontWeight: FontWeight.bold,
      ),
    ),
  ),
  canvasColor: DeliveryColors.grey,
  accentColor: DeliveryColors.white,
  bottomAppBarColor: Colors.transparent,
  scaffoldBackgroundColor: DeliveryColors.dark,
  textTheme: GoogleFonts.poppinsTextTheme().apply(
    bodyColor: DeliveryColors.green,
    displayColor: DeliveryColors.green,
  ),
  inputDecorationTheme: InputDecorationTheme(
    labelStyle: TextStyle(color: DeliveryColors.white),
    contentPadding: EdgeInsets.zero,
    fillColor: DeliveryColors.grey,
    filled: true,
    border: _borderDark,
    enabledBorder: _borderDark,
    focusedBorder: _borderDark,
    hintStyle: GoogleFonts.poppins(
      color: DeliveryColors.white,
      fontSize: 12.0,
    ),
  ),
  iconTheme: IconThemeData(
    color: DeliveryColors.white,
  ),
);
