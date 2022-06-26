import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../feature/components/snackbar.dart';
import '../../../feature/models/food_model.dart';
import '../../../feature/viewmodel/food_viewmodel.dart';

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
          const Text("Yemeği silmek istiyor musunuz?"),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              TextButton(
                onPressed: () async {
                  await foodProvider
                      .deleteFood(food)
                      .whenComplete(() => Navigator.pop(context))
                      .whenComplete(
                        () => ScaffoldMessenger.of(context).showSnackBar(
                          getSnackBar1(
                              "${food.foodName} isimli yemek, ${food.category} kategorisinden silindi."),
                        ),
                      );
                },
                child: const Text("EVET"),
              ),
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text("İPTAL"),
              )
            ],
          ),
        ],
      ),
    );
  }
}
