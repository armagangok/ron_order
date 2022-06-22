import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../core/components/global_elevated_button.dart';
import '../../../../core/constants/constant_text.dart';
import '../../../../core/navigation/navigation.dart';
import '../../../../core/network/firebase/models/user_model.dart';
import '../../../../core/network/firebase/view-models/firebase_viewmodel.dart';
import '../../../../feature/components/snackbar.dart';
import '../../../root/root_screen.dart';
import '../provider/textfield_controller.dart';
import '../../../../core/extension/context_extension.dart';



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
            ScaffoldMessenger.of(context)
                .showSnackBar(getSnackBar(kText.userNameEmpty));
          } else if (controller.email.text.isEmpty) {
            ScaffoldMessenger.of(context)
                .showSnackBar(getSnackBar(kText.emailEmpty));
          } else if (controller.password.text.isEmpty ||
              controller.password.text.isEmpty) {
            ScaffoldMessenger.of(context)
                .showSnackBar(getSnackBar(kText.passwordsEmpty));
          } else if (controller.password.text != controller.rePassword.text) {
            ScaffoldMessenger.of(context)
                .showSnackBar(getSnackBar(kText.passwordsNotSame));
          } else {
            try {
              var a = await firebase.register(user);

              a != null
                  ? {
                      getTo(const RootScreen(), context),
                      ScaffoldMessenger.of(context).showSnackBar(
                        getSnackBar(kText.registrationSuccess),
                      ),
                    }
                  : {
                      ScaffoldMessenger.of(context).showSnackBar(
                        getSnackBar(kText.unknownError),
                      ),
                    };
            } on FirebaseAuthException catch (e) {
              print(e.code);
              ScaffoldMessenger.of(context).showSnackBar(
                getSnackBar1(kText.warningText[e.code]!),
              );
            }
          }
        },
        text: "Register",
      ),
    );
  }
}
