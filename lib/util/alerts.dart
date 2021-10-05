import 'package:flutter/material.dart';

Future<String?> modal(BuildContext context,
        {List<Widget>? actions,
        required String title,
        required Widget content}) =>
    showDialog<String>(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        title: Text(title),
        content: content,
        actions: actions,
      ),
    );