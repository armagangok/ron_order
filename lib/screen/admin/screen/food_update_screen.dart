// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../feature/components/chip_category_widget.dart';
import '../../../feature/components/food_grid_view_builder.dart';
import '../../../feature/models/food_model.dart';
import '../../../feature/viewmodel/chip_viewmodel.dart';
import '../../../feature/viewmodel/food_viewmodel.dart';

class FoodUpdateScreen extends StatelessWidget {
  const FoodUpdateScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ListView(
          shrinkWrap: true,
          physics: const ClampingScrollPhysics(),
          padding: const EdgeInsets.all(10),
          children: [
            const ChipCategoryWidgetBuilder(),
            Consumer(
              builder: (context, ChipViewmodel chipViewmodel, _) {
                String category = chipViewmodel.getChoosenCategory;

                return FutureBuilder<List<FoodModel>>(
                  future: FoodViewmodel().fetchFoodByCategory(category),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.done) {
                      var foodList = snapshot.data;
                      return GridViewBuilderWidget(
                        
                        foodList: foodList!,
                        isActivationWidget: true,
                      );
                    } else if (snapshot.connectionState ==
                        ConnectionState.waiting) {
                      return const Center(
                        child: Text("Waiting for data..."),
                      );
                    } else {
                      return const Center(
                        child: Text("Error occured."),
                      );
                    }
                  },
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
