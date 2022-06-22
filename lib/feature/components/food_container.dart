import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import './activation_widget.dart';
import './snackbar.dart';
import '../../core/constants/constant_text.dart';
import '../../core/extension/context_extension.dart';
import '../../screen/admin/viewmodel/activation_viewmodel.dart';
import '../../screen/home/viewmodel/cart_viewmodel.dart';
import '../models/food_model.dart';

class FoodWidget extends StatelessWidget {
  const FoodWidget({
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
            ? ScaffoldMessenger.of(context)
                .showSnackBar(getSnackBar(kText.anotherCategoryWarning))
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

