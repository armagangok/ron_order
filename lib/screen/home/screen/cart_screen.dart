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
import '../../../feature/models/order_model.dart';
import '../../../feature/viewmodel/order_viewmodel.dart';
import '../../auth/screen_register/components/dialogs.dart';
import '../controller/cart_controller.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final OrderViewmodel orderVmodel = Provider.of<OrderViewmodel>(context);
    final FirebaseVmodel firebase = Provider.of<FirebaseVmodel>(context);
    final CartController cart = Provider.of<CartController>(context);

    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        appBar: const GlobalAppBar(
          title: "My Orders",
          enableBackButton: true,
        ),
        body: Padding(
          padding: EdgeInsets.all(context.getWidth(0.025)),
          child: ListView(
            physics: const ClampingScrollPhysics(),
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
                                  () =>
                                      getToRemove(const HomeScreen(), context),
                                ),
                              )
                        };
                },
                text: "Send Order",
              ),
            ],
          ),
        ),
      ),
    );
  }
}
