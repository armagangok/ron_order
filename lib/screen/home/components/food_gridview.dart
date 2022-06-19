import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../core/extension/context_extension.dart';
import '../../../feature/components/food_container.dart';
import '../../../feature/models/food_model.dart';
import '../viewmodel/cart_viewmodel.dart';

class RemoveFoodWidget extends StatelessWidget {
  const RemoveFoodWidget({
    Key? key,
    required this.food,
  }) : super(key: key);
  final FoodModel food;

  @override
  Widget build(BuildContext context) {
    final CartViewmodel foodCart = Provider.of<CartViewmodel>(context);
    return InkWell(
      onTap: () => foodCart.addFoodToCart(food),
      child: Stack(
        children: [
          FoodContainer(food: food),
          foodCart.isSelected(food)
              ? Container(
                  width: double.infinity,
                  height: context.getHeight(0.36),
                  decoration: BoxDecoration(
                    color: Colors.black.withOpacity(0.35),
                    borderRadius: const BorderRadius.all(Radius.circular(16)),
                  ),
                  child: Positioned.fill(
                    child: Align(
                      alignment: Alignment.center,
                      child: removeButton(
                        foodCart,
                        food,
                        context.theme.primaryColor,
                      ),
                    ),
                  ),
                )
              : const SizedBox(),
        ],
      ),
    );
  }

  //

  Widget removeButton(foodCart, FoodModel food, color) {
    return GestureDetector(
      child: Icon(
        CupertinoIcons.trash_fill,
        color: color,
        size: 70,
      ),
      onTap: () => foodCart.removeFoodFromCart(food),
    );
  }
}
