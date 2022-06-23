import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../core/extension/context_extension.dart';
import '../../screen/admin/components/admin_food_widget.dart';
import '../../screen/admin/viewmodel/activation_viewmodel.dart';
import '../models/food_model.dart';
import '../../screen/home/components/food_widget.dart';

class GridViewBuilderWidget extends StatelessWidget {
  final List<FoodModel> foodList;
  final bool isActivationWidget;
  const GridViewBuilderWidget({
    Key? key,
    required this.foodList,
    this.isActivationWidget = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final h = context.getHeight(1.0);
    final w = context.getWidth(1.0);
    return GridView.builder(
      itemCount: foodList.length,
      physics: const ClampingScrollPhysics(),
      shrinkWrap: true,
      addAutomaticKeepAlives: false,
      addRepaintBoundaries: false,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 10,
        mainAxisExtent: h * (0.35),
        mainAxisSpacing: 10,
      ),
      itemBuilder: (context, index) {
        return Consumer(
          builder: (context, ActivationController foodActivation, child) {
            return isActivationWidget
                ? FoodWidgetAdmin(food: foodList[index])
                : FoodWidget(food: foodList[index]);
          },
        );
      },
    );
  }
}
