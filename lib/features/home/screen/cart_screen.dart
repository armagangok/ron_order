import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import './home_screen.dart';
import '../../../core/components/components.dart';
import '../../../core/components/global_app_bar.dart';
import '../../../core/components/global_elevated_button.dart';
import '../../../core/extension/context_extension.dart';
import '../../../core/navigation/navigation.dart';
import '../../../core/network/firebase/view-models/firebase_viewmodel.dart';
import '../../../feature/components/food_grid_view_builder.dart';
import '../../../feature/components/snackbar.dart';
import '../../../feature/models/order_model.dart';
import '../../../feature/viewmodel/order_viewmodel.dart';
import '../controller/cart_controller.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        appBar: const GlobalAppBar(
          title: "Sipariş Gönder",
          enableBackButton: true,
        ),
        body: Padding(
          padding: EdgeInsets.all(context.getWidth(0.025)),
          child: ListView(
            physics: const ClampingScrollPhysics(),
            children: [
              buildFoodGridView(),
              const SizedBox004(),
              buildUploadOrderButton()
            ],
          ),
        ),
      ),
    );
  }

  //

  Widget buildUploadOrderButton() {
    return Consumer(
      builder: (context, CartController cart, _) {
        final FirebaseVmodel firebase = Provider.of<FirebaseVmodel>(context);
        final OrderViewmodel orderVmodel = Provider.of<OrderViewmodel>(context);
        return cart.cartLength != 0
            ? GlobalElevatedButton(
                onPressed: () async {
                  var date = DateTime.now();
                  String stringDate =
                      "${date.day}/${date.month}/${date.year} - ${date.hour}:${date.minute}";
                  final OrderModel order = OrderModel(
                    activeOrderList: cart.foodCart,
                    orderer: firebase.user!.userName!,
                    ordererId: firebase.user!.id!,
                    date: stringDate,
                  );

                  orderVmodel.orderFood(order).whenComplete(
                        () => ScaffoldMessenger.of(context).showSnackBar(
                          snackbarSuccess("Siparişiniz gönderildi."),
                        ),
                      );

                  getToRemove(const HomeScreen(), context);

                  cart.clearCart();
                },
                text: "Sipariş Gönder",
              )
            : const SizedBox();
      },
    );
  }

  //

  Widget buildFoodGridView() {
    return Consumer(
      builder: (context, CartController cart, _) {
        return GridViewBuilderWidget(
          foodList: cart.foodCart,
          isActivationWidget: false,
        );
      },
    );
  }
}
