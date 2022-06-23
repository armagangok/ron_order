import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../screen/home/controller/cart_controller.dart';
import './snackbar.dart';
import '../../core/constants/constant_text.dart';
import '../../core/extension/context_extension.dart';
import '../models/food_model.dart';

class FoodWidget extends StatelessWidget {
  const FoodWidget({
    Key? key,
    required this.food,
  }) : super(key: key);

  final FoodModel food;

  @override
  Widget build(BuildContext context) {
    final CartController foodCart = Provider.of<CartController>(context);
    return GestureDetector(
      onTap: () {
        (foodCart.foodCart.length == 3)
            ? ScaffoldMessenger.of(context)
                .showSnackBar(getSnackBar(kText.cartIsFull))
            : {};
        var a = foodCart.addFoodToCart(food);
        (a == false)
            ? ScaffoldMessenger.of(context)
                .showSnackBar(getSnackBar(kText.chooseAnotherCategory))
            : {};
      },
      child: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              color: foodCart.isSelected(food)
                  ? Colors.black.withOpacity(0.15)
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
                        ? Colors.black.withOpacity(0.3)
                        : Colors.red,
                    image: DecorationImage(
                      image: NetworkImage(
                        food.imageUrl,
                      ),
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
                const Spacer(),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 5),
                  child: AutoSizeText(
                    food.foodName,
                    textAlign: TextAlign.center,
                    style: context.textTheme.labelMedium,
                    maxFontSize: 18,
                    maxLines: 2,
                  ),
                ),
                const Spacer(),
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

  Widget removeButton(CartController foodCart, FoodModel food, color) {
    return GestureDetector(
      child: Icon(
        CupertinoIcons.check_mark_circled,
        color: const Color.fromARGB(255, 81, 255, 87).withOpacity(0.8),
        size: 120,
      ),
      onTap: () => foodCart.removeFoodFromCart(food),
    );
  }
}
