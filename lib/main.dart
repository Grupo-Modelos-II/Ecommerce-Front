import 'package:ecommerce/services/productsHandler.dart';
import 'package:flutter/material.dart';
import 'screens/screens.dart';

void main() {
  ProductHandler().getAllProducts();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      home: HomeScreen(),
    );
  }
}
