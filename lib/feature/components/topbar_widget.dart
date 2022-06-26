import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ron_order/screen/admin/screen/admin_screen.dart';

import '../../../core/extension/context_extension.dart';
import '../../../core/network/firebase/view-models/firebase_viewmodel.dart';
import '../../core/navigation/navigation.dart';
import '../../screen/auth/screen_login/viewmodel/textfield_controller.dart';
import '../../screen/auth/screen_register/provider/textfield_controller.dart';
import '../../screen/home/controller/cart_controller.dart';
import '../../screen/home/screen/cart_screen.dart';
import '../../screen/root/root_screen.dart';

class TopBarWidget extends StatelessWidget {
  const TopBarWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    FirebaseVmodel firebase = Provider.of<FirebaseVmodel>(context);

    final double h = context.getHeight(1);
    final double w = context.getWidth(1);

    var textTheme = context.textTheme;

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        buildLocationAndTextWidget(textTheme, w),
        Row(
          children: [
            firebase.user!.isAdmin
                ? IconButton(
                    onPressed: () {
                      getTo(const AdminScreen(), context);
                    },
                    icon: const Icon(
                      CupertinoIcons.person,
                      color: Colors.black,
                    ),
                  )
                : const SizedBox(),
            const LogoutButton(),
            cartWidget(),
          ],
        )
      ],
    );
  }

  //

  Row buildLocationAndTextWidget(textTheme, w) {
    return Row(
      children: [
        const Icon(
          CupertinoIcons.location,
          color: Color(0xff8E8787),
        ),
        Padding(
          padding: EdgeInsets.only(left: w * (0.05)),
          child: Text(
            "Etibol Lokantası",
            style: textTheme.subtitle1,
          ),
        ),
      ],
    );
  }

  //

  Widget cartWidget() {
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
            : const SizedBox();
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
            .whenComplete(() => getTo(const RootScreen(), context));
      },
      color: Colors.black,
    );
  }
}
