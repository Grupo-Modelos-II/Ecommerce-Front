import 'package:flutter/material.dart';

Future<String?> modal(BuildContext context,
        {List<Widget>? actions,
        required String title,
        required String content}) =>
    showDialog<String>(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        title: Text(title),
        content: Text(content),
        actions: actions,
      ),
    );