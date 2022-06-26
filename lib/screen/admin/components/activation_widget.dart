import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../core/extension/context_extension.dart';
import '../../../feature/components/snackbar.dart';
import '../../../feature/models/food_model.dart';
import '../../../feature/viewmodel/food_viewmodel.dart';
import '../../home/components/food_widget.dart';
import '../viewmodel/activation_viewmodel.dart';

class ActivationWidget extends StatelessWidget {
  const ActivationWidget({
    Key? key,
    required this.food,
  }) : super(key: key);

  final FoodModel food;

  @override
  Widget build(BuildContext context) {
    final h = context.getHeight(1);
    final w = context.getWidth(1);

    return Consumer(
      builder: (context, ActivationController foodActivation, child) {
        return InkWell(
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
              FoodWidget(food: food),
              food.isActive
                  ? const SizedBox()
                  : Container(
                      height: h * 0.36,
                      width: h * 0.36,
                      decoration: BoxDecoration(
                        color: Colors.black.withOpacity(0.35),
                        borderRadius: const BorderRadius.all(
                          Radius.circular(16),
                        ),
                      ),
                      child: Align(
                        alignment: Alignment.center,
                        child: AutoSizeText(
                          "Deactivated",
                          // textAlign: TextAlign.center,
                          style: context.textTheme.headline5!.copyWith(
                            color: Colors.white,
                            fontWeight: FontWeight.w700,
                          ),

                          maxLines: 1,
                        ),
                      ),
                    )
            ],
          ),
        );
      },
    );
  }
}

Future<void> deleteFoodDialog(context, FoodModel food) async {
  await showDialog(
    context: context,
    builder: (_) => DeleteFoodDialog(food: food),
  );
}

class DeleteFoodDialog extends StatelessWidget {
  const DeleteFoodDialog({
    Key? key,
    required this.food,
  }) : super(key: key);

  final FoodModel food;

  @override
  Widget build(BuildContext context) {
    final FoodViewmodel foodProvider = Provider.of<FoodViewmodel>(context);
    return CupertinoAlertDialog(
      title: Column(
        children: [
          const Text("Do you want to delete the food?"),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              TextButton(
                onPressed: () async {
                  Navigator.pop(context);
                  ScaffoldMessenger.of(context).showSnackBar(
                    getSnackBar1(
                        "${food.foodName} isimli yemek , ${food.category} categorisinden silindi."),
                  );
                  await foodProvider.deleteFood(food);
                },
                child: const Text("Yes"),
              ),
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text("No"),
              )
            ],
          ),
        ],
      ),
    );
  }
}
