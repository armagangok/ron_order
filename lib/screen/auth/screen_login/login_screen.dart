import 'package:flutter/material.dart';

import './components/components.dart';
import '../../../core/components/components.dart';
import '../../../core/components/global_app_bar.dart';
import '../../../core/extension/context_extension.dart';
import '../../../core/navigation/navigation.dart';
import '../screen_register/register_screen.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const GlobalAppBar(title: "Log in"),
      body: SizedBox(
        height: context.getHeight(1),
        child: ListView(
          physics: const ClampingScrollPhysics(),
          padding: EdgeInsets.symmetric(horizontal: context.getWidth(0.08)),
          children: [
            const EmailTextField(),
            const SizedBox004(),
            const PasswordTextField(),
            const SizedBox004(),
            const LoginButton(),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const Text("Dont Have An Account?"),
                TextButton(
                  onPressed: () => getTo(const RegisterScreen(), context),
                  child: const Text("Register"),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
