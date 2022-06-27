// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../core/extension/context_extension.dart';
import '../../../feature/components/chip_category_widget.dart';
import '../../../feature/components/food_grid_view_builder.dart';
import '../../../feature/viewmodel/chip_controller.dart';
import '../../../feature/viewmodel/food_viewmodel.dart';

class FoodUpdateScreen extends StatefulWidget {
  const FoodUpdateScreen({Key? key}) : super(key: key);

  @override
  State<FoodUpdateScreen> createState() => _FoodUpdateScreenState();
}

class _FoodUpdateScreenState extends State<FoodUpdateScreen> {
  final FoodViewmodel foodViewmodel = FoodViewmodel();

  @override
  void initState() {
    foodViewmodel.getAllFood();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    ChipController chipViewmodel = Provider.of<ChipController>(context);
    FoodViewmodel fmd = Provider.of<FoodViewmodel>(context);
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        body: SafeArea(
          child: ListView(
            shrinkWrap: true,
            physics: const ClampingScrollPhysics(),
            padding: EdgeInsets.all(context.getWidth(0.025)),
            children: [
              const ChipCategoryWidgetBuilder(),
              Consumer(
                builder: (context, ChipController chip, _) {
                  return fmd.all[chipViewmodel.chosenCategory]!.isNotEmpty
                      ? GridViewBuilderWidget(
                          foodList: fmd.all[chipViewmodel.chosenCategory]!,
                          isActivationWidget: true,
                        )
                      : const Center(
                          child: Text("Bu kategoride yemek bulunamadı."),
                        );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
