import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../core/components/circle_container.dart';
import '../../../core/components/global_app_bar.dart';
import '../../../core/components/global_elevated_button.dart';
import '../../../core/extension/context_extension.dart';
import '../../../core/models/food_model.dart';
import '../../../core/models/order_model.dart';
import '../../../core/network/firebase/view-models/firebase_viewmodel.dart';
import '../../auth/screen_register/components/dialogs.dart';
import '../viewmodel/cart_viewmodel.dart';
import '../viewmodel/index_provider.dart';
import '../viewmodel/order_viewmodel.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final OrderViewmodel orderVmodel = Provider.of<OrderViewmodel>(context);
    final FirebaseVmodel firebase = Provider.of<FirebaseVmodel>(context);
    final CartViewmodel cart = Provider.of<CartViewmodel>(context);

    return Scaffold(
      appBar: GlobalAppBar(title: "My Orders"),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            buildGrid(context, cart.foodCart),
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
                        await orderVmodel.orderFood(order),
                        await dialog(
                          context,
                          "Order just being sent!",
                        ),
                      };
              },
              text: "Send Order",
            ),
          ],
        ),
      ),
    );
  }

  Widget buildGrid(BuildContext context, List<FoodModel> foodList) {
    final CartViewmodel foodCart = Provider.of<CartViewmodel>(context);
    final IndexProvider indexProvider = Provider.of<IndexProvider>(context);

    return GridView.builder(
      shrinkWrap: true,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 10,
        mainAxisExtent: context.getHeight(0.34),
        mainAxisSpacing: 10,
      ),
      itemCount: foodList.length,
      itemBuilder: (context, index) {
        var food = foodList[index];
        return GestureDetector(
          onTap: () {
            indexProvider.setIndex = index;
            foodCart.addFoodToCart(foodList[index]);
          },
          child: Stack(
            alignment: Alignment.center,
            children: [
              menuItem(context, foodList, index),
              foodCart.isSelected(food)
                  ? Container(
                      decoration: BoxDecoration(
                        color: Colors.black.withOpacity(0.3),
                        borderRadius: const BorderRadius.all(
                          Radius.circular(16),
                        ),
                      ),
                    )
                  : const SizedBox(),
              foodCart.isSelected(food)
                  ? Positioned.fill(
                      child: Align(
                        alignment: Alignment.topCenter,
                        child: removeButton(foodCart, foodList, index),
                      ),
                    )
                  : const SizedBox(),
            ],
          ),
        );
      },
    );
  }

  Row removeButton(foodCart, foodList, index) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        GestureDetector(
          child: const Icon(
            CupertinoIcons.trash_fill,
            color: Colors.amber,
            size: 70,
          ),
          onTap: () => foodCart.removeFoodFromCart(foodList[index]),
        )
      ],
    );
  }

  Container menuItem(
    BuildContext context,
    List<FoodModel> foodList,
    int index,
  ) {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(16)),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            CircleContainer(
              heigth: context.getWidth(0.4),
              width: context.getWidth(0.4),
              imageUrl: foodList[index].imageUrl,
            ),
            AutoSizeText(
              foodList[index].foodName,
              style: context.textTheme.labelMedium,
              maxFontSize: 18,
              maxLines: 2,
            ),
          ],
        ),
      ),
    );
  }
}
