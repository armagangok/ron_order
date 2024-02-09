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
    return WillPopScope(
      onWillPop: () async => false,
      child: GestureDetector(
        onTap: () => context.dismissKeyboard(),
        child: Scaffold(
          appBar: const GlobalAppBar(title: "Giriş Yap"),
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
                    const Text("Hesabınız yok mu?"),
                    TextButton(
                      onPressed: () => getTo(const RegisterScreen(), context),
                      child: const Text("Hesap Oluştur"),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
