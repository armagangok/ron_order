import 'package:flutter/material.dart';
import 'package:ron_order/screen/onboarding/onboarding_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../core/navigation/navigation.dart';
import '../../root/root_screen.dart';

class SplashViewmodel {
  Future<void> waitForDelay(context) async {
    await Future.delayed(
      const Duration(milliseconds: 1800),
    );
  }

  //

  void waitAndNavigate(BuildContext context) {
    SharedPreferences.getInstance().then((value) {
      (value.getInt("firstRun") == null)
          ? {
              value.setInt("firstRun", 1).whenComplete(
                    () => waitForDelay(context).whenComplete(
                      () => getTo(const OnboardingScreen(), context),
                    ),
                  )
            }
          : {
              waitForDelay(context).whenComplete(
                () => getTo(const RootScreen(), context),
              )
            };
    });
  }
}
