import 'package:ecommerce/constants/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

String font = 'Roboto';

class Style {
  static TextStyle labelSearch = TextStyle(
    color: Colors.white,
    fontFamily: font,
  );
  static TextStyle footerTitle = TextStyle(
    color: Colors.white,
    fontSize: 22,
    fontWeight: FontWeight.bold,
    fontFamily: font,
  );
  static TextStyle footerBody = TextStyle(
    color: Colors.white,
    fontSize: 16,
    fontFamily: font,
  );

  ///Products Cards
  static TextStyle cardTitle = TextStyle(
    color: Colors.black,
    fontSize: 24,
    fontWeight: FontWeight.bold,
    fontFamily: font,
  );
  static TextStyle productPrice = TextStyle(
    color: Colors.black,
    fontSize: 18,
    fontFamily: font,
  );
  static TextStyle productStatus = TextStyle(
    color: Colors.black,
    fontSize: 10,
    fontFamily: font,
  );

  ///Products Info
  static TextStyle productInfoTitle = TextStyle(
    color: Colors.black,
    fontSize: 22,
    fontWeight: FontWeight.bold,
    fontFamily: font,
  );
  static TextStyle productInfoPrice = TextStyle(
    color: Colors.black,
    fontSize: 22,
    fontFamily: font,
  );
  static TextStyle productInfoText = TextStyle(
    color: Colors.black,
    fontSize: 18,
    fontFamily: font,
  );

  ///Buttons
  static TextStyle btnText = TextStyle(
    color: Colors.white,
    fontSize: 18,
    fontFamily: font,
  );
  static TextStyle btnPurchase = TextStyle(
    color: Colors.white,
    fontSize: 14,
    fontFamily: font,
  );
  static TextStyle btnCart = TextStyle(
    color: Palette.mainColor,
    fontSize: 14,
    fontFamily: font,
  );

  ///Shopping cart
  static TextStyle cartTitle = TextStyle(
    color: Colors.black,
    fontSize: 32,
    fontFamily: font,
  );
  static TextStyle cartResumeItem = TextStyle(
    color: Colors.black,
    fontWeight: FontWeight.bold,
    fontSize: 14,
    fontFamily: font,
  );
  static TextStyle cartItemTitle = TextStyle(
    color: Colors.black,
    fontWeight: FontWeight.bold,
    fontSize: 20,
    fontFamily: font,
  );
  static TextStyle cartItemText = TextStyle(
    color: Colors.black,
    fontSize: 16,
    fontFamily: font,
  );
  static TextStyle cartItemPrice = TextStyle(
    color: Colors.black,
    fontSize: 22,
    fontFamily: font,
  );
}
