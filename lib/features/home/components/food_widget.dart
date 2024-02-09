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
    final width = context.getWidth(1);
    final height = context.getHeight(1);
    final CartController foodCart = Provider.of<CartController>(context);

    return GestureDetector(
      onTap: () {
        print(food.amount);
        var a = foodCart.addFood(food);

        a == null
            ? ScaffoldMessenger.of(context)
                .showSnackBar(snackbarWanrning(kText.cartIsFull))
            : {};

        a == false
            ? ScaffoldMessenger.of(context)
                .showSnackBar(snackbarWanrning(kText.chooseAnotherCategory))
            : {};
      },
      onLongPress: () {
        showDialog(
          context: context,
          builder: (ctx) {
            final width = ctx.getWidth(1);
            final height = ctx.getHeight(1);
            return AlertDialog(
              content: Stack(
                children: [
                  SizedBox(
                    width: width * 0.9,
                    height: height * 0.7,
                    child: Image.network(
                      food.imageUrl,
                      fit: BoxFit.fill,
                    ),
                  ),
                  GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: Padding(
                      padding: const EdgeInsets.all(3.0),
                      child: Container(
                        decoration: BoxDecoration(
                            color: Colors.black.withOpacity(0.5),
                            shape: BoxShape.circle),
                        child: Icon(
                          CupertinoIcons.xmark_circle,
                          color: Colors.white.withOpacity(0.9),
                          size: 40,
                        ),
                      ),
                    ),
                  )
                ],
              ),
              insetPadding: EdgeInsets.zero,
              contentPadding: EdgeInsets.zero,
              clipBehavior: Clip.antiAliasWithSaveLayer,
            );
          },
        );
      },
      child: Stack(
        children: [
          buildFoodContainer(foodCart, context),
          foodCart.isSelected(food)
              ? buildFoodNumberWidget(
                  width,
                  food,
                  foodCart,
                  context.textTheme,
                  context,
                )
              : const Center(),
        ],
      ),
    );
  }

  //

  Widget buildFoodContainer(
    CartController foodCart,
    BuildContext context,
  ) {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(16)),
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
            padding: EdgeInsets.symmetric(horizontal: context.getWidth(0.002)),
            child: AutoSizeText(
              food.foodName,
              textAlign: TextAlign.center,
              style: context.textTheme.labelMedium!.copyWith(),
              maxFontSize: 17,
              maxLines: 2,
            ),
          ),
          const Spacer(),
        ],
      ),
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
    return Positioned.fill(
      child: Container(
        decoration: BoxDecoration(
          color: Colors.black.withOpacity(0.35),
          borderRadius: const BorderRadius.all(
            Radius.circular(16.0),
          ),
        ),
        width: double.infinity,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
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
              style: textTheme.headline2!.copyWith(
                color: Colors.white,
              ),
            ),
            CircleAvatar(
              backgroundColor: Colors.white,
              child: IconButton(
                onPressed: () {
                  bool? a = cartController.addFood(choosenFood);

                  if (a == null) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      snackbarWanrning(kText.only3Food),
                    );
                  }
                  if (a == false) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      snackbarWanrning(kText.only1MainDish),
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
    );
  }
}
