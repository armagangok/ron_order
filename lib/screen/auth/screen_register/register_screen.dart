import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ron_order/core/components/global_app_bar.dart';
import 'package:ron_order/core/tools/uuid_provider.dart';

import './components/dialogs.dart';
import './provider/textfield_controller.dart';
import '../../../core/components/components.dart';
import '../../../core/components/global_elevated_button.dart';
import '../../../core/components/global_textfield.dart';
import '../../../core/constants/constant_text.dart';
import '../../../core/extension/context_extension.dart';
import '../../../core/navigation/navigation.dart';
import '../../../core/network/firebase/models/user_model.dart';
import '../../../core/network/firebase/view-models/firebase_viewmodel.dart';
import '../screen_login/login_screen.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final RegisterTextController controller =
        Provider.of<RegisterTextController>(context);

    final FirebaseVmodel firebase = Provider.of<FirebaseVmodel>(context);
    return Scaffold(
      appBar: const GlobalAppBar(title: "Register"),
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
          SizedBox(
            height: context.getHeight(0.065),
            child: GlobalElevatedButton(
              onPressed: () async {
                final AppUser userModel = AppUser(
                  userName: controller.username.text,
                  email: controller.email.text,
                  password: controller.password.text,
                  passwordRepeat: controller.password.text,
                  orderList: [],
                  id: UniqueIDProvider().generateUID(),
                );

                try {
                  firebase.createUserByEmailPassword(userModel).then(
                        (value) => value == null
                            ? dialog(context, ConstText.registerErrorText)
                            : dialog(context, ConstText.verification)
                                .whenComplete(
                                () => push(const LoginScreen(), context),
                              ),
                      );
                } on FirebaseAuthException catch (e) {
                  dialog(context, e.message);
                }
              },
              text: "Register",
            ),
          ),
        ],
      ),
    );
  }
}
