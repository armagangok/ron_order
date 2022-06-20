import 'package:flutter/material.dart';
import 'package:ron_order/core/navigation/navigation.dart';
import 'package:ron_order/screen/auth/screen_login/login_screen.dart';
import 'package:ron_order/screen/splash/viewmodel/splash_viewmodel.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../core/extension/context_extension.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    checkFirstRun(context);

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

  checkFirstRun(
    BuildContext context,
  ) {
    final SplashViewmodel splashViewmodel = SplashViewmodel();
    SharedPreferences.getInstance().then((value) {
      (value.getInt("firstRun") == null)
          ? {
              SharedPreferences.getInstance()
                  .then((value) => value.setInt("firstRun", 1))
                  .whenComplete(() => splashViewmodel
                      .waitForDelay(context)
                      .whenComplete(() => splashViewmodel.navigate(context)))
            }
          : {
              push(const LoginScreen(), context),
            };
    });
  }
}
