import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ron_order/screen/auth/screen_register/components/dialogs.dart';

import './provider/textfield_controller.dart';
import '../../../core/components/components.dart';
import '../../../core/components/global_app_bar.dart';
import '../../../core/components/global_elevated_button.dart';
import '../../../core/components/global_textfield.dart';
import '../../../core/extension/context_extension.dart';
import '../../../core/navigation/navigation.dart';
import '../../../core/network/firebase/models/user_model.dart';
import '../../../core/network/firebase/view-models/firebase_viewmodel.dart';
import '../../root/root_screen.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final RegisterTextController controller =
        Provider.of<RegisterTextController>(context);

    return Scaffold(
      appBar: const GlobalAppBar(
        title: "Register",
        enableBackButton: true,
      ),
      body: ListView(
        padding: EdgeInsets.symmetric(horizontal: context.getHeight(0.05)),
        physics: const ClampingScrollPhysics(),
        children: [
          GlobalTextField(
            hintText: "User Name",
            controller: controller.username,
          ),
          const SizedBox004(),
          GlobalTextField(
            hintText: "Email Adress",
            controller: controller.email,
          ),
          const SizedBox004(),
          GlobalTextField(
            hintText: "Password",
            isObscured: true,
            controller: controller.password,
          ),
          const SizedBox004(),
          GlobalTextField(
            hintText: "Re Password",
            isObscured: true,
            controller: controller.rePassword,
          ),
          const SizedBox004(),
          const RegisterButton(),
        ],
      ),
    );
  }
}

class RegisterButton extends StatelessWidget {
  const RegisterButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final RegisterTextController controller =
        Provider.of<RegisterTextController>(context);

    final FirebaseVmodel firebase = Provider.of<FirebaseVmodel>(context);
    return SizedBox(
      height: context.getHeight(0.065),
      child: GlobalElevatedButton(
        onPressed: () async {
          final AppUser user = AppUser(
            userName: controller.username.text,
            email: controller.email.text,
            password: controller.password.text,
            passwordRepeat: controller.password.text,
          );

          if (controller.username.text.isEmpty) {
            dialog(context, "Username field cannot be empty.");
          } else if (controller.email.text.isEmpty) {
            dialog(context, "Email field cannot be empty.");
          } else if (controller.password.text.isEmpty ||
              controller.password.text.isEmpty) {
            dialog(context, "Pasword fields cannot be empty.");
          } else if (controller.password.text != controller.rePassword.text) {
            dialog(context, "Paswords are not same.");
          } else {
            try {
              var a = await firebase.register(user);
              a != null
                  ? {
                      dialog(context, "You just registered a new account!")
                          .whenComplete(
                              () => getTo(const RootScreen(), context)),
                    }
                  : {
                      getTo(const RootScreen(), context),
                    };
            } on FirebaseAuthException catch (e) {
              await showDialog(
                context: context,
                builder: (context) {
                  return CupertinoAlertDialog(
                    title: Text(e.message!),
                  );
                },
              );
            }
          }
        },
        text: "Register",
      ),
    );
  }
}
