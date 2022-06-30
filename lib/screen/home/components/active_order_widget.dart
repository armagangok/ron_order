import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ron_order/feature/viewmodel/order_viewmodel.dart';

import '../../../core/extension/context_extension.dart';
import '../../../feature/models/food_model.dart';

class ActiveOrderWidget extends StatelessWidget {
  const ActiveOrderWidget({
    Key? key,
    required this.food,
  }) : super(key: key);

  final FoodModel food;

  @override
  Widget build(BuildContext context) {
    final width = context.getWidth(1);
    final height = context.getHeight(1);

    return GestureDetector(
      // onTap: () => addToFoodCart(foodCart, context),

      child: Stack(
        children: [
          buildFoodContainer(height, width, context.textTheme),
          buildFoodNumberWidget(food)
        ],
      ),
    );
  }

  //

  Widget buildFoodContainer(
    height,
    width,
    textTheme,
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
            height: height * 0.27,
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
            padding: EdgeInsets.symmetric(horizontal: width * 0.003),
            child: AutoSizeText(
              food.foodName,
              textAlign: TextAlign.center,
              style: textTheme.labelMedium!.copyWith(),
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

  Widget buildFoodNumberWidget(FoodModel foodModel) {
    return Consumer(
      builder: (context, OrderViewmodel orderViewmodel, _) {
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
                    onPressed: () => {foodModel.amount++},
                    icon: const Icon(
                      Icons.remove,
                      color: Colors.black,
                    ),
                  ),
                ),
                Text(
                  "${foodModel.amount}",
                  style: context.textTheme.headline2!.copyWith(
                    color: Colors.white,
                  ),
                ),
                CircleAvatar(
                  backgroundColor: Colors.white,
                  child: IconButton(
                    onPressed: () {
                      foodModel.amount--;
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
      },
    );
  }

  //

}



// // bool? a = true;
//                       foodModel.amount--;

//                       // if (a == null) {
//                       //   ScaffoldMessenger.of(context).showSnackBar(
//                       //     snackbarWanrning(kText.only3Food),
//                       //   );
//                       // }
//                       // if (a == false) {
//                       //   ScaffoldMessenger.of(context).showSnackBar(
//                       //     snackbarWanrning(kText.only1MainDish),
//                       //   );
//                       // }