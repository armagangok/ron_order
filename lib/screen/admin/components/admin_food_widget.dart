import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../core/extension/context_extension.dart';
import '../../../feature/components/activation_widget.dart';
import '../../../feature/models/food_model.dart';
import '../viewmodel/activation_viewmodel.dart';

class FoodWidgetAdmin extends StatelessWidget {
  const FoodWidgetAdmin({
    Key? key,
    required this.food,
  }) : super(key: key);

  final FoodModel food;

  @override
  Widget build(BuildContext context) {
    final ActivationViewmodel foodActivation =
        Provider.of<ActivationViewmodel>(context);

    final TextTheme textTheme = context.textTheme;
    final double height = context.getHeight(1);
    final double width = context.getWidth(1);
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
          buildFoodImage(textTheme, height, width),
          food.isActive ? const Center() : buildDeactivatedText(textTheme),
        ],
      ),
    );
  }

  //

  Positioned buildDeactivatedText(TextTheme textTheme) {
    return Positioned.fill(
      child: Align(
        child: Container(
          width: double.infinity,
          color: Colors.black.withOpacity(0.4),
          child: AutoSizeText(
            "Deactivated",
            textAlign: TextAlign.center,
            style: textTheme.headline5!.copyWith(
              color: Colors.white,
              fontWeight: FontWeight.w700,
            ),
            maxLines: 1,
          ),
        ),
      ),
    );
  }

  //

  Container buildFoodImage(TextTheme textTheme, double height, double width) {
    return Container(
      decoration: BoxDecoration(
        color: food.isActive ? Colors.white : Colors.black.withOpacity(0.3),
        borderRadius: const BorderRadius.all(Radius.circular(16)),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            width: double.infinity,
            height: height * 0.28,
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
          Container(
            color: Colors.amber,
            child: AutoSizeText(
              food.foodName,
              textAlign: TextAlign.center,
              style: textTheme.labelMedium,
              maxFontSize: 18,
              minFontSize: 16,
              maxLines: 2,
            ),
          ),
        ],
      ),
    );
  }
}

//

Future<void> deleteFoodDialog(context, FoodModel food) async {
  await showDialog(
    context: context,
    builder: (_) => DeleteFoodDialog(food: food),
  );
}
