import 'package:flutter/material.dart';

// Future<dynamic> getTo(Widget page, context) => Navigator.push(
//       context,
//       MaterialPageRoute(
//         builder: (context) => page,
//       ),
//     );

Future<dynamic> getToRemove(Widget page, context) =>
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(
        builder: (context) => page,
      ),
      (route) => false,
    );

Future<dynamic> getBack(Widget page, context) => Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(
        builder: (context) => page,
      ),
      (route) => false,
    );

Future<dynamic> getTo(Widget page, context) => Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => page,
      ),
    );
