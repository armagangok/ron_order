import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import './viewmodel/textfield_controller.dart';
import '../../../core/components/components.dart';
import '../../../core/components/global_app_bar.dart';
import '../../../core/components/global_elevated_button.dart';
import '../../../core/components/global_textfield.dart';
import '../../../core/constants/constant_text.dart';
import '../../../core/extension/context_extension.dart';
import '../../../core/navigation/navigation.dart';
import '../../../core/network/firebase/view-models/firebase_viewmodel.dart';
import '../screen_register/components/dialogs.dart';
import '../screen_register/register_screen.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final LoginTextController controller =
        Provider.of<LoginTextController>(context);
    final FirebaseVmodel firebase = Provider.of<FirebaseVmodel>(context);
    return Scaffold(
      appBar: GlobalAppBar(title: "Log in"),
      body: SizedBox(
        height: context.getHeight(1),
        child: ListView(
          physics: const ClampingScrollPhysics(),
          padding: EdgeInsets.symmetric(horizontal: context.getWidth(0.08)),
          children: [
            GlobalTextField(
              hintText: "Email Adress",
              controller: controller.emailController,
            ),
            const SizedBox004(),
            GlobalTextField(
              hintText: "Password",
              isObscured: true,
              controller: controller.passwordController,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                TextButton(
                  onPressed: () {},
                  child: const Text("Forgot Password?"),
                ),
              ],
            ),
            const SizedBox004(),
            SizedBox(
              height: context.getHeight(0.065),
              child: GlobalElevatedButton(
                onPressed: () async {
                  if (controller.emailController.text.isEmpty ||
                      controller.passwordController.text.isEmpty) {
                    dialog(context, ConstText.emptyLogin);
                  } else {
                    try {
                      await firebase.loginByEmailPassword(
                        controller.emailController.text,
                        controller.passwordController.text,
                      );
                    } catch (e) {
                      print("$e");
                      dialog(context, "$e");
                    }
                  }
                },
                text: "Log in",
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const Text("Dont Have An Account?"),
                TextButton(
                  onPressed: () {
                    push(const RegisterScreen(), context);
                  },
                  child: const Text("Register"),
                ),
              ],
            ),
            // const SizedBox004(),
            //         const DividerWidget(),
            //         const SizedBox004(),
            //         GlobalElevatedButton(
            //           onPressed: () {},
            //           text: "Continue with Google",
            //           textColor: Colors.black,
            //           color: Colors.white,
            //           borderSideEnabled: true,
            //         ),
            //         const SizedBox004(),
            //         GlobalElevatedButton(
            //           onPressed: () {},
            //           text: "Continue with Facebook",
            //           textColor: Colors.black,
            //           color: Colors.white,
            //           borderSideEnabled: true,
            //         ),
          ],
        ),
      ),
    );
  }
}
