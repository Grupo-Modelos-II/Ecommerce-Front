import 'package:ecommerce/screens/footer.dart';
import 'package:flutter/material.dart';

import '../header.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Header(),
          Container(
            color: Color(0xFFF8F8F8),
            child: Padding(
                padding: const EdgeInsets.all(30.0),
                child: Text('sdadjansjkfajsfns')),
          ),
          Footer(),
        ],
      ),
    );
  }
}
