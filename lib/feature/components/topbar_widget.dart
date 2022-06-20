import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../core/extension/context_extension.dart';
import '../../../core/network/firebase/view-models/firebase_viewmodel.dart';
import '../../core/navigation/navigation.dart';
import '../../screen/home/screen/cart_screen.dart';
import '../../screen/home/viewmodel/cart_viewmodel.dart';

class TopBarWidget extends StatelessWidget {
  const TopBarWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final double h = context.getHeight(1);
    final double w = context.getWidth(1);

    var textTheme = context.textTheme;

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        buildLocationAndTextWidget(textTheme, w),
        Row(
          children: [
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
      builder: (BuildContext context, CartViewmodel cart, _) {
        var foodList = cart.foodCart;
        return (cart.cartLength != 0)
            ? Stack(
                children: [
                  Positioned(
                    right: 0,
                    child: Text(
                      "${cart.cartLength}",
                      style: context.textTheme.titleMedium!.copyWith(
                        color: context.theme.primaryColor,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  IconButton(
                    padding: EdgeInsets.zero,
                    icon: const Icon(CupertinoIcons.shopping_cart),
                    onPressed: () => push(const CartScreen(), context),
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
    CartViewmodel cart = Provider.of<CartViewmodel>(context);
    return IconButton(
      padding: EdgeInsets.zero,
      icon: const Icon(Icons.logout_rounded),
      onPressed: () async {
        cart.foodCart.clear();
        await firebase.logout();
      },
      color: Colors.black,
    );
  }
}
