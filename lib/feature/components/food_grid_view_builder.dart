import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import './activation_widget.dart';
import '../../core/extension/context_extension.dart';
import '../../screen/admin/viewmodel/activation_viewmodel.dart';
import '../../screen/home/components/remove_food_widget.dart';
import '../models/food_model.dart';

class GridViewBuilderWidget extends StatelessWidget {
  final List<FoodModel> foodList;
  final bool isActivationWidget;
  const GridViewBuilderWidget({
    Key? key,
    required this.foodList,
    this.isActivationWidget = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final h = context.getHeight(1.0);
    final w = context.getWidth(1.0);
    return GridView.builder(
      itemCount: foodList.length,
      physics: const ClampingScrollPhysics(),
      shrinkWrap: true,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 10,
        mainAxisExtent: h * (0.36),
        mainAxisSpacing: 10,
      ),
      itemBuilder: (context, index) {
        return Consumer(
          builder: (context, ActivationViewmodel foodActivation, child) {
            return isActivationWidget
                ? ActivationWidget(food: foodList[index])
                : RemoveFoodWidget(food: foodList[index]);
          },
        );
      },
    );
  }
}
