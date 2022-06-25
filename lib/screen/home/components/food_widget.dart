import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../core/constants/constant_text.dart';
import '../../../core/extension/context_extension.dart';
import '../../../feature/components/snackbar.dart';
import '../../../feature/models/food_model.dart';
import '../controller/cart_controller.dart';

class FoodWidget extends StatelessWidget {
  const FoodWidget({
    Key? key,
    required this.food,
  }) : super(key: key);

  final FoodModel food;

  @override
  Widget build(BuildContext context) {
    final CartController foodCart = Provider.of<CartController>(context);
    final w = context.getHeight(1);
    return GestureDetector(
      onTap: () {
        (foodCart.foodCart.length == 3)
            ? ScaffoldMessenger.of(context)
                .showSnackBar(getSnackBar(kText.cartIsFull))
            : {};
        var a = foodCart.addFood(food);
        (a == false)
            ? ScaffoldMessenger.of(context)
                .showSnackBar(getSnackBar(kText.chooseAnotherCategory))
            : {};
      },
      child: Stack(
        children: [
          buildFoodContainer(foodCart, context),
          foodCart.isSelected(food)
              ? Positioned.fill(
                  child: buildFoodNumberWidget(
                    w,
                    food,
                    foodCart,
                    context.textTheme,
                    context,
                  ),
                )
              : const Center(),
        ],
      ),
    );
  }

  //

  AnimatedContainer buildFoodContainer(
    CartController foodCart,
    BuildContext context,
  ) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 500),
      decoration: BoxDecoration(
        color: foodCart.isSelected(food) ? context.primaryColor : Colors.white,
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
              style: context.textTheme.labelMedium!.copyWith(
                color: foodCart.isSelected(food) ? Colors.white : null,
              ),
              maxFontSize: 18,
              maxLines: 2,
            ),
          ),
          const Spacer(),
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
      onTap: () => foodCart.cancelFood(food),
    );
  }

  //

  Widget buildFoodNumberWidget(
    double w,
    FoodModel choosenFood,
    CartController cartController,
    TextTheme textTheme,
    context,
  ) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: w * 0.005),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(
            width: w * 0.268,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CircleAvatar(
                  backgroundColor: Colors.white,
                  child: IconButton(
                    onPressed: () => cartController.cancelFood(choosenFood),
                    icon: const Icon(
                      Icons.remove,
                      color: Colors.black,
                    ),
                  ),
                ),
                Text(
                  cartController.getFoodAmount(cartController.foodCart, food),
                  style: textTheme.headline1!.copyWith(
                    color: Colors.white,
                  ),
                ),
                CircleAvatar(
                  backgroundColor: Colors.white,
                  child: IconButton(
                    onPressed: () {
                      bool? a = cartController.addFood(choosenFood);

                      if (cartController.checkCart() == false) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          getSnackBar(kText.only3Food),
                        );
                      }
                      if (a == false) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          getSnackBar(kText.only1MainDish),
                        );
                      }
                    },
                    icon: const Icon(
                      Icons.add,
                      color: Colors.black,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
