import 'package:flutter/material.dart';
import 'package:ron_order/screen/splash/viewmodel/splash_viewmodel.dart';

import '../../core/extension/context_extension.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final SplashViewmodel splashViewmodel = SplashViewmodel();
    splashViewmodel
        .waitForDelay(context)
        .whenComplete(() => splashViewmodel.navigate(context));
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
}
