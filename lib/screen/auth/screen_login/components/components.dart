import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ron_order/core/constants/constant_text.dart';
import 'package:ron_order/core/navigation/navigation.dart';
import 'package:ron_order/feature/components/snackbar.dart';
import 'package:ron_order/screen/root/root_screen.dart';

import '../../../../core/components/global_elevated_button.dart';
import '../../../../core/components/global_textfield.dart';
import '../../../../core/extension/context_extension.dart';
import '../../../../core/network/firebase/view-models/firebase_viewmodel.dart';
import '../viewmodel/textfield_controller.dart';

class PasswordTextField extends StatelessWidget {
  const PasswordTextField({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final LoginTextController controller =
        Provider.of<LoginTextController>(context);

    return GlobalTextField(
      hintText: "Password",
      isObscured: true,
      controller: controller.passwordController,
    );
  }
}

class EmailTextField extends StatelessWidget {
  const EmailTextField({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final LoginTextController controller =
        Provider.of<LoginTextController>(context);

    return GlobalTextField(
      hintText: "Email Adress",
      controller: controller.emailController,
    );
  }
}

class LoginButton extends StatelessWidget {
  const LoginButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final LoginTextController controller =
        Provider.of<LoginTextController>(context);

    final FirebaseVmodel firebase = Provider.of<FirebaseVmodel>(context);

    return SizedBox(
      height: context.getHeight(0.065),
      child: GlobalElevatedButton(
        onPressed: () async {
          try {
            await firebase
                .login(
                  controller.emailController.text,
                  controller.passwordController.text,
                )
                .then(
                  (value) => value != null
                      ? {
                          ScaffoldMessenger.of(context).showSnackBar(
                            getSnackBar1(kText.loginSuccess),
                          ),
                          getToRemove(const RootScreen(), context),
                        }
                      : {},
                );
          } on FirebaseAuthException catch (e) {
            print(e.code);
            ScaffoldMessenger.of(context).showSnackBar(
              getSnackBar(kText.warningText[e.code]!),
            );
            //
          }
        },
        text: "Log in",
      ),
    );
  }
}
