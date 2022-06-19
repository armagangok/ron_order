import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

import '../../../feature/components/food_container.dart';
import '../../../core/extension/context_extension.dart';
import '../../../feature/models/food_model.dart';
import '../../../feature/viewmodel/food_viewmodel.dart';
import '../viewmodel/cart_viewmodel.dart';
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
        mainAxisExtent: context.getHeight(0.35),
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
              FoodContainer(food: foodList[index]),
              foodCart.isSelected(foodList[index])
                  ? Container(
                      decoration: BoxDecoration(
                        color: context.theme.primaryColor.withOpacity(0.1),
                        borderRadius:
                            const BorderRadius.all(Radius.circular(16)),
                      ),
                    )
                  : const SizedBox(),
              foodCart.isSelected(foodList[index])
                  ? Positioned.fill(
                      child: Align(
                        alignment: Alignment.center,
                        child: removeButton(
                          foodCart,
                          foodList[index],
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

  Row removeButton(foodCart, FoodModel food, color) {
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
            foodCart.removeFoodFromCart(food);
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
