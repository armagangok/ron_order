import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ron_order/feature/components/activation_widget.dart';
import 'package:ron_order/screen/admin/viewmodel/activation_viewmodel.dart';
import 'package:ron_order/screen/auth/screen_register/components/dialogs.dart';

import '../../core/extension/context_extension.dart';
import '../../screen/home/viewmodel/cart_viewmodel.dart';
import '../models/food_model.dart';

class FoodContainer extends StatelessWidget {
  const FoodContainer({
    Key? key,
    required this.food,
  }) : super(key: key);

  final FoodModel food;

  @override
  Widget build(BuildContext context) {
    final CartViewmodel foodCart = Provider.of<CartViewmodel>(context);
    return GestureDetector(
      onTap: () {
        var a = foodCart.addFoodToCart(food, context);
        (a == false)
            ? dialog(context, "Please choose food from another category!")
            : {};
      },
      child: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              color: foodCart.isSelected(food)
                  ? Colors.black.withOpacity(0.35)
                  : Colors.white,
              borderRadius: const BorderRadius.all(Radius.circular(16)),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  width: double.infinity,
                  height: context.getHeight(0.27),
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.all(
                      Radius.circular(16.0),
                    ),
                    color: foodCart.isSelected(food)
                        ? Colors.black.withOpacity(0.35)
                        : Colors.red,
                    image: DecorationImage(
                      image: NetworkImage(
                        food.imageUrl,
                      ),
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 5, horizontal: 3),
                  child: AutoSizeText(
                    food.foodName,
                    textAlign: TextAlign.center,
                    style: context.textTheme.labelMedium,
                    maxFontSize: 18,
                    maxLines: 2,
                  ),
                ),
              ],
            ),
          ),
          foodCart.isSelected(food)
              ? Positioned.fill(
                  child: removeButton(
                    foodCart,
                    food,
                    context.theme.primaryColor,
                  ),
                )
              : const Center(),
        ],
      ),
    );
  }

  //

  Widget removeButton(CartViewmodel foodCart, FoodModel food, color) {
    return GestureDetector(
      child: const Icon(
        CupertinoIcons.trash_fill,
        color: Colors.white,
        size: 70,
      ),
      onTap: () => foodCart.removeFoodFromCart(food),
    );
  }
}

class FoodContainerAdmin extends StatelessWidget {
  const FoodContainerAdmin({
    Key? key,
    required this.food,
  }) : super(key: key);

  final FoodModel food;

  @override
  Widget build(BuildContext context) {
    
    final ActivationViewmodel foodActivation =
        Provider.of<ActivationViewmodel>(context);
    return GestureDetector(
      onTap: () {
        food.isActive
            ? foodActivation.inactivate(food)
            : foodActivation.activate(food);
      },
      onLongPress: () async {
        await deleteFoodDialog(context, food);
      },
      child: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              color:
                  food.isActive ? Colors.white : Colors.black.withOpacity(0.3),
              borderRadius: const BorderRadius.all(Radius.circular(16)),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  width: double.infinity,
                  height: context.getHeight(0.27),
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.all(
                      Radius.circular(16.0),
                    ),
                    color: food.isActive
                        ? Colors.white
                        : Colors.black.withOpacity(0.35),
                    image: DecorationImage(
                      image: NetworkImage(
                        food.imageUrl,
                      ),
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 5, horizontal: 3),
                  child: AutoSizeText(
                    food.foodName,
                    textAlign: TextAlign.center,
                    style: context.textTheme.labelMedium,
                    maxFontSize: 18,
                    maxLines: 2,
                  ),
                ),
              ],
            ),
          ),
          food.isActive
              ? const Center()
              : Positioned.fill(
                  child: Align(
                    child: AutoSizeText(
                      "Deactivated",
                      // textAlign: TextAlign.center,
                      style: context.textTheme.headline5!.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.w700,
                      ),

                      maxLines: 1,
                    ),
                  ),
                ),
        ],
      ),
    );
  }
}
Future<void> deleteFoodDialog(context, FoodModel food) async {
  await showDialog(
    context: context,
    builder: (_) => DeleteFoodDialog(food: food),
  );
}