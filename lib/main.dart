import 'package:ecommerce/models/providers/ProductList.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'screens/screens.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => ProductCart(),
        )
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Ecommerce',
      routes: {
        '/': (BuildContext context) => HomeScreen(),
        '/register': (BuildContext context) => SignUp(),
        '/product': (BuildContext context) => ProductScreen(),
        '/cart': (BuildContext context) => CartScreen(),
        '/history': (BuildContext context) => HistoryScreen(),
      },
    );
  }
}
