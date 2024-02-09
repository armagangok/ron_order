import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import './food_dialog.dart';
import '../../../core/extension/context_extension.dart';
import '../../../feature/models/food_model.dart';
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
