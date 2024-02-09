import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../core/extension/context_extension.dart';
import '../../../core/network/firebase/view-models/firebase_viewmodel.dart';
import '../../core/navigation/navigation.dart';
import '../../screen/auth/screen_login/viewmodel/textfield_controller.dart';
import '../../screen/auth/screen_register/provider/textfield_controller.dart';
import '../../screen/home/controller/cart_controller.dart';
import '../../screen/home/screen/cart_screen.dart';
import '../../screen/root/root_screen.dart';

class CartWidget extends StatelessWidget {
  const CartWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (BuildContext context, CartController cart, _) {
        return (cart.cartLength != 0)
            ? Stack(
                children: [
                  Positioned(
                    right: 0,
                    child: Text(
                      "${cart.getTotalFood()}",
                      style: context.textTheme.titleMedium!.copyWith(
                        color: context.theme.primaryColor,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  IconButton(
                    padding: EdgeInsets.zero,
                    icon: const Icon(CupertinoIcons.shopping_cart),
                    onPressed: () => getTo(const CartScreen(), context),
                    color: Colors.black,
                  ),
                ],
              )
            : AutoSizeText(
                "Etibol Lokantası",
                style: context.textTheme.labelMedium!.copyWith(
                  fontWeight: FontWeight.w600,
                  color: const Color(0xff32324D),
                ),
                maxFontSize: 18,
                minFontSize: 15,
              );
      },
    );
  }
}

class LogoutButton extends StatelessWidget {
  const LogoutButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final FirebaseVmodel firebase = Provider.of<FirebaseVmodel>(context);
    CartController cart = Provider.of<CartController>(context);
    LoginTextController loginTextController =
        Provider.of<LoginTextController>(context);
    RegisterTextController registerTextController =
        Provider.of<RegisterTextController>(context);
    return IconButton(
      padding: EdgeInsets.zero,
      icon: const Icon(Icons.logout_rounded),
      onPressed: () async {
        cart.foodCart.clear();
        loginTextController.emailController.clear();
        loginTextController.passwordController.clear();
        registerTextController.email.clear();
        registerTextController.password.clear();
        registerTextController.rePassword.clear();
        registerTextController.username.clear();

        await firebase
            .logout()
            .whenComplete(() => getToRemove(const RootScreen(), context));
      },
      color: Colors.black,
    );
  }
}
