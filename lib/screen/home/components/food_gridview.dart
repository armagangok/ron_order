import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../core/components/circle_container.dart';
import '../../../core/extension/context_extension.dart';

import '../../../global/models/food_model.dart';
import '../viewmodel/cart_viewmodel.dart';
import '../../../global/viewmodel/food_viewmodel.dart';
import '../viewmodel/index_provider.dart';

class FoodGridView extends StatelessWidget {
  const FoodGridView({
    Key? key,
    required this.category,
  }) : super(key: key);

  final String category;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<FoodModel>>(
      future: FoodProvider().fetchFoodByCategory(category),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          var foodList = snapshot.data!;
          return buildGrid(context, foodList);
        } else if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: Text("Waiting for data..."),
          );
        } else {
          return const Center(
            child: Text("Check your internet connection."),
          );
        }
      },
    );
  }

  //

  Widget buildGrid(
    BuildContext context,
    List<FoodModel> foodList,
  ) {
    final CartViewmodel foodCart = Provider.of<CartViewmodel>(context);
    final IndexProvider indexProvider = Provider.of<IndexProvider>(context);

    return GridView.builder(
      shrinkWrap: true,
      physics: const ClampingScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 10,
        mainAxisExtent: context.getHeight(0.34),
        mainAxisSpacing: 10,
      ),
      itemCount: foodList.length,
      itemBuilder: (context, index) {
        return GestureDetector(
          onTap: () {
            indexProvider.setIndex = index;
            // push(FoodDetailScreen(food: foodsList[index]), context);
            foodCart.addFoodToCart(foodList[index]);
          },
          child: Stack(
            children: [
              menuItem(context, foodList, index),
              foodCart.isSelected(foodList[index])
                  ? Container(
                      decoration: BoxDecoration(
                        color: context.theme.primaryColor.withOpacity(0.1),
                        borderRadius: const BorderRadius.all(
                          Radius.circular(16),
                        ),
                      ),
                    )
                  : const SizedBox(),
              foodCart.isSelected(foodList[index])
                  ? Positioned.fill(
                      child: Align(
                        alignment: Alignment.center,
                        child: removeButton(
                          foodCart,
                          foodList,
                          index,
                          context.theme.primaryColor,
                        ),
                      ),
                    )
                  : const SizedBox(),
            ],
          ),
        );
      },
    );
  }

  //

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
              textAlign: TextAlign.center,
              style: context.textTheme.labelMedium,
              maxFontSize: 18,
              maxLines: 2,
            ),
          ],
        ),
      ),
    );
  }

  //

  Row removeButton(foodCart, foodList, index, color) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        GestureDetector(
          child: Icon(
            CupertinoIcons.trash_fill,
            color: color,
            size: 70,
          ),
          onTap: () {
            foodCart.removeFoodFromCart(foodList[index]);
          },
        )

        // Text(
        //   "${foodList[index].foodPrice}" "₺",
        //   style: context.textTheme.headline5!
        //       .copyWith(color: context.theme.primaryColor),
        // ),
      ],
    );
  }
}
