import 'package:ecommerce/constants/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Style {
  static TextStyle labelSearch = TextStyle(color: Colors.white);
  static TextStyle footerTitle =
      TextStyle(color: Colors.white, fontSize: 22, fontWeight: FontWeight.bold);
  static TextStyle footerBody = TextStyle(color: Colors.white, fontSize: 16);

  ///Products Cards
  static TextStyle cardTitle =
      TextStyle(color: Colors.black, fontSize: 24, fontWeight: FontWeight.bold);
  static TextStyle productPrice = TextStyle(color: Colors.black, fontSize: 18);
  static TextStyle productStatus = TextStyle(color: Colors.black, fontSize: 10);

  ///Products Info
  static TextStyle productInfoTitle =
      TextStyle(color: Colors.black, fontSize: 22, fontWeight: FontWeight.bold);
  static TextStyle productInfoPrice =
      TextStyle(color: Colors.black, fontSize: 22);
  static TextStyle productInfoText =
      TextStyle(color: Colors.black, fontSize: 18);

  ///Buttons
  static TextStyle btnText = TextStyle(color: Colors.white, fontSize: 18);
  static TextStyle btnPurchase = TextStyle(color: Colors.white, fontSize: 14);
  static TextStyle btnCart = TextStyle(color: Palette.mainColor, fontSize: 14);
}
