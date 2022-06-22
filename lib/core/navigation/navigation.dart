import 'package:flutter/material.dart';

Future<dynamic> getTo(Widget page, context) => Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => page,
      ),
    );
