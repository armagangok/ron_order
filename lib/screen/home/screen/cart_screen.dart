import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import './home_screen.dart';
import '../../../core/components/components.dart';
import '../../../core/components/global_app_bar.dart';
import '../../../core/components/global_elevated_button.dart';
import '../../../core/navigation/navigation.dart';
import '../../../core/network/firebase/view-models/firebase_viewmodel.dart';
import '../../../feature/components/food_grid_view_builder.dart';
import '../../../feature/models/order_model.dart';
import '../../../feature/viewmodel/order_viewmodel.dart';
import '../../auth/screen_register/components/dialogs.dart';
import '../viewmodel/cart_viewmodel.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final OrderViewmodel orderVmodel = Provider.of<OrderViewmodel>(context);
    final FirebaseVmodel firebase = Provider.of<FirebaseVmodel>(context);
    final CartViewmodel cart = Provider.of<CartViewmodel>(context);

    return Scaffold(
      appBar: const GlobalAppBar(
        title: "My Orders",
        enableBackButton: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          children: [
            GridViewBuilderWidget(
              foodList: cart.foodCart,
              isActivationWidget: false,
            ),
            const SizedBox004(),
            GlobalElevatedButton(
              onPressed: () async {
                final OrderModel order = OrderModel(
                  orderList: cart.foodCart,
                  orderer: firebase.user!.userName!,
                  ordererId: firebase.user!.id!,
                );

                (cart.cartLength == 0)
                    ? {
                        await dialog(
                          context,
                          "Please select at least 1 food to order!",
                        ),
                      }
                    : {
                         orderVmodel.orderFood(order).whenComplete(
                              () => dialog(
                                context,
                                "Order is being sent!",
                              ).whenComplete(
                                () => getTo(const HomeScreen(), context),
                              ),
                            )
                      };
              },
              text: "Send Order",
            ),
          ],
        ),
      ),
    );
  }
}
