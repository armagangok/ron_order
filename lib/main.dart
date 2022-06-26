import 'package:flutter/material.dart';
import 'package:ron_order/screen/splash/splash_screen.dart';

import './core/initilization/init_app.dart';
import './core/theme/theme.dart';

void main() async => await initApp();

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: appTheme,
      home: const SplashScreen(),
    );
  }
}
