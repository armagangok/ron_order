import 'package:flutter/material.dart';
import 'package:ron_order/core/navigation/navigation.dart';
import 'package:ron_order/screen/onboarding/onboarding_screen.dart';
import 'package:ron_order/screen/root/root_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashController {
  Future<void> waitForDelay(context) async {
    await Future.delayed(
      const Duration(milliseconds: 1800),
    );
  }

  //

  Future waitAndNavigate(BuildContext context) async {
    SharedPreferences.getInstance().then((instance) {
      instance.getInt("atFirstRun") == null
          ? {
              print(instance.getInt("atFirstRun")),
              instance.setInt("atFirstRun", 1).whenComplete(
                    () => waitForDelay(context).whenComplete(
                      () => getToRemove(const OnboardingScreen(), context),
                    ),
                  ),
              print(instance.getInt("atFirstRun")),
            }
          : {
              waitForDelay(context).whenComplete(
                () => getToRemove(const RootScreen(), context),
              ),
            };
    });
  }
}
