import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../core/network/firebase/view-models/firebase_viewmodel.dart';
import '../admin/screen/admin_screen.dart';
import '../auth/screen_login/login_screen.dart';
import '../home/screen/home_screen.dart';

class RootScreen extends StatelessWidget {
  const RootScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final FirebaseVmodel firebase = Provider.of<FirebaseVmodel>(context);

    if (firebase.state == ViewState.idle) {
      if (firebase.user != null) {
        return (firebase.user!.isAdmin)
            ? const AdminScreen()
            : const HomeScreen();
      } else {
        return const LoginScreen();
      }
    } else {
      return const Scaffold(
        body: Center(
          child: Text("Checking user info..."),
        ),
      );
    }
  }
}
