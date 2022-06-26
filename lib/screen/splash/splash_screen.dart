import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import './viewmodel/splash_viewmodel.dart';
import '../../core/extension/context_extension.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final SplashController splash = Provider.of<SplashController>(context);
    splash.waitAndNavigate(context);
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        body: SizedBox(
          height: context.getHeight(1),
          width: double.infinity,
          child: Image.asset(
            "assets/img/image.png",
            fit: BoxFit.fill,
          ),
        ),
      ),
    );
  }
}
