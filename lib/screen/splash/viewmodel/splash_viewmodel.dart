import 'package:flutter/material.dart';
import 'package:ron_order/screen/onboarding/onboarding_screen.dart';

class SplashViewmodel {
  Future<dynamic> navigate(BuildContext context) {
    return Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (_) => const OnboardingScreen()),
    );
  }

  Future<void> waitForDelay(context) async {
    await Future.delayed(
      const Duration(milliseconds: 4000),
    );
  }
}
