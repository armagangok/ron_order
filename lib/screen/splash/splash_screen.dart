import 'package:flutter/material.dart';

import '../../core/extension/context_extension.dart';
import '../auth/screen_login/login_screen.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    _waitForDelay(context).whenComplete(() => navigate(context));
    return Scaffold(
      body: SizedBox(
        height: context.getHeight(1),
        width: double.infinity,
        child: Image.asset(
          "assets/img/image.png",
          fit: BoxFit.fill,
        ),
      ),
    );
  }

  Future<dynamic> navigate(BuildContext context) {
    return Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (_) => const LoginScreen()),
    );
  }

  Future<void> _waitForDelay(context) async {
    await Future.delayed(
      const Duration(milliseconds: 2000),
    );
  }
}
