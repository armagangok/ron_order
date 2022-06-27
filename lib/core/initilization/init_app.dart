import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import './provider_helper/provider_helper.dart';
import '../../main.dart';
import '../network/firebase/locator/locator.dart';

Future<void> initApp() async {
  setupLocator();
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp( 
    MultiProvider(
      providers: ProviderHelper().providers,
      child: const MyApp(),
    ),
  );
}
