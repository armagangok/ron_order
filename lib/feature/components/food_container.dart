import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

import '../models/food_model.dart';
import '../../core/extension/context_extension.dart';

class FoodContainer extends StatelessWidget {
  const FoodContainer({
    Key? key,
    required this.food,
  }) : super(key: key);

  final FoodModel food;

  @override
  Widget build(BuildContext context) {
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
              borderRadius: const BorderRadius.all(Radius.circular(16.0)),
              color: Colors.redAccent,
              image: DecorationImage(
                image: NetworkImage(food.imageUrl),
                fit: BoxFit.fill,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 3),
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
    );
  }
}
