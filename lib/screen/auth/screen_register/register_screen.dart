import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import './components/registration_button.dart';
import './provider/textfield_controller.dart';
import '../../../core/components/components.dart';
import '../../../core/components/global_app_bar.dart';
import '../../../core/components/global_textfield.dart';
import '../../../core/extension/context_extension.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final RegisterTextController controller =
        Provider.of<RegisterTextController>(context);

    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        appBar: const GlobalAppBar(
          title: "Hesap Oluştur",
          enableBackButton: true,
        ),
        body: ListView(
          padding: EdgeInsets.symmetric(horizontal: context.getHeight(0.05)),
          physics: const ClampingScrollPhysics(),
          children: [
            GlobalTextField(
              hintText: "Kullanıcı Adı",
              controller: controller.username,
            ),
            const SizedBox004(),
            GlobalTextField(
              hintText: "Email Adresi",
              controller: controller.email,
              keyboardType: TextInputType.emailAddress,
            ),
            const SizedBox004(),
            GlobalTextField(
              hintText: "Şifre",
              isObscured: true,
              controller: controller.password,
            ),
            const SizedBox004(),
            GlobalTextField(
              hintText: "Tekrar Şifre",
              isObscured: true,
              controller: controller.rePassword,
            ),
            const SizedBox004(),
            const RegisterButton(),
          ],
        ),
      ),
    );
  }
}
