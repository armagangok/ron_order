import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../core/components/global_elevated_button.dart';
import '../../../../core/components/global_textfield.dart';
import '../../../../core/constants/constant_text.dart';
import '../../../../core/extension/context_extension.dart';
import '../../../../core/network/firebase/view-models/firebase_viewmodel.dart';
import '../../../../core/tools/preference_provider.dart';
import '../../screen_register/components/dialogs.dart';
import '../viewmodel/textfield_controller.dart';

class PasswordTextField extends StatelessWidget {
  const PasswordTextField({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final LoginTextController controller =
        Provider.of<LoginTextController>(context);

    final PreferenceController pref = PreferenceController();

    pref
        .getUserInfo()
        .then((value) => controller.passwordController.text = value.password);

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

    final PreferenceController pref = PreferenceController();

    pref
        .getUserInfo()
        .then((value) => controller.emailController.text = value.email);
    return GlobalTextField(
      hintText: "Email Adress",
      controller: controller.emailController,
    );
  }
}

class LoginButton extends StatelessWidget {
  const LoginButton({Key? key}) : super(key: key);

  // AppUser? a;

  @override
  Widget build(BuildContext context) {
    final LoginTextController controller =
        Provider.of<LoginTextController>(context);

    final FirebaseVmodel firebase = Provider.of<FirebaseVmodel>(context);

    return SizedBox(
      height: context.getHeight(0.065),
      child: GlobalElevatedButton(
        onPressed: () async {
          if (controller.emailController.text.isEmpty ||
              controller.passwordController.text.isEmpty) {
            await dialog(context, ConstText.emptyLogin);
          } else {
            await firebase.loginByEmailPassword(
              controller.emailController.text,
              controller.passwordController.text,
            );
          }
          // (a == null)
          //     ? {
          //         print(a),
          //         await dialog(context, "Password or mail is not correct!"),
          //       }
          //     : {
          //         print(a),
          //       };
        },
        text: "Log in",
      ),
    );
  }
}
