import 'package:flutter/material.dart';

import './viewmodel/splash_viewmodel.dart';
import '../../core/extension/context_extension.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final SplashController splash = SplashController();
  @override
  void initState() {
    splash.waitAndNavigate(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
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
