import 'package:flutter/material.dart';

import '../../auth/screen_login/login_screen.dart';

class SplashViewmodel {
  Future<dynamic> navigate(BuildContext context) {
    return Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (_) => const LoginScreen()),
    );
  }

  Future<void> waitForDelay(context) async {
    await Future.delayed(
      const Duration(milliseconds: 2000),
    );
  }
}
